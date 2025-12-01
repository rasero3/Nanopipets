library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

entity uart_receive is
	port(
			clk_rec: in std_logic;
			UART_RX_rec: in std_logic;
			DAC_SCLK_rec: buffer std_logic;
			DAC_SDI_rec: out std_logic;
			DAC_CS_rec: out std_logic;
			buffer_uart_rec: buffer std_logic_vector(23 downto 0);
			estado_uart: buffer integer range 0 to 3:=0;
			flag_uart: buffer std_logic:='0');
			
end uart_receive;

architecture comp of uart_receive is
	constant sync: std_logic_vector(23 downto 0):="000000100000000011111111";
	constant config: std_logic_vector(23 downto 0):="000000110000000000000000";
	constant gain: std_logic_vector(23 downto 0):="000001000000000000000000";
	constant trigger_on: std_logic_vector(23 downto 0):="000001010000000000010000";
	constant trigger_off: std_logic_vector(23 downto 0):="000001010000000000000000";
	
	constant CLK_FREQ: integer := 50000000;
	constant FSCV: integer := 10;
	constant BAUD_RATE: integer := 115200;
	constant BIT_TICKS: integer:= CLK_FREQ / BAUD_RATE;
	constant FSCV_TICKS: integer:= CLK_FREQ/FSCV;
	
	type buffer_array is array (0 to 7) of std_logic_vector (23 downto 0);
	type rampa_state is (subir, bajar, esperar);
	type rampa_array is array (0 to 7) of rampa_state;
	signal rampa: rampa_array:=(others=>subir);
 	signal matrix_goal, current_vector: buffer_array:=(others=>(others=>'0'));
	signal flag_clk, start_ramp, ramp_active: std_logic:='0';
	signal count: integer range 0 to 24:=0;
	signal estado: integer range 0 to 1:=0;
	signal RX_prev: std_logic;
	signal send: integer range 0 to 2:=0;
	signal uart_count: integer range 0 to BIT_TICKS+(BIT_TICKS/2):=0;
	signal byte_count: integer range 0 to 3:=0;
	signal bit_count, channel_count: integer range 0 to 8:=0;
	signal index: integer range 0 to 16;
	signal FSCV_count:integer range 0 to FSCV_TICKS:=FSCV_TICKS-1;
	signal addr_byte: std_logic_vector(3 downto 0);
	signal flag_ramp_end:std_logic_vector (7 downto 0);
	
begin
	
	DAC_SCLK_rec<=clk_rec when (flag_clk = '1') else '0';
	process(clk_rec)

	begin
	if rising_edge(clk_rec) then
		RX_prev<=UART_RX_rec;
		if (UART_RX_rec = '0' and RX_prev = '1') then
			flag_uart<='1';
		end if;
		
		case estado is
		when 0 =>
			if count < 24 then
				flag_clk<='1';
				DAC_CS_rec<='0';
				DAC_SDI_rec<=sync(23-count);
				count<= count + 1;
			else
				report "CONFIG ENVIADA";
				count<=0;
				flag_clk<='0';
				DAC_CS_rec<='1';
				estado<=1;
			end if;
		
		when 1=>
			DAC_CS_rec<='1';
			flag_clk<='0';
		end case;
		
		case estado_uart is
		when 0=>
			
			if flag_uart = '1' then	
				start_ramp<='0';
				if uart_count < BIT_TICKS+(BIT_TICKS/2) then
					uart_count<=uart_count+1;
				else
					if byte_count = 2 and bit_count = 7 and UART_RX_rec='1' then --detectar si el MSB del primer byte es distinto a 0
						report "Numero inesperado encontrado";
						uart_count<=0;
					else
						buffer_uart_rec(byte_count*8+bit_count)<=UART_RX_rec;
						estado_uart<=1;
						uart_count<=0;
						bit_count<=bit_count+1;
					end if;
				end if;
			end if;
		
		when 1=>
			flag_uart<='0';
			if bit_count<8 then
				if uart_count < BIT_TICKS then
					uart_count<=uart_count+1;
				else
					buffer_uart_rec(byte_count*8 + bit_count)<=UART_RX_rec;
					uart_count<=0;
					bit_count<=bit_count+1;
				end if;
			else
				byte_count<=byte_count+1;
				estado_uart<=2;
				uart_count<=0;
				bit_count<=0;
			end if;
		
		when 2=>
			flag_uart<='0';
			if byte_count<3 then
				estado_uart<=0;
			else
				estado_uart<=3;
				byte_count<=0;
				bit_count<=0;
				count<=0;
			end if;
			
		when 3=>
			flag_uart<='0';
			if uart_count < BIT_TICKS then
				uart_count<=uart_count+1;
			else
				uart_count<=0;
				if channel_count < 7 then
					current_vector(channel_count)(23 downto 16)<=buffer_uart_rec(23 downto 16);
					matrix_goal(channel_count)<=buffer_uart_rec;
					estado_uart<=0;
					channel_count<=channel_count+1;
					report "almacenado el canal: " & integer'image(channel_count);
				elsif channel_count = 7 then
					current_vector(channel_count)(23 downto 16)<=buffer_uart_rec(23 downto 16);
					report "almacenado el canal: " & integer'image(channel_count);
					matrix_goal(channel_count)<=buffer_uart_rec;
					estado_uart<=0;
					start_ramp<='1';
					report "se empiezan las rampas";
				end if;
			end if;
		end case;
		
		if start_ramp = '1' then
			ramp_active <='1';
			channel_count<=0;
		end if;
		
		if ramp_active = '1' then
			if FSCV_count < FSCV_TICKS then
				FSCV_count<=FSCV_count +1;
			else
				flag_ramp_end<=(others=>'0');
				rampa<=(others=>subir);
				FSCV_count<=0;
			end if;
			
			case send is
			when 0=>
				if channel_count < 8 then
					case rampa(channel_count) is
					when subir=> --subir
						if flag_ramp_end(channel_count)='1' then
							channel_count<=channel_count+1;
						else
							if current_vector(channel_count) < matrix_goal(channel_count) then --esta por debajo del pico
								if count < 24 then --envia y pasa al siguiente canal
									DAC_CS_rec<='0';
									flag_clk<='1';
									DAC_SDI_rec<=current_vector(channel_count)(23-count); 
									count<=count+1;
								else
									report "se ha actualizado un canal";
									current_vector(channel_count)<=std_logic_vector(unsigned(current_vector(channel_count))+1);--al enviarlo se establece el siguiente valor
									DAC_CS_rec<='1';
									flag_clk<='0';
									count<=0;
									channel_count<=channel_count+1;
								end if;
							else --llega al pico
								report "se ha llegado al pico del canal: " & integer'image(channel_count);
								rampa(channel_count)<=bajar;--bajar
								matrix_goal(channel_count)(15 downto 0)<=(others=>'0');--establecer el siguiente objetivo a 0
							end if;
						end if;
					
					when bajar=>--bajar
						if current_vector(channel_count) > matrix_goal(channel_count) then
							if count < 24 then
								DAC_CS_rec<='0';
								flag_clk<='1';
								DAC_SDI_rec<=current_vector(channel_count)(23-count); 
								count<=count+1;
							else
								current_vector(channel_count)<=std_logic_vector(unsigned(current_vector(channel_count))-1);--al enviarlo se establece el siguiente valor
								DAC_CS_rec<='1';
								flag_clk<='0';
								count<=0;
								channel_count<=channel_count+1;
							end if;
						else--fin de la rampa
							rampa(channel_count)<=esperar;
							report "fin de la rampa: " & integer'image(channel_count);
							flag_ramp_end(channel_count)<='1';
							channel_count<=channel_count+1;
							
						end if;
					
					when esperar =>
						if channel_count<8 then
							channel_count<=channel_count+1;
						else
							send<=1;
						end if;
					end case;
				else
					send<=1;
				end if;
				
			when 1=>--acciona el trigger del DAC
				if count<24 then
					DAC_CS_rec<='0';
					flag_clk<='1';
					DAC_SDI_rec<=trigger_on(23-count);
					count<=count+1;
				else
					DAC_CS_rec<='0';
					count<=0;
					send<=2;
				end if;
			
			when 2=>
				if count<24 then
					DAC_CS_rec<='0';
					flag_clk<='1';
					DAC_SDI_rec<=trigger_off(23-count);
					count<=count+1;
				else
					DAC_CS_rec<='0';
					count<=0;
					send<=0;
					channel_count<=0;
				end if;
			end case;
		end if;
	end if;
	end process;
end comp;
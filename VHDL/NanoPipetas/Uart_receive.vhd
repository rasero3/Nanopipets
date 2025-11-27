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
			buffer_uart_rec: buffer std_logic_vector(23 downto 0):=(others=>'0');
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
	
	type buffer_array is array (0 to 7) of std_logic_vector (15 downto 0);
	signal matrix_goal, current_vector: buffer_array:=(others=>(others=>'0'));
	signal flag_clk, start_ramp: std_logic:='0';
	signal count: integer range 0 to 24:=0;
	signal estado: integer range 0 to 1:=0;
	signal RX_prev: std_logic:='1';
	signal uart_count: integer range 0 to BIT_TICKS+(BIT_TICKS/2):=0;
	signal byte_count, rampa: integer range 0 to 3:=0;
	signal bit_count, channel_count, index: integer range 0 to 8:=0;
	signal FSCV_count:integer range 0 to FSCV_TICKS:=0;
	signal flag_ramp_end:std_logic_vector (7 downto 0);
	
begin
	
	DAC_SCLK_rec<=clk_rec when (flag_clk = '1') else '0';
	process(clk_rec)

	begin
	
	if rising_edge(clk_rec) then
		case estado is
		when 0 =>
			if count < 24 then
				flag_clk<='1';
				DAC_CS_rec<='0';
				DAC_SDI_rec<=sync(23-count);
				count<= count + 1;
			else
				count<=0;
				flag_clk<='0';
				DAC_CS_rec<='1';
				estado<=1;
			end if;
		
		when 1=>
			DAC_CS_rec<='1';
			flag_clk<='0';
			RX_prev<=UART_RX_rec;
			if UART_RX_rec = '0' and RX_prev = '1' then
				flag_uart<='1';
			end if;
			
			if flag_uart = '1' then
				estado_uart<=0;
			else
				estado_uart<=3;
			end if;
		end case;
		
		case estado_uart is
		when 0=>
			if uart_count < BIT_TICKS+(BIT_TICKS/2) then
				uart_count<=uart_count+1;
			else
				if byte_count = 0 and bit_count = 0 and UART_RX_rec='1' then --detectar si el MSB del primer byte es distinto a 0
					flag_uart<='0';
					uart_count<=0;
				else
					buffer_uart_rec(byte_count*8+bit_count)<=UART_RX_rec;
					estado_uart<=1;
					bit_count<=bit_count+1;
				end if;
			end if;
		
		when 1=>
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
			if byte_count<3 then
				estado_uart<=0;
			else
				flag_uart<='0';
				byte_count<=0;
			end if;
			
		when 3=>
			index<=to_integer(unsigned(buffer_uart_rec(7 downto 0)))-8;
			if channel_count < 8 then
				matrix_goal(index)<=buffer_uart_rec(23 downto 8);
				flag_uart<='1';
			else
				channel_count<=0;
				start_ramp<='1';
			end if;
			
			if start_ramp = '1' then
				if FSCV_count < FSCV_TICKS then
					FSCV_count<=FSCV_count +1;
				else
					flag_ramp_end<=(others=>'0');
					rampa<=0;
					FSCV_count<=0;
				end if;
					case rampa is
					when 0=> --subir
						if channel_count < 8 then
							if flag_ramp_end(channel_count)='1' then
								channel_count<=channel_count+1;
							else
								if current_vector(channel_count) < matrix_goal(channel_count) then --esta por debajo del pico
									if count < 24 then --envia y pasa al siguiente canal
										DAC_CS_rec<='0';
										flag_clk<='1';
										DAC_SDI_rec<=current_vector(channel_count)(count); 
										count<=count+1;
									else
										current_vector(channel_count)<=std_logic_vector(unsigned(current_vector(channel_count))+1);--al enviarlo se establece el siguiente valor
										DAC_CS_rec<='1';
										flag_clk<='0';
										count<=0;
										channel_count<=channel_count+1;
									end if;
								else --llega al pico
									rampa<=1;--bajar
									matrix_goal(channel_count)<=(others=>'0');--establecer el siguiente objetivo a 0
								end if;
							end if;
						else --ha actualizado todos los canales
							rampa<=2;--trigger
							channel_count<=0;
						end if;
					
					when 1=>--bajar
						if current_vector(channel_count) > matrix_goal(channel_count) then
							if count < 24 then
								DAC_CS_rec<='0';
								flag_clk<='1';
								DAC_SDI_rec<=current_vector(channel_count)(count); 
								count<=count+1;
							else
								current_vector(channel_count)<=std_logic_vector(unsigned(current_vector(channel_count))-1);--al enviarlo se establece el siguiente valor
								DAC_CS_rec<='1';
								flag_clk<='0';
								count<=0;
								channel_count<=channel_count+1;
								rampa<=0;
							end if;
						else
							channel_count<=channel_count+1;
							flag_ramp_end(channel_count)<='1';
						end if;
						
					when 2=>--acciona el trigger del DAC
						if count<24 then
							DAC_CS_rec<='0';
							flag_clk<='1';
							DAC_SDI_rec<=trigger_on(count);
							count<=count+1;
						else
							DAC_CS_rec<='0';
							count<=0;
							rampa<=3;
						end if;
					
					when 3=>
						if count<24 then
							DAC_CS_rec<='0';
							flag_clk<='1';
							DAC_SDI_rec<=trigger_off(count);
							count<=count+1;
						else
							DAC_CS_rec<='0';
							count<=0;
							rampa<=0;
						end if;
					end case;
			end if;
		end case;
						
	end if;
	end process;
end comp;
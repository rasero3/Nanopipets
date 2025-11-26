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
	constant CLK_FREQ: integer := 50000000;
	constant FSCV: integer := 10;
	constant BAUD_RATE: integer := 115200;
	constant BIT_TICKS: integer:= CLK_FREQ / BAUD_RATE;
	constant FSCV_TICKS: integer:= CLK_FREQ/FSCV;
	
	signal estado: integer range 0 to 3:=0;

	type buffer_array is array (0 to 7) of std_logic_vector (15 downto 0);
	signal bit_count: integer range 0 to 8:=0;
	signal cont: integer range 0 to 24:=0;
	signal flag_clk: std_logic:='0';
	signal index: integer range 0 to 16:=0;
	signal un_byte: std_logic_vector (7 downto 0):=(others=>'0');
	signal RX_previo: std_logic:='0';
	signal uart_count: integer range 0 to BIT_TICKS+(BIT_TICKS/2):=0;
	signal FSCV_count: integer range 0 to FSCV_TICKS:=0;
	signal flag_byte_finish: std_logic:='0';
	signal byte_count: integer range 0 to 3:=0;
	signal position: integer range 0 to 65535:=0;
	signal buffer_objetivo: buffer_array:=(others=>(others=>'0'));
	signal current_msg: buffer_array:=(others=>(others=>'0'));
	signal dac_update_state: integer range 0 to 4:=0;

	
begin
	DAC_SCLK_rec<=clk_rec when (flag_clk = '1') else '0';
	process(clk_rec)
	constant sync: std_logic_vector(23 downto 0):="000000100000000011111111";
	constant config: std_logic_vector(23 downto 0):="000000110000000000000000";
	constant gain: std_logic_vector(23 downto 0):="000001000000000000000000";
	constant trigger_on: std_logic_vector(23 downto 0):="000001010000000000010000";
	constant trigger_off: std_logic_vector(23 downto 0):="000001010000000000000000";
	begin
	
	if rising_edge(clk_rec) then
		case estado is
		when 0 =>
			if cont < 24 then
				flag_clk<='1';
				DAC_CS_rec<='0';
				DAC_SDI_rec<=sync(cont);
				cont<=cont+1;
			else
				flag_clk<='0';
				cont<=0;
				
				estado<=estado+1;
				DAC_CS_rec<='1';
			end if;
			
		when 1 =>
			if cont < 24 then
				flag_clk<='1';
				DAC_SDI_rec<=config(cont);
				cont<=cont+1;
				DAC_CS_rec<='0';
				
			else
				flag_clk<='0';
				cont<=0;
				estado<=estado+1;
				
				DAC_CS_rec<='1';
			end if;
			
		when 2 =>
			if cont < 24 then
				flag_clk<='1';
				DAC_SDI_rec<=gain(cont);
				cont<=cont+1;
				DAC_CS_rec<='0';
				
			else
				flag_clk<='0';
				cont<=0;
				estado<=estado+1;
				
				DAC_CS_rec<='1';
			end if; 
			
		when 3 =>
			flag_clk<='0';
			if UART_RX_rec = '0' then
				flag_uart <= '1';
			end if;
			
			RX_previo<=UART_RX_rec;
			
			if flag_uart = '1' then
				case estado_uart is
				when 0 =>
					DAC_CS_rec<='1';
					flag_clk<='0';
					if uart_count < BIT_TICKS+(BIT_TICKS/2) then
						uart_count<=uart_count+1;
					else
						if byte_count < 1 and UART_RX_rec = '1' then
							estado_uart<=0;
							flag_uart<='0';
						else
							buffer_uart_rec(byte_count*8+bit_count)<=UART_RX_rec;
							estado_uart<=1;
							uart_count<=0;
							bit_count<=bit_count+1;
						end if;
					end if;
					
				when 1 =>
					DAC_CS_rec<='1';
					flag_clk<='0';
					if uart_count < BIT_TICKS then
						uart_count<=uart_count+1;
					else
						if bit_count < 8 then
							buffer_uart_rec(byte_count*8+bit_count)<=UART_RX_rec;
							bit_count <=bit_count + 1;
							uart_count<=0;
						else
							estado_uart<=2;
							byte_count<=byte_count+1;
							uart_count<=0;
							bit_count<=0;
						end if;
					end if;
					
				when 2 =>
					DAC_CS_rec<='1';
					flag_clk<='0';

					if byte_count<3 then
						flag_uart<='0';
						estado_uart<=0;
						uart_count<=0;
					else
						if bit_count < 8 then
							un_byte(bit_count)<=buffer_uart_rec(7-bit_count);
							report "vamos por el: " &  std_logic'image(buffer_uart_rec(7-bit_count));
							bit_count<=bit_count+1;
						else
							uart_count<=0;
							byte_count<=0;
							estado_uart<=3;
							bit_count<=0;
						end if;
					end if;
					
				when 3 =>
					DAC_CS_rec<='1';
					flag_clk<='0';
					index<=(to_integer(unsigned(un_byte(7 downto 0))));
					report "Indice = " & integer'image(index);
					report "es el inverso de: " & integer'image(to_integer(unsigned(buffer_uart_rec(7 downto 0))));
					--buffer_objetivo(index)<=buffer_uart_rec(23 downto 8);
					estado_uart<=0;
					buffer_uart_rec<=(others=>'0');
					un_byte<=(others=>'0');
				end case;
				
			else
				estado_uart<=0;
				case dac_update_state is
				when 0 =>
					if bit_count < 8 then
						if current_msg(bit_count) < buffer_objetivo(bit_count)then
							if cont < 24 then
								DAC_CS_rec<='0';
								flag_clk<='1';
								DAC_SDI_rec<=current_msg(bit_count)(cont);
							else
								flag_clk<='0';
								DAC_CS_rec<='1';
								current_msg(bit_count)<=std_logic_vector(unsigned(current_msg(bit_count))+1);
								cont<=0;
								bit_count<=bit_count+1;
							end if;
						else
							dac_update_state<=1;
						end if;
					else
						dac_update_state<=2;
						bit_count<=0;
						cont<=0;
					end if;
					
				when 1 =>
					if bit_count < 8 then
						if current_msg(bit_count) > buffer_objetivo(bit_count) then
							if cont< 24 then
								DAC_CS_rec<='0';
								flag_clk<='1';
								DAC_SDI_rec<=current_msg(bit_count)(cont);
							else
								DAC_CS_rec<='1';
								flag_clk<='0';
								cont<=0;
								bit_count<=bit_count+1;
								current_msg(bit_count)<=std_logic_vector(unsigned(current_msg(bit_count))-1);
							end if;
						else
							dac_update_state<=3;
						end if;
					else
						dac_update_state<=2;
						bit_count<=0;
						cont<=0;
					end if;
				
				when 2=>
					if cont<24 then
						DAC_cS_rec<='0';
						flag_clk<='1';
						DAC_SDI_rec<=trigger_on(cont);
					else
						flag_clk<='1';
						DAC_CS_rec<='1';
						cont<=0;
						dac_update_state<=3;
					end if;
					
				when 3=>
					if cont<24 then
						DAC_CS_rec<='0';
						flag_clk<='1';
						DAC_SDI_rec<=trigger_off(cont);
					else
						flag_clk<='1';
						DAC_CS_rec<='1';
						cont<=0;
						dac_update_state<=0;
					end if;
							
				when 4=>
					DAC_CS_rec<='1';	
					flag_clk<='1';
					if FSCV_count < FSCV_TICKS then
						FSCV_count<=FSCV_count+1;
					else
						FSCV_count<=0;
						current_msg<=(others=>(others=>'0'));
						dac_update_state<=0;
					end if;
				end case;
			end if;
		end case;
	end if;
	end process;
end comp;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

entity uart_receive is
	port(clk_rec: in std_logic;
			UART_RX_rec: in std_logic;
			DAC_SCLK_rec: buffer std_logic;
			DAC_SDI_rec: out std_logic;
			DAC_CS_rec: out std_logic;
			buffer_uart_rec: buffer std_logic_vector(23 downto 0);
			estado_uart: buffer integer range 0 to 3:=0;
			flag_uart: buffer std_logic:='0');
			
end uart_receive;

architecture comp of uart_receive is
	constant CLK_FREQ     : integer := 50000000;
	constant BAUD_RATE    : integer := 115200;
	constant BIT_TICKS    : integer := CLK_FREQ / BAUD_RATE;
	signal estado: integer range 0 to 3:=0;

	signal bit_count: integer range 0 to 8:=0;
	signal cont: integer range 0 to 24:=0;
	signal flag_clk: std_logic:='0';
	signal RX_previo: std_logic:='0';
	signal uart_count: integer range 0 to BIT_TICKS+(BIT_TICKS/2):=0;
	signal flag_byte_finish: std_logic:='0';
	signal byte_count: integer range 0 to 3:=0;

	
	
begin
	DAC_SCLK_rec<=clk_rec when (flag_clk = '1') else '0';
	process(clk_rec)
	constant sync: std_logic_vector(23 downto 0):="000000101111111100000000";
	constant config: std_logic_vector(23 downto 0):="000000110000000000000000";
	constant gain: std_logic_vector(23 downto 0):="000001000000000000000000";
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
						buffer_uart_rec(byte_count*8+bit_count)<=UART_RX_rec;
						estado_uart<=1;
						uart_count<=0;
						bit_count<=bit_count+1;
						
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
						uart_count<=0;
						estado_uart<=3;
					end if;
					
				when 3 =>
					if cont < 24 then
						flag_clk<='1';
						DAC_CS_rec<='0';
						DAC_SDI_rec<=buffer_uart_rec(cont);
						cont<=cont+1;
					else
						buffer_uart_rec<=(others=>'0');
						flag_clk<='0';
						cont<=0;
						DAC_CS_rec<='1';
						estado_uart<=0;
						estado<=3;
						flag_uart<='0';
						byte_count<=0;
					end if;
					
				end case;
				
			end if;
			
		end case;
	end if;
	end process;
end comp;
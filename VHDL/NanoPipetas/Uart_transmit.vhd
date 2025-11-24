library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Uart_transmit is
	port(
		clk_trans: in  std_logic;
		UART_TX_trans: out std_logic;
		ADC1_SDOA_trans: in  std_logic;
		ADC1_SDOB_trans: in  std_logic;
		ADC1_SDOC_trans: in  std_logic;
		ADC1_SDOD_trans: in  std_logic;
		ADC1_SCLK_trans: out std_logic;
		ADC1_CS_trans: out std_logic;
		ADC2_SDOA_trans: in  std_logic;
		ADC2_SDOB_trans: in  std_logic;
		ADC2_SDOC_trans: in  std_logic;
		ADC2_SDOD_trans: in  std_logic;
		ADC2_SCLK_trans: out std_logic;
		ADC2_CS_trans: out std_logic;
		estado_uart_trans: buffer integer range 0 to 3:=0;
		estado_default_trans: buffer integer range 0 to 2:=0;
		senal_prueba: buffer std_logic_vector(7 downto 0):=(others=>'0')
	);
end Uart_transmit;

architecture comp of Uart_transmit is
		constant CLK_FREQ     : integer := 50000000;
		constant BAUD_RATE    : integer := 115200;
		constant BIT_TICKS    : integer := CLK_FREQ / BAUD_RATE;

		type array_adc is array (0 to 3) of std_logic_vector (15 downto 0);
		type array2 is array (0 to 1) of array_adc;
		signal adc_signal: array2;
		signal count_bits: integer range 0 to 16:=0;
		signal count_channel: integer range 0 to 4:=0;
		signal count_adc: integer range 0 to 2:=0;
		signal byte_count: integer range 0 to 3:=0;
		signal flag_clk: std_logic:='0'; 
		signal cont: integer range 0 to BIT_TICKS;
		signal num_channels: integer range 0 to 8:=0;
		signal address: std_logic_vector(7 downto 0);
		signal estado_byte: integer range 0 to 2:=0;

begin
	ADC1_SCLK_trans<=clk_trans when flag_clk = '1' else '1';
	ADC2_SCLK_trans<=clk_trans when flag_clk = '1' else '1';
	process(clk_trans)
		constant mask: std_logic_vector(23 downto 0):="000000000000000000000000";
		begin
		if rising_edge(clk_trans) then
		
			case estado_default_trans is
			when 0 =>
				UART_TX_trans<='1';
				if count_bits<16 then
					ADC1_CS_trans<='0';
					ADC2_CS_trans<='0';
					flag_clk<='1';
					adc_signal(0)(0)(count_bits)<=ADC1_SDOA_trans;
					adc_signal(0)(1)(count_bits)<=ADC1_SDOB_trans;
					adc_signal(0)(2)(count_bits)<=ADC1_SDOC_trans;
					adc_signal(0)(3)(count_bits)<=ADC1_SDOD_trans;
					adc_signal(1)(0)(count_bits)<=ADC2_SDOA_trans;
					adc_signal(1)(1)(count_bits)<=ADC2_SDOB_trans;
					adc_signal(1)(2)(count_bits)<=ADC2_SDOC_trans;
					adc_signal(1)(3)(count_bits)<=ADC2_SDOD_trans;
					count_bits<=count_bits+1;
				else
					ADC1_CS_trans<='1';
					ADC2_CS_trans<='1';
					flag_clk<='0';
					estado_default_trans<=1;
				end if;
				
			when 1=>
				UART_TX_trans<='1';
				if count_adc < 2 then
					 if count_channel < 4 then
						  if adc_signal(count_adc)(count_channel) > mask then
								senal_prueba(count_adc*4 + count_channel) <= '1';
								count_channel <= count_channel + 1;
						  else
								senal_prueba(count_adc*4 + count_channel) <= '0';
								count_channel <= count_channel + 1;
						  end if;
					 else
						  count_channel <= 0;
						  count_adc <= count_adc + 1;
					 end if;
				else
					 estado_default_trans <= 2;
				end if;

			when 2 =>
			
				case estado_uart_trans is
				when 0 =>
					if num_channels<8 then
						if senal_prueba(num_channels)='1' then
							address<=std_logic_vector(to_unsigned(num_channels, 8));
							estado_uart_trans<=1;
						else
							num_channels<=num_channels +1;
						end if;
					else
						estado_default_trans<=0;
					end if;
					
				when 1 =>
					if cont < BIT_TICKS then
						UART_TX_trans<='0';
						cont<=cont+1;
					else
						cont<=0;
						count_bits<=0;
						estado_uart_trans<=2;
					end if;
					
				when 2 =>
				
					if byte_count = 0 then
						if count_bits < 8 then
							if cont < BIT_TICKs then
								UART_TX_trans<=address(7-count_bits);
								cont<=cont+1;
							else
								count_bits<=count_bits+1;
								cont<=0;
							end if;
						else
							estado_uart_trans<=3;
							count_bits<=0;
							cont<=0;
							byte_count<=byte_count+1;
						end if;
					end if;
						
					if byte_count > 0 then
						if count_bits < 8 then
							if cont < BIT_TICKs then
								UART_TX_trans<=adc_signal(num_channels/4)(num_channels mod 4)(count_bits+(byte_count-1)*8);
								cont<=cont+1;
							else 
								count_bits<=count_bits+1;
								cont<=0;
							end if;
						else
							count_bits<=0;
							estado_uart_trans<=3;
							byte_count<=byte_count+1;
						end if;
					end if;
					
				when 3 =>
					if cont < BIT_TICKS then
						UART_TX_trans<='1';
						cont<=cont+1;
					else
						cont<=0;
						if byte_count < 3 then
							estado_uart_trans<=1;
						else
							senal_prueba(num_channels)<='0';
							estado_uart_trans<=0;
							byte_count<=0;
						end if;
					end if;
					
				end case;
				
			end case;
			
		end if;
	end process;
end comp;
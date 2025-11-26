library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

entity NanoPipets_TB is
end NanoPipets_TB;

architecture TB of NanoPipets_TB is

component NanoPipets is
port( clk: in std_logic;
		UART_RX: in std_logic;
		DAC_SCLK: buffer std_logic;
		DAC_SDI, DAC_CS: out std_logic;
		flag: buffer std_logic;
		buffer_uart: buffer std_logic_vector(23 downto 0);
		uart_estado: buffer integer range 0 to 2:=0;
		
		UART_TX: out std_logic;
		ADC1_SDOA, ADC1_SDOB, ADC1_SDOC, ADC1_SDOD: in std_logic;
		ADC1_SCLK, ADC1_CS: out std_logic;
		ADC2_SDOA, ADC2_SDOB, ADC2_SDOC, ADC2_SDOD: in std_logic;
		senal: buffer std_logic_vector(7 downto 0);
		estado_uart_adc: buffer integer range 0 to 5;
		estado_default: buffer integer range 0 to 2;
		ADC2_SCLK, ADC2_CS: out std_logic);
end component;

signal clk_TB: std_logic;
signal UART_RX_TB: std_logic;
signal DAC_SCLK_TB, DAC_SDI_TB, DAC_CS_TB: std_logic;
signal flag_TB: std_logic;
signal buffer_uart_TB: std_logic_vector(23 downto 0);
signal UART_TX_TB: std_logic;
signal ADC1_SDOA_TB, ADC1_SDOB_TB, ADC1_SDOC_TB, ADC1_SDOD_TB: std_logic;
signal ADC1_SCLK_TB, ADC1_CS_TB: std_logic;
signal ADC2_SDOA_TB, ADC2_SDOB_TB, ADC2_SDOC_TB, ADC2_SDOD_TB: std_logic;
signal ADC2_SCLK_TB, ADC2_CS_TB: std_logic;
signal estado_uart_TB: integer range 0 to 3;
signal estado_uart_trans_TB: integer range 0 to 5;
signal estado_default_TB: integer range 0 to 2;
signal senal_estado: std_logic_vector(7 downto 0);

begin
uut: NanoPipets port map
	(flag=>flag_TB, uart_estado=>estado_uart_TB, clk=>clk_TB, UART_RX=>UART_RX_TB, DAC_SCLK=>DAC_SCLK_TB, DAC_SDI=>DAC_SDI_TB, DAC_CS=>DAC_CS_TB, buffer_uart=>buffer_uart_TB,
	UART_TX=>UART_TX_TB, ADC1_SDOA=>ADC1_SDOA_TB, ADC1_SDOB=>ADC1_SDOB_TB, ADC1_SDOC=>ADC1_SDOC_TB, ADC1_SDOD=>ADC1_SDOD_TB, ADC1_SCLK=>ADC1_SCLK_TB, ADC1_CS=>ADC1_CS_TB,
	ADC2_SDOA=>ADC2_SDOA_TB, senal=>senal_estado, estado_default=>estado_default_TB, estado_uart_adc=>estado_uart_trans_TB, ADC2_SDOB=>ADC2_SDOB_TB, ADC2_SDOC=>ADC2_SDOC_TB, ADC2_SDOD=>ADC2_SDOD_TB, ADC2_SCLK=>ADC2_SCLK_TB, ADC2_CS=>ADC2_CS_TB);
	
	reloj: process
	begin
		clk_TB<='0';
		wait for 10 ns;
		clk_TB<='1';
		wait for 10 ns;
	end process reloj;
	
	receive: process
	begin
		UART_RX_TB<='1';
		wait for 10 us;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='0'; --bit 0
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 1
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 2
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 3
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 4
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 5
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 6
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 7
		wait for 8680 ns;
		
		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='1'; --bit 8
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 9
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 10
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 11
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 12
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 13
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 14
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 15
		wait for 8680 ns;
		

		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --bit 16
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 17
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 18
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 19
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 20
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 21
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 22
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 23
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --end bit
		wait for 1 us;
		
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='0'; --bit 0
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 1
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 2
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 3
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 4
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 5
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 6
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 7
		wait for 8680 ns;
		
		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='1'; --bit 8
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 9
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 10
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 11
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 12
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 13
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 14
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 15
		wait for 8680 ns;
		

		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --bit 16
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 17
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 18
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 19
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 20
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 21
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 22
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 23
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --end bit
		wait for 1 us;
		
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='0'; --bit 0
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 1
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 2
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 3
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 4
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 5
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 6
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 7
		wait for 8680 ns;
		
		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='1'; --bit 8
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 9
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 10
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 11
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 12
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 13
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 14
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 15
		wait for 8680 ns;
		

		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --bit 16
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 17
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 18
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 19
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 20
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 21
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 22
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 23
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --end bit
		wait for 1 us;
		
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='0'; --bit 0
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 1
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 2
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 3
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 4
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 5
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 6
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 7
		wait for 8680 ns;
		
		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='1'; --bit 8
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 9
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 10
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 11
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 12
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 13
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 14
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 15
		wait for 8680 ns;
		

		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --bit 16
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 17
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 18
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 19
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 20
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 21
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 22
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 23
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --end bit
		wait for 1 us;
		
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='0'; --bit 0
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 1
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 2
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 3
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 4
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 5
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 6
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 7
		wait for 8680 ns;
		
		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='1'; --bit 8
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 9
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 10
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 11
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 12
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 13
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 14
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 15
		wait for 8680 ns;
		

		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --bit 16
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 17
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 18
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 19
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 20
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 21
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 22
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 23
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --end bit
		wait for 1 us;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='0'; --bit 0
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 1
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 2
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 3
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 4
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 5
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 6
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 7
		wait for 8680 ns;
		
		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='1'; --bit 8
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 9
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 10
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 11
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 12
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 13
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 14
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 15
		wait for 8680 ns;
		

		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --bit 16
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 17
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 18
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 19
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 20
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 21
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 22
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 23
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --end bit
		wait for 1 us;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='0'; --bit 0
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 1
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 2
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 3
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 4
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 5
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 6
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 7
		wait for 8680 ns;
		
		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='1'; --bit 8
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 9
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 10
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 11
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 12
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 13
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 14
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 15
		wait for 8680 ns;
		

		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --bit 16
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 17
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 18
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 19
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 20
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 21
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 22
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 23
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --end bit
		wait for 1 us;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='0'; --bit 0
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 1
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 2
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 3
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 4
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 5
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 6
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 7
		wait for 8680 ns;
		
		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;
		
		UART_RX_TB<='1'; --bit 8
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 9
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 10
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 11
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 12
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 13
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 14
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 15
		wait for 8680 ns;
		

		UART_RX_TB<='1';
		wait for 8680 ns;
		UART_RX_TB<='0'; --start bit
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --bit 16
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 17
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 18
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 19
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 20
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 21
		wait for 8680 ns;
		UART_RX_TB<='1'; --bit 22
		wait for 8680 ns;
		UART_RX_TB<='0'; --bit 23
		wait for 8680 ns;

		
		UART_RX_TB<='1'; --end bit
		wait;
	end process receive;
	
	send: process
	begin
		wait for 10 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0';
		wait for 20 ns;
		ADC1_SDOA_TB<='1';
		ADC1_SDOB_TB<='1';
		ADC1_SDOC_TB<='1';
		ADC1_SDOD_TB<='1';
		ADC2_SDOA_TB<='1';
		ADC2_SDOB_TB<='1';
		ADC2_SDOC_TB<='1';
		ADC2_SDOD_TB<='1'; --bit 1
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 2
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 3
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 4
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 5
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 6
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 7
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 8
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 9
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 10
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 11
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 12
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 13
		wait for 20 ns;
		ADC1_SDOA_TB<='1';
		ADC1_SDOB_TB<='1';
		ADC1_SDOC_TB<='1';
		ADC1_SDOD_TB<='1';
		ADC2_SDOA_TB<='1';
		ADC2_SDOB_TB<='1';
		ADC2_SDOC_TB<='1';
		ADC2_SDOD_TB<='1'; --bit 14
		wait for 20 ns;
		ADC1_SDOA_TB<='0';
		ADC1_SDOB_TB<='0';
		ADC1_SDOC_TB<='0';
		ADC1_SDOD_TB<='0';
		ADC2_SDOA_TB<='0';
		ADC2_SDOB_TB<='0';
		ADC2_SDOC_TB<='0';
		ADC2_SDOD_TB<='0'; --bit 15
		
		wait for 2089370 ns;
		
	end process send;
	
end TB;
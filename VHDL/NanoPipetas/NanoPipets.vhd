library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

entity NanoPipets is
	port(
			clk: in std_logic;
			UART_RX: in std_logic;
			DAC_SCLK: buffer std_logic;
			DAC_SDI, DAC_CS: out std_logic;
			flag: buffer std_logic;
			buffer_uart: buffer std_logic_vector(23 downto 0);
			datos_dac: buffer std_logic_vector(7 downto 0);
			uart_estado: buffer integer range 0 to 3;
			
			UART_TX: out std_logic;
			ADC1_SDOA, ADC1_SDOB, ADC1_SDOC, ADC1_SDOD: in std_logic;
			ADC1_SCLK: out std_logic;
			ADC1_CS: out std_logic;
			ADC2_SDOA, ADC2_SDOB, ADC2_SDOC, ADC2_SDOD: in std_logic;
			ADC2_SCLK: out std_logic;
			senal: buffer std_logic_vector(7 downto 0);
			estado_uart_adc: buffer integer range 0 to 3;
			estado_default: buffer integer range 0 to 2;
			ADC2_CS: out std_logic);
			
end NanoPipets;

architecture comp of NanoPipets is

	component Uart_receive is port(
	clk_rec: in std_logic;
	UART_RX_rec: in std_logic;
	DAC_SCLK_rec: buffer std_logic;
	DAC_SDI_rec:out std_logic; 
	DAC_CS_rec: out std_logic;
	estado_uart: buffer integer range 0 to 3;
	flag_uart: buffer std_logic;
	buffer_uart_rec: buffer std_logic_vector(23 downto 0));
	end component;
	
	component Uart_transmit is port(
	clk_trans: in std_logic;
	UART_TX_trans: out std_logic;
	ADC1_SDOA_trans, ADC1_SDOB_trans, ADC1_SDOC_trans, ADC1_SDOD_trans: in std_logic;
	ADC1_CS_trans: out std_logic;
	ADC1_SCLK_trans: out std_logic;
	ADC2_SDOA_trans, ADC2_SDOB_trans, ADC2_SDOC_trans, ADC2_SDOD_trans: in std_logic;
	ADC2_CS_trans: out std_logic;
	senal_prueba: buffer std_logic_vector(7 downto 0);
	estado_uart_trans: buffer integer range 0 to 3;
	estado_default_trans: buffer integer range 0 to 2;
	ADC2_SCLK_trans: out std_logic);
	end component;

	begin
		receive: Uart_receive port map
		(flag_uart=>flag, buffer_uart_rec=>buffer_uart, estado_uart=>uart_estado, clk_rec=>clk, UART_RX_rec=>UART_RX, DAC_SCLK_rec=>DAC_SCLK, DAC_SDI_rec=>DAC_SDI, DAC_CS_rec=>DAC_CS);
		transmit: Uart_transmit port map
		(clk_trans=>clk, senal_prueba=>senal, estado_default_trans=>estado_default, UART_TX_trans=>UART_TX, ADC1_SDOA_trans=>ADC1_SDOA, ADC1_SDOB_trans=>ADC1_SDOB, ADC1_SDOC_trans=>ADC1_SDOC, ADC1_SDOD_trans=>ADC1_SDOD, ADC1_SCLK_trans=>ADC1_SCLK, ADC1_CS_trans=>ADC1_CS, 
		ADC2_SDOA_trans=>ADC2_SDOA, estado_uart_trans=>estado_uart_adc, ADC2_SDOB_trans=>ADC2_SDOB, ADC2_SDOC_trans=>ADC2_SDOC, ADC2_SDOD_trans=>ADC2_SDOD, ADC2_SCLK_trans=>ADC2_SCLK, ADC2_CS_trans=>ADC2_CS);
	end comp;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NanoPipets is
	port(clk: in std_logic;
			UART_RX: in std_logic;
			UART_TX: out std_logic;
			DAC_SCLK, DAC_SDI, DAC_CS: out std_logic;
			DAC_SDO: in std_logic;
			ADC1_SDOA, ADC1_SDOB, ADC1_SDOC, ADC1_SDOD: in std_logic;
			ADC1_SDI, ADC1_SCLK, ADC1_CS: out std_logic;
			ADC2_SDOA, ADC2_SDOB, ADC2_SDOC, ADC2_SDOD: in std_logic;
			ADC2_SDI, ADC2_SCLK, ADC2_CS: out std_logic);
			
end NanoPipets;

architecture comp of NanoPipets is
	attribute chip_pin : string;
	attribute chip_pin of ADC1_SDOD: signal is "25";
	attribute chip_pin of ADC1_SDOA: signal is "30";
	attribute chip_pin of ADC1_SDOB: signal is "29";
	attribute chip_pin of ADC1_SDOC: signal is "26";
	attribute chip_pin of ADC1_SDI: signal is "28";
	attribute chip_pin of ADC1_SCLK: signal is "27";
	attribute chip_pin of ADC1_CS: signal is "32";
	
	attribute chip_pin of ADC2_SDOD: signal is "57";
	attribute chip_pin of ADC2_SDOC: signal is "58";
	attribute chip_pin of ADC2_SCLK: signal is "60";
	attribute chip_pin of ADC2_SDI: signal is "61";
	attribute chip_pin of ADC2_SDOB: signal is "62";
	attribute chip_pin of ADC2_SDOA: signal is "63";
	attribute chip_pin of ADC2_CS: signal is "64";
	
	attribute chip_pin of UART_RX: signal is "105";
	attribute chip_pin of UART_TX: signal is "106";
	
	attribute chip_pin of DAC_CS:signal is "120";
	attribute chip_pin of DAC_SCLK:signal is "119";
	attribute chip_pin of DAC_SDI:signal is "118";
	attribute chip_pin of DAC_SDO:signal is "117";
	
	

signal sal: std_logic;

begin
	process(clk)
	begin
		
	end process;
end comp;
			
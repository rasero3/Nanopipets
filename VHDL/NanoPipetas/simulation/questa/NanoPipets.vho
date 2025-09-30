-- Copyright (C) 2024  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 23.1std.1 Build 993 05/14/2024 SC Lite Edition"

-- DATE "09/30/2025 09:22:56"

-- 
-- Device: Altera 10M50SCE144C8G Package EQFP144
-- 

-- 
-- This VHDL file should be used for Questa Intel FPGA (VHDL) only
-- 

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_TMS~	=>  Location: PIN_16,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TCK~	=>  Location: PIN_17,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDI~	=>  Location: PIN_18,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDO~	=>  Location: PIN_19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCONFIG~	=>  Location: PIN_130,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_nSTATUS~	=>  Location: PIN_136,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_CONF_DONE~	=>  Location: PIN_138,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_TMS~~padout\ : std_logic;
SIGNAL \~ALTERA_TCK~~padout\ : std_logic;
SIGNAL \~ALTERA_TDI~~padout\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~padout\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~padout\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~padout\ : std_logic;
SIGNAL \~ALTERA_TMS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TCK~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TDI~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	NanoPipets IS
    PORT (
	clk : IN std_logic;
	UART_RX : IN std_logic;
	UART_TX : OUT std_logic;
	DAC_SCLK : OUT std_logic;
	DAC_SDI : OUT std_logic;
	DAC_CS : OUT std_logic;
	DAC_SDO : IN std_logic;
	ADC1_SDOA : IN std_logic;
	ADC1_SDOB : IN std_logic;
	ADC1_SDOC : IN std_logic;
	ADC1_SDOD : IN std_logic;
	ADC1_SDI : OUT std_logic;
	ADC1_SCLK : OUT std_logic;
	ADC1_CS : OUT std_logic;
	ADC2_SDOA : IN std_logic;
	ADC2_SDOB : IN std_logic;
	ADC2_SDOC : IN std_logic;
	ADC2_SDOD : IN std_logic;
	ADC2_SDI : OUT std_logic;
	ADC2_SCLK : OUT std_logic;
	ADC2_CS : OUT std_logic
	);
END NanoPipets;

-- Design Ports Information
-- clk	=>  Location: PIN_69,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- UART_RX	=>  Location: PIN_105,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- UART_TX	=>  Location: PIN_106,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DAC_SCLK	=>  Location: PIN_119,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DAC_SDI	=>  Location: PIN_118,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DAC_CS	=>  Location: PIN_120,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DAC_SDO	=>  Location: PIN_117,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC1_SDOA	=>  Location: PIN_30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC1_SDOB	=>  Location: PIN_29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC1_SDOC	=>  Location: PIN_26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC1_SDOD	=>  Location: PIN_25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC1_SDI	=>  Location: PIN_28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC1_SCLK	=>  Location: PIN_27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC1_CS	=>  Location: PIN_32,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC2_SDOA	=>  Location: PIN_63,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC2_SDOB	=>  Location: PIN_62,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC2_SDOC	=>  Location: PIN_58,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC2_SDOD	=>  Location: PIN_57,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC2_SDI	=>  Location: PIN_61,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC2_SCLK	=>  Location: PIN_60,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ADC2_CS	=>  Location: PIN_64,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF NanoPipets IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_UART_RX : std_logic;
SIGNAL ww_UART_TX : std_logic;
SIGNAL ww_DAC_SCLK : std_logic;
SIGNAL ww_DAC_SDI : std_logic;
SIGNAL ww_DAC_CS : std_logic;
SIGNAL ww_DAC_SDO : std_logic;
SIGNAL ww_ADC1_SDOA : std_logic;
SIGNAL ww_ADC1_SDOB : std_logic;
SIGNAL ww_ADC1_SDOC : std_logic;
SIGNAL ww_ADC1_SDOD : std_logic;
SIGNAL ww_ADC1_SDI : std_logic;
SIGNAL ww_ADC1_SCLK : std_logic;
SIGNAL ww_ADC1_CS : std_logic;
SIGNAL ww_ADC2_SDOA : std_logic;
SIGNAL ww_ADC2_SDOB : std_logic;
SIGNAL ww_ADC2_SDOC : std_logic;
SIGNAL ww_ADC2_SDOD : std_logic;
SIGNAL ww_ADC2_SDI : std_logic;
SIGNAL ww_ADC2_SCLK : std_logic;
SIGNAL ww_ADC2_CS : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \UART_RX~input_o\ : std_logic;
SIGNAL \DAC_SDO~input_o\ : std_logic;
SIGNAL \ADC1_SDOA~input_o\ : std_logic;
SIGNAL \ADC1_SDOB~input_o\ : std_logic;
SIGNAL \ADC1_SDOC~input_o\ : std_logic;
SIGNAL \ADC1_SDOD~input_o\ : std_logic;
SIGNAL \ADC2_SDOA~input_o\ : std_logic;
SIGNAL \ADC2_SDOB~input_o\ : std_logic;
SIGNAL \ADC2_SDOC~input_o\ : std_logic;
SIGNAL \ADC2_SDOD~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \UART_TX~output_o\ : std_logic;
SIGNAL \DAC_SCLK~output_o\ : std_logic;
SIGNAL \DAC_SDI~output_o\ : std_logic;
SIGNAL \DAC_CS~output_o\ : std_logic;
SIGNAL \ADC1_SDI~output_o\ : std_logic;
SIGNAL \ADC1_SCLK~output_o\ : std_logic;
SIGNAL \ADC1_CS~output_o\ : std_logic;
SIGNAL \ADC2_SDI~output_o\ : std_logic;
SIGNAL \ADC2_SCLK~output_o\ : std_logic;
SIGNAL \ADC2_CS~output_o\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_clk <= clk;
ww_UART_RX <= UART_RX;
UART_TX <= ww_UART_TX;
DAC_SCLK <= ww_DAC_SCLK;
DAC_SDI <= ww_DAC_SDI;
DAC_CS <= ww_DAC_CS;
ww_DAC_SDO <= DAC_SDO;
ww_ADC1_SDOA <= ADC1_SDOA;
ww_ADC1_SDOB <= ADC1_SDOB;
ww_ADC1_SDOC <= ADC1_SDOC;
ww_ADC1_SDOD <= ADC1_SDOD;
ADC1_SDI <= ww_ADC1_SDI;
ADC1_SCLK <= ww_ADC1_SCLK;
ADC1_CS <= ww_ADC1_CS;
ww_ADC2_SDOA <= ADC2_SDOA;
ww_ADC2_SDOB <= ADC2_SDOB;
ww_ADC2_SDOC <= ADC2_SDOC;
ww_ADC2_SDOD <= ADC2_SDOD;
ADC2_SDI <= ww_ADC2_SDI;
ADC2_SCLK <= ww_ADC2_SCLK;
ADC2_CS <= ww_ADC2_CS;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X44_Y52_N16
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X78_Y49_N16
\UART_TX~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \UART_TX~output_o\);

-- Location: IOOBUF_X46_Y54_N9
\DAC_SCLK~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \DAC_SCLK~output_o\);

-- Location: IOOBUF_X56_Y54_N16
\DAC_SDI~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \DAC_SDI~output_o\);

-- Location: IOOBUF_X46_Y54_N16
\DAC_CS~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \DAC_CS~output_o\);

-- Location: IOOBUF_X0_Y18_N23
\ADC1_SDI~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ADC1_SDI~output_o\);

-- Location: IOOBUF_X0_Y18_N16
\ADC1_SCLK~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ADC1_SCLK~output_o\);

-- Location: IOOBUF_X0_Y3_N16
\ADC1_CS~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ADC1_CS~output_o\);

-- Location: IOOBUF_X54_Y0_N9
\ADC2_SDI~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ADC2_SDI~output_o\);

-- Location: IOOBUF_X54_Y0_N16
\ADC2_SCLK~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ADC2_SCLK~output_o\);

-- Location: IOOBUF_X60_Y0_N30
\ADC2_CS~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ADC2_CS~output_o\);

-- Location: IOIBUF_X69_Y0_N8
\clk~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: IOIBUF_X78_Y49_N22
\UART_RX~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_UART_RX,
	o => \UART_RX~input_o\);

-- Location: IOIBUF_X56_Y54_N8
\DAC_SDO~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DAC_SDO,
	o => \DAC_SDO~input_o\);

-- Location: IOIBUF_X0_Y16_N8
\ADC1_SDOA~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ADC1_SDOA,
	o => \ADC1_SDOA~input_o\);

-- Location: IOIBUF_X0_Y16_N1
\ADC1_SDOB~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ADC1_SDOB,
	o => \ADC1_SDOB~input_o\);

-- Location: IOIBUF_X0_Y23_N22
\ADC1_SDOC~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ADC1_SDOC,
	o => \ADC1_SDOC~input_o\);

-- Location: IOIBUF_X0_Y23_N15
\ADC1_SDOD~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ADC1_SDOD,
	o => \ADC1_SDOD~input_o\);

-- Location: IOIBUF_X58_Y0_N1
\ADC2_SDOA~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ADC2_SDOA,
	o => \ADC2_SDOA~input_o\);

-- Location: IOIBUF_X56_Y0_N22
\ADC2_SDOB~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ADC2_SDOB,
	o => \ADC2_SDOB~input_o\);

-- Location: IOIBUF_X51_Y0_N29
\ADC2_SDOC~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ADC2_SDOC,
	o => \ADC2_SDOC~input_o\);

-- Location: IOIBUF_X49_Y0_N15
\ADC2_SDOD~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ADC2_SDOD,
	o => \ADC2_SDOD~input_o\);

-- Location: UNVM_X0_Y40_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_end_addr => -1,
	addr_range2_offset => -1,
	addr_range3_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X43_Y52_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

-- Location: ADCBLOCK_X43_Y51_N0
\~QUARTUS_CREATED_ADC2~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 2,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC2~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC2~~eoc\);

ww_UART_TX <= \UART_TX~output_o\;

ww_DAC_SCLK <= \DAC_SCLK~output_o\;

ww_DAC_SDI <= \DAC_SDI~output_o\;

ww_DAC_CS <= \DAC_CS~output_o\;

ww_ADC1_SDI <= \ADC1_SDI~output_o\;

ww_ADC1_SCLK <= \ADC1_SCLK~output_o\;

ww_ADC1_CS <= \ADC1_CS~output_o\;

ww_ADC2_SDI <= \ADC2_SDI~output_o\;

ww_ADC2_SCLK <= \ADC2_SCLK~output_o\;

ww_ADC2_CS <= \ADC2_CS~output_o\;
END structure;



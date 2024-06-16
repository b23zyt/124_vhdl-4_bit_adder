--Author: Group 19: Harry Wang, Benjamin Zeng
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;



architecture SimpleCircuit of LogicalStep_Lab2_top is
-- Components Used ---
------------------------------------------------------------------- 
	component segment7_mux port (
		clk		: in std_logic := '0';
		DIN2		: in std_logic_vector(6 downto 0);
		DIN1		: in std_logic_vector(6 downto 0);
		DOUT		: out std_logic_vector(6 downto 0);
		DIG2		: out std_logic;
		DIG1		: out std_logic
		
	);
	end component;

	
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	-- performs AND, OR, XOR, XNOR on the two sets of 4 bit inputs 
	-- based on the conbinations of pb[1-0]
	component logic_processor port(
		logic_in0, logic_in1 : in std_logic_vector(3 downto 0);
		mux_select : in std_logic_vector(1 downto 0);
		hex_out	: out std_logic_vector(3 downto 0)
	);
	end component;
	
	--PB inputs invertors
	component PB_Inverters port(
		pb_n	:	IN std_logic_vector(3 downto 0);
		pb		:	OUT std_logic_vector(3 downto 0)
	);
	end component;
	
	-- Performs addition of the two 4-bit inputs
	component full_adder_4bit port(
			BUS0: in std_logic_vector(3 downto 0);
			BUS1: in std_logic_vector(3 downto 0);
			CARRY_IN: in std_logic;
			CARRY_OUT: out std_logic;
			SUM: out std_logic_vector(3 downto 0)
		);
	end component;
	
	-- Selects the addition output when pb[3] is pressed, otherwise displays the original input
	component mux_2to1
		PORT(
		bit_sel : in std_logic;
		input_A : in std_logic_vector (3 downto 0);
		input_B : in std_logic_vector (3 downto 0);
		output : out std_logic_vector (3 downto 0)
		);
	END COMPONENT;
		
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal hex_A		: std_logic_vector(3 downto 0); 
	signal hex_B		: std_logic_vector(3 downto 0);
	signal hex_sum		: std_logic_vector(3 downto 0); -- result of 4-bit adder
	signal carrying		: std_logic; 						-- carry bit of 4-bit adder
	
	signal selected_A : std_logic_vector(3 downto 0); -- output that is selected by pb3
	signal selected_B : std_logic_vector(3 downto 0); -- output that is selected by pb3
	
	signal seg7_A		: std_logic_vector(6 downto 0); -- final converted output to the 7 segment display
	signal seg7_B		: std_logic_vector(6 downto 0); -- final converted output to the 7 segment display
	
	signal pb			: std_logic_vector(3 downto 0);
	
	
-- Here the circuit begins

begin

	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
--	
	INST6: full_adder_4bit port map( BUS0 => hex_A , BUS1 => hex_B ,
												CARRY_IN => '0' , CARRY_OUT => carrying , SUM => hex_sum );--connects the 4 bit adder
	INST5: PB_Inverters port map(pb_n, pb); -- connects the inverters to the buttons
	INST4: logic_processor port map(hex_A, hex_B, pb(1 downto 0), leds(3 downto 0)); --connects the logic processor
	INST7: mux_2to1 port map(pb(2), hex_A, hex_sum, selected_A);  --right 7-seg-display: dispaly sum when pb2=1
	INST8: mux_2to1 port map(pb(2), hex_B, "000"&carrying, selected_B); --left 7-seg-display: display carry when pb2=1 
	INST1: SevenSegment port map(selected_B, seg7_B); 
	INST2: SevenSegment port map(selected_A, seg7_A); 
	INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B,seg7_data, seg7_char2, seg7_char1);
 
end SimpleCircuit;


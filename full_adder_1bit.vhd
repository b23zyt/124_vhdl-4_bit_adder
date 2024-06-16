--Author: Group 19, Harry Wang, Benjamin Zeng
library ieee;
use ieee.std_logic_1164.all;

-- Adds 2 1-bit input with 1-bit carry in 
-- Outputs 1-bit sum and 1-bit carry out
ENTITY full_adder_1bit IS
	PORT(
		INPUT_A: in std_logic;
		INPUT_B: in std_logic;
		CARRY_IN: in std_logic;
		FULL_ADDER_CARRY_OUTPUT: out std_logic;
		FULL_ADDER_SUM_OUTPUT: out std_logic
	);
END full_adder_1bit;

ARCHITECTURE behavioral2 OF full_adder_1bit IS
	component Half_Adder IS
		PORT(
			input_A: in std_logic;
			input_B: in std_logic;
			carry: out std_logic;
			output: out std_logic
		);
	end component;
	
	signal half_carry_A: std_logic;
	signal half_carry_B: std_logic;
	signal half_sum: std_logic;

BEGIN
	INST1: Half_Adder port map(INPUT_A, INPUT_B, half_carry_A, half_sum);
	INST2: Half_Adder port map(half_sum, CARRY_IN, half_carry_B, FULL_ADDER_SUM_OUTPUT);
	FULL_ADDER_CARRY_OUTPUT <= half_carry_A OR half_carry_B;
	
END behavioral2;
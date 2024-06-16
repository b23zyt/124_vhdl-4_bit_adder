--Author: Group 19, Harry Wang, Benjamin Zeng
library ieee;
use ieee.std_logic_1164.all;

--takes two 4-bit input bus
--outputs 1 4-bit addition result
--output single bit carry 
ENTITY full_adder_4bit IS
	PORT(
		BUS0: in std_logic_vector(3 downto 0);
		BUS1: in std_logic_vector(3 downto 0);
		CARRY_IN: in std_logic;
		CARRY_OUT: out std_logic;
		SUM: out std_logic_vector(3 downto 0)
	);
END full_adder_4bit;

ARCHITECTURE behavior of full_adder_4bit IS
	component full_adder_1bit IS
		PORT(
			INPUT_A: in std_logic;
			INPUT_B: in std_logic;
			CARRY_IN: in std_logic;
			FULL_ADDER_CARRY_OUTPUT: out std_logic;
			FULL_ADDER_SUM_OUTPUT: out std_logic
		);
	end component;
	
	SIGNAL carry_temp: std_logic_vector(2 downto 0);
	
BEGIN
	INST1: full_adder_1bit port map(BUS0(0), BUS1(0), CARRY_IN, carry_temp(0), SUM(0));
	INST2: full_adder_1bit port map(BUS0(1), BUS1(1), carry_temp(0), carry_temp(1), SUM(1));
	INST3: full_adder_1bit port map(BUS0(2), BUS1(2), carry_temp(1), carry_temp(2), SUM(2));
	INST4: full_adder_1bit port map(BUS0(3), BUS1(3), carry_temp(2), CARRY_OUT, SUM(3));



END behavior;
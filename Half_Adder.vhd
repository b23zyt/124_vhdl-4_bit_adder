--Author: Group 19, Harry Wang, Benjamin Zeng
library ieee;
use ieee.std_logic_1164.all;

-- Takes 2 1-bit input 
-- Outputs 1-bit sum and 1-bit carry
ENTITY Half_Adder IS
	PORT(
		input_A: in std_logic;
		input_B: in std_logic;
		carry: out std_logic;
		output: out std_logic
	);
end Half_Adder;


ARCHITECTURE Behavioral OF Half_Adder IS
	
BEGIN
	carry <= input_A AND input_B;
	output <= input_A XOR input_B;
	
END Behavioral;

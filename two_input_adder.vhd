--------------------------------------------------------
-- VHDL code for n-bit adder (ESD figure 2.5)	
-- by Weujun Zhang, 04/2001
--
-- function of adder:
-- A plus B to get n-bit sum and 1 bit carry	
-- we may use generic statement to set the parameter 
-- n of the adder.							
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------

entity two_input_adder is

generic(n: natural :=2);
port(	A:	in std_logic_vector(n-1 downto 0);
	B:	in std_logic_vector(n-1 downto 0);
	carry:	out std_logic;
	sum:	out std_logic_vector(n-1 downto 0)
);

end two_input_adder;

--------------------------------------------------------

architecture behv of two_input_adder is

-- define a temparary signal to store the result

signal result: std_logic_vector(n downto 0);
 
begin					  
 
    -- the 3rd bit should be carry
   
    result <= ('0' & A)+('0' & B);
    sum <= result(n-1 downto 0);
    carry <= result(n);

end behv;

--------------------------------------------------------

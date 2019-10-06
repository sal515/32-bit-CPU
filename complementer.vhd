--------------------------------------------------------
--Complementer					
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------

entity complementer is

generic(n: natural :=2);
port(	A:		in std_logic_vector(n-1 downto 0);
	complement:	out std_logic_vector(n-1 downto 0)
);

end complementer;

--------------------------------------------------------

architecture behv of complementer is

signal result: std_logic_vector(n downto 0);
 
begin					  

	result <= not A;
	complement <= result + '1';

end behv;

--------------------------------------------------------

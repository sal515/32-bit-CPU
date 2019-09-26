--------------------------------------
-- XNOR gate
--------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--------------------------------------

entity two_input_XNOR is
port(	x: in std_logic;
	y: in std_logic;
	F: out std_logic
);
end two_input_XNOR;  

--------------------------------------

architecture behv2 of two_input_XNOR is 
begin 

    F <= x xnor y; 

end behv2;

--------------------------------------

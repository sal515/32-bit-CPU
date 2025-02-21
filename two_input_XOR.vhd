--------------------------------------
-- XOR gate (ESD figure 2.3)
--
-- two descriptions provided
--------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--------------------------------------

entity two_input_XOR is
port(	x: in std_logic;
	y: in std_logic;
	F: out std_logic
);
end two_input_XOR;  

--------------------------------------

--architecture behv1 of two_input_XOR is
--begin
--
--    process(x, y)
--    begin
--        -- compare to truth table
--	if (x/=y) then
--            F <= '1';
--	else
--	    F <= '0';
--	end if;
--    end process;
--
--end behv1;

architecture behv2 of two_input_XOR is 
begin 

    F <= x xor y; 

end behv2;

--------------------------------------

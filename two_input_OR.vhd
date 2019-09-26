--------------------------------------
-- OR gate (ESD book figure 2.3)
--
-- two descriptions provided
--------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--------------------------------------

entity two_input_OR is
port(	x: in std_logic;
	y: in std_logic;
	F: out std_logic
);
end two_input_OR;  

---------------------------------------

--architecture behav1 of two_input_OR is
--begin
--    
--    process(x, y)
--    begin
--        -- compare to truth table
--        if ((x='0') and (y='0')) then
--	    F <= '0';
--	else
--	    F <= '1';
--	end if;
--    end process;
--
--end behav1;

architecture behav2 of two_input_OR is 
begin 

    F <= x or y; 

end behav2;

---------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu is

port(
  
-- two input operands x and y both 32-bits  
x,y : in std_logic_vector(31 downto 0);	

-- 0 = add, 1 = sub
add_sub : in std_logic; 		
  
-- 00 = AND, 01 = OR, 10 = XOR, 11 = NOR
logic_func : in std_logic_vector(1 downto 0); 	

-- 00 = lui, 01 = setlessthan0, 10 = arith, 11 = logic
func : in std_logic_vector(1 downto 0);

output : out std_logic_vector(31 downto 0);
overflow: out std_logic;
zero : out std_logic
);

end alu;

architecture alu_arch of alu is

-- declare signals
signal add_sub_out : std_logic_vector(31 downto 0);
signal logic_unit_out : std_logic_vector(31 downto 0);
begin

    -- adder subtractor
    process(x, y, add_sub)
  begin
        if add_sub='0' then
            add_sub_out <= x + y;
        else
            add_sub_out <= x - y;
        end if;
    end process;

    -- logic unit
    process(x, y, logic_func)
    begin
        case logic_func is
            when "00" =>
                logic_unit_out <= x and y;
            when "01" =>
                logic_unit_out <= x or y;
            when "10" =>
                logic_unit_out <= x xor y;
            when others =>
                logic_unit_out <= x nor y;
        end case;
    end process;

    -- output logic
    process(func, y, add_sub_out, logic_unit_out)
    begin
        case func is
            when "00" =>
                output <= y;
            when "01" =>
                output <= (0 => add_sub_out(31), others => '0');
            when "10" =>
                output <= add_sub_out;
            when others =>
                output <= logic_unit_out;
        end case;
    end process;

    process(add_sub, add_sub_out, x, y)
    begin
        if add_sub='0' then
            overflow <= ( (not add_sub_out(31)) and x(31) and y(31) ) or (add_sub_out(31) and not x(31) and not y(31));
        else
            overflow <= ( (not add_sub_out(31)) and x(31) and (not y(31)) ) or ( add_sub_out(31) and (not x(31)) and y(31) );
        end if;
        -- zero <= not or_reduce(add_sub_out);
    end process;

end alu_arch;

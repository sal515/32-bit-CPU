library IEEE;
use IEEE.std_logic_1164.all;

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


--create an arithmatic unit



--create a logic unit

--create a Mux 4-1 - done

--create a zero detector

-- create an overflow detector

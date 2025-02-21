library IEEE;
use IEEE.std_logic_1164.all;
-- use ieee.std_logic_arith.all;
-- use signed for the implementation of the overflow
use ieee.std_logic_signed.all; 
-- use ieee.std_logic_unsigned.all;
-- use ieee.numeric_std.all;

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

architecture alu_architecture of alu is 

-- signal declarations
signal arithmatic_out : std_logic_vector(x'length-1 downto x'right);
signal logic_out : std_logic_vector(x'length-1 downto x'right);


begin

  -- create an arithmatic unit  
  arithmatic_unit: process(add_sub, x, y)
    
    variable var_arithmatic_out : std_logic_vector(x'length-1 downto x'right);
    
  begin
  
  case add_sub is  
    when '0' => var_arithmatic_out := (x + y);
    when '1' => var_arithmatic_out := (x - y);
    when others => var_arithmatic_out := (others => 'U');
    -- when others => var_arithmatic_out := x"UUUUUUUU";
  end case; 
  
  arithmatic_out <= var_arithmatic_out;
  end process;
  
  
  -- create a logic unit
  logic_unit: process(logic_func, x, y)
    
    variable var_logic_out : std_logic_vector(x'length-1 downto x'right);
    
  begin
  
  case logic_func is  
    when "00" => var_logic_out := (x and y);
    when "01" => var_logic_out := (x or y);
    when "10" => var_logic_out := (x xor y);
    when "11" => var_logic_out := (x nor y);
    when others => var_logic_out := (others => 'U');
  end case; 
  
  logic_out <= var_logic_out;
  end process;
    
  -- create a zero detector
  zero_detector: process(arithmatic_out)
  
     variable var_zero : std_logic;
     
   begin
     
     -- assuming the result is all zeros
     var_zero := '1';
     
     -- checking if the result is actually zeros
    for i in 0 to x'length-1 loop
      if(arithmatic_out(i)) = '1' then
        var_zero := '0';
        exit;
      end if;
    end loop;
    
     zero <= var_zero;
     
   end process;
   
   
  -- create an overflow detector
  overflow_detector: process(arithmatic_out, add_sub, x, y)
     variable var_overflow : std_logic;
     
    begin
     
    
      if((add_sub = '0') and (x(x'length-1) = '0') and (y(y'length-1) = '0') and (arithmatic_out(x'length-1) = '1')) then
        -- add positive numbers overflow
        var_overflow := '1';

      elsif(add_sub = '0' and x(x'length-1) = '1' and y(y'length-1) = '1' and arithmatic_out(x'length-1) = '0') then
        -- add negative numbers overflow
        var_overflow := '1';
      
      elsif(add_sub = '1' and x(x'length-1) = '0' and y(y'length-1) = '1' and arithmatic_out(x'length-1) = '1') then
        -- sub positive from negative numbers overflow
        var_overflow := '1';
      
      elsif(add_sub = '1' and x(x'length-1) = '1' and y(y'length-1) = '0' and arithmatic_out(x'length-1) = '0') then
        -- sub negative from positive numbers overflow
        var_overflow := '1';
        
      else
        var_overflow:= '0';      
          
      end if;
     
      overflow <= var_overflow;
    
    end process;
    
  -- create a Mux 4-1
  output_mux: process(func, arithmatic_out, logic_out, y)
     
     variable var_output : std_logic_vector(x'length-1 downto x'right);
     variable var_arithmatic_out : std_logic_vector(x'length-1 downto x'right);
     
   begin
   
   -- https://stackoverflow.com/questions/52031300/how-to-assign-one-bit-of-std-logic-vector-to-1-and-others-to-0
   if(arithmatic_out(x'length-1) = '1') then 
        -- x < y is true   
        var_arithmatic_out := (others => '0');
        var_arithmatic_out(x'right) := '1';
    else
        -- x < y is false
        var_arithmatic_out := (others => '0');
    end if;
   
   case func is  
     when "00" => var_output := y;
     when "01" => var_output := var_arithmatic_out;
     when "10" => var_output := arithmatic_out;
     when "11" => var_output := logic_out;
     when others => var_output := (others => 'U');
   end case; 
   
   output <= var_output;
   end process;
  
end alu_architecture;






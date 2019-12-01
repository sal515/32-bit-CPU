LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY sign_extend IS
    PORT (
        func : IN std_logic_vector(1 downto 0);
        sign_extend_in : IN std_logic_vector(15 DOWNTO 0);
        sign_extend_out : OUT std_logic_vector(31 DOWNTO 0)
    );
END sign_extend;

ARCHITECTURE sign_extend_arch OF sign_extend IS

BEGIN

process(func, sign_extend_in)

variable sign_extend_out_var: std_logic_vector(sign_extend_out'length-1 downto sign_extend_out'right);

  begin

    CASE func IS
        WHEN "00" =>
            sign_extend_out <= sign_extend_in & "0000000000000000";
        
        WHEN "01" =>
        -- if sign_extend_in(sign_extend_in'length-1) = '1' then
        if sign_extend_in(sign_extend_in'length-1) = '1' then

          sign_extend_out_var := (others => '1');
          sign_extend_out_var(sign_extend_in'length-1 downto sign_extend_in'right) := sign_extend_in;
          sign_extend_out <= sign_extend_out_var;
        else
          sign_extend_out_var := (others => '0');
          sign_extend_out_var(sign_extend_in'length-1 downto sign_extend_in'right) := sign_extend_in;
          sign_extend_out <= sign_extend_out_var;
        end if;
        
        WHEN "10" =>
		    if sign_extend_in(sign_extend_in'length-1) = '1' then
          sign_extend_out_var := (others => '1');
          sign_extend_out_var(sign_extend_in'length-1 downto sign_extend_in'right) := sign_extend_in;
          sign_extend_out <= sign_extend_out_var;
        else
          sign_extend_out_var := (others => '0');
          sign_extend_out_var(sign_extend_in'length-1 downto sign_extend_in'right) := sign_extend_in;
          sign_extend_out <= sign_extend_out_var;
        end if;        
        
        WHEN "11" =>
		-- if sign_extend_in(sign_extend_in'length-1) = '1' then
			sign_extend_out_var := (others => '0');
			sign_extend_out_var(sign_extend_in'length-1 downto sign_extend_in'right) := sign_extend_in;
			sign_extend_out <= sign_extend_out_var;
		-- else
		-- 	sign_extend_out_var := (others => '0');
		-- 	sign_extend_out_var(sign_extend_in'length-1 downto sign_extend_in'right) := sign_extend_in;
		-- 	sign_extend_out <= sign_extend_out_var;
		-- end if;
        
        WHEN OTHERS =>
            sign_extend_out <= (others=>'0');
    END CASE;

end process;
END sign_extend_arch;

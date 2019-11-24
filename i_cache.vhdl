LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY i_cache IS
    PORT (
        instr_addr : IN std_logic_vector(4 DOWNTO 0);
        i_cache_instr_out : OUT std_logic_vector(31 DOWNTO 0)
    );
END i_cache;

ARCHITECTURE i_cache_arch OF i_cache IS

BEGIN

    -- eg. program
    -- 00000 addi r1, r0, 1 ; r1 = r0 + 1 = 0 + 1
    -- 00001 addi r2, r0, 2 ; r2 = r0 + 2 = 0 + 2
    -- 00010 there: add r2, r2, r1 ; r2 = r2 + r1 = r2 + 1
    -- 00011 j there ; goto label there
process(instr_addr)
  begin
    CASE instr_addr IS
            -- addi r1, r0, 1
        WHEN "00000" =>
            i_cache_instr_out <= "00100000000000010000000000000001";
            --addi r2, r0, 2
        WHEN "00001" =>
            i_cache_instr_out <= "00100000000000100000000000000010";
            -- add r2, r2, r1
        WHEN "00010" =>
            i_cache_instr_out <= "00000000010000010001000000100000";
            -- jump 00010
        WHEN "00011" =>
            i_cache_instr_out <= "00001000000000000000000000000010";
            -- do not care
        WHEN OTHERS =>
            i_cache_instr_out <= (OTHERS => '0');
    END CASE;

end process;
END i_cache_arch;
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY d_cache IS
    PORT (
        clock : IN std_logic;
        data_write : IN std_logic;
        reset : IN std_logic;
        addr : IN std_logic_vector(4 DOWNTO 0);
        d_in : IN std_logic_vector(31 DOWNTO 0);
        d_out : OUT std_logic_vector(31 DOWNTO 0)
    );
END d_cache;

ARCHITECTURE d_cache_arch OF d_cache IS

    TYPE data_cache IS ARRAY(0 TO 31) OF std_logic_vector(d_in'length - 1 DOWNTO d_in'right);
    SIGNAL d_cache : data_cache;

BEGIN

    PROCESS (clock, data_write, reset, addr, din)
    BEGIN
        IF reset = '1' THEN
            FOR i IN 0 TO 31 LOOP
                d_cache(i) <= (OTHERS => '0');
            END LOOP;
        ELSIF (clock = '1' AND clock'event AND data_write = '1') THEN
            -- IF data_write = '1' THEN
            d_cache(CONV_INTEGER(addr)) <= d_in;
            -- END IF;
        END IF;

    END PROCESS;

    d_out <= d_cache(CONV_INTEGER(addr));

    -- -- eg. program
    -- -- 00000 addi r1, r0, 1 ; r1 = r0 + 1 = 0 + 1
    -- -- 00001 addi r2, r0, 2 ; r2 = r0 + 2 = 0 + 2
    -- -- 00010 there: add r2, r2, r1 ; r2 = r2 + r1 = r2 + 1
    -- -- 00011 j there ; goto label there

    -- CASE instr_addr IS
    --         -- addi r1, r0, 1
    --     WHEN "00000" =>
    --         i_cache_instr_out <= "00100000000000010000000000000001";
    --         --addi r2, r0, 2
    --     WHEN "00001" =>
    --         ic_out <= "00100000000000100000000000000010";
    --         -- add r2, r2, r1
    --     WHEN "00010" =>
    --         ic_out <= "00000000010000010001000000100000";
    --         -- jump 00010
    --     WHEN "00011" =>
    --         ic_out <= "00001000000000000000000000000010";
    --         -- don’t care
    --     WHEN OTHERS =>
    --         ic_out <= (OTHERS => '0');
    -- END CASE;

END d_cache_arch;
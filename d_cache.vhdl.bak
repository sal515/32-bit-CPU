LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

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

    PROCESS (clock, data_write, reset, addr, d_in)
    BEGIN
        IF reset = '1' THEN
            -- FOR i IN 0 TO 31 LOOP
            --     d_cache(i) <= (OTHERS => '0');
            -- END LOOP;
            
            d_cache <= (others => (others => '0'));
            
        ELSIF (clock = '1' AND clock'event AND data_write = '1') THEN
            -- IF data_write = '1' THEN
            -- d_cache(to_integer(unsigned(addr))) <= d_in;
            
            d_cache(CONV_INTEGER(addr)) <= d_in;
            
            -- END IF;
        END IF;

    END PROCESS;

    d_out <= d_cache(CONV_INTEGER(addr));

END d_cache_arch;


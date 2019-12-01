LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;

ENTITY pc_register IS
    PORT (
        reset : IN std_logic;
        clock : IN std_logic;
        d : IN std_logic_vector(31 DOWNTO 0);
        q : OUT std_logic_vector(31 DOWNTO 0)
    );
END pc_register;

ARCHITECTURE pc_register_arch OF pc_register IS

BEGIN

    PROCESS (clock, reset, d)
      begin
      
        IF reset = '1' THEN
            q <= (OTHERS => '0');
        ELSIF (clock = '1' AND clock'event) THEN
            q <= d;
        END IF;
    END PROCESS;

END pc_register_arch;
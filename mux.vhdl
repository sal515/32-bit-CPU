LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY two_input_mux IS
    PORT (
        s : IN std_logic;
        in0 : IN std_logic_vector(31 DOWNTO 0);
        in1 : IN std_logic_vector(31 DOWNTO 0);
        mux_out : OUT std_logic_vector(31 DOWNTO 0);
    );
END two_input_mux;

ARCHITECTURE two_input_mux_arch OF two_input_mux IS

BEGIN

    CASE s IS
        WHEN "0" =>
            mux_out <= in0;
        WHEN "1" =>
            mux_out <= in1;
        WHEN OTHERS =>
            mux_out <= (others=>'0');
    END CASE;

END two_input_mux_arch;
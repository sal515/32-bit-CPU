-- salman rahman
-- 27853815

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY two_input_mux_5_bit IS
    PORT (
        s : IN std_logic;
        in0 : IN std_logic_vector(4 DOWNTO 0);
        in1 : IN std_logic_vector(4 DOWNTO 0);
        mux_out : OUT std_logic_vector(4 DOWNTO 0)
    );
END two_input_mux_5_bit;

ARCHITECTURE two_input_5_bit_mux_arch OF two_input_mux_5_bit IS

BEGIN

process(s, in0, in1)
  begin

    CASE s IS
        WHEN '0' =>
            mux_out <= in0;
        WHEN '1' =>
            mux_out <= in1;
        WHEN OTHERS =>
            mux_out <= (others=>'0');
    END CASE;

end process;
END two_input_5_bit_mux_arch;
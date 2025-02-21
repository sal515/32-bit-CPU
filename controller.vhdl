-- salman rahman
-- 27853815

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- USE ieee.numeric_std.ALL;

ENTITY controller IS
    PORT (

        -- next address ports
        pc_sel : OUT std_logic_vector(1 DOWNTO 0);
        branch_type : OUT std_logic_vector(1 DOWNTO 0);

        -- reg_des MUX ports
        reg_dst : OUT std_logic;

        -- sign extend ports
        -- func : out std_logic_vector(1 DOWNTO 0);

        -- regfile ports block
        reg_write : OUT std_logic;

        -- alu_src MUX ports
        alu_src : OUT std_logic;

        -- alu ports
        add_sub : OUT std_logic;
        logic_func : OUT std_logic_vector(1 DOWNTO 0);
        func : OUT std_logic_vector(1 DOWNTO 0);

        -- overflow : OUT std_logic;
        -- zero : OUT std_logic

        -- d-cache ports
        data_write : OUT std_logic;

        -- reg_in_src MUX port
        reg_in_src : OUT std_logic;

        -- control port
        instruction_in : IN std_logic_vector(31 DOWNTO 0)
    );
END controller;

ARCHITECTURE controller_arch OF controller IS
    SIGNAL op_code : std_logic_vector(5 DOWNTO 0);
    SIGNAL func_code : std_logic_vector(5 DOWNTO 0);
BEGIN

    PROCESS (instruction_in)

    BEGIN
        op_code <= instruction_in(31 DOWNTO 26);
        func_code <= instruction_in(5 DOWNTO 0);
    END PROCESS;

    PROCESS (op_code, func_code)

    BEGIN
        CASE op_code IS
            WHEN "000000" =>
                CASE func_code IS
                    WHEN "100000" => -- add
                        pc_sel <= "00";
                        branch_type <= "00";
                        reg_dst <= '1';
                        reg_write <= '1';
                        reg_in_src <= '1';
                        alu_src <= '0';
                        add_sub <= '0';
                        logic_func <= "00";
                        func <= "10";
                        data_write <= '0';
                    WHEN "100010" => -- sub
                        pc_sel <= "00";
                        branch_type <= "00";
                        reg_dst <= '1';
                        reg_write <= '1';
                        reg_in_src <= '1';
                        alu_src <= '0';
                        add_sub <= '1';
                        logic_func <= "00";
                        func <= "10";
                        data_write <= '0';
                    WHEN "101010" => -- slt
                        pc_sel <= "00";
                        branch_type <= "00";
                        reg_dst <= '1';
                        reg_write <= '1';
                        reg_in_src <= '1';
                        alu_src <= '0';
                        add_sub <= '1';
                        logic_func <= "00";
                        func <= "01";
                        data_write <= '0';
                    WHEN "100100" => -- and
                        pc_sel <= "00";
                        branch_type <= "00";
                        reg_dst <= '1';
                        reg_write <= '1';
                        reg_in_src <= '1';
                        alu_src <= '0';
                        add_sub <= '1';
                        logic_func <= "00";
                        func <= "11";
                        data_write <= '0';
                    WHEN "100101" => -- or
                        pc_sel <= "00";
                        branch_type <= "00";
                        reg_dst <= '1';
                        reg_write <= '1';
                        reg_in_src <= '1';
                        alu_src <= '0';
                        add_sub <= '1';
                        logic_func <= "01";
                        func <= "11";
                        data_write <= '0';
                    WHEN "100110" => -- xor
                        pc_sel <= "00";
                        branch_type <= "00";
                        reg_dst <= '1';
                        reg_write <= '1';
                        reg_in_src <= '1';
                        alu_src <= '0';
                        add_sub <= '1';
                        logic_func <= "10";
                        func <= "11";
                        data_write <= '0';
                    WHEN "100111" => -- nor
                        pc_sel <= "00";
                        branch_type <= "00";
                        reg_dst <= '1';
                        reg_write <= '1';
                        reg_in_src <= '1';
                        alu_src <= '0';
                        add_sub <= '1';
                        logic_func <= "11";
                        func <= "11";
                        data_write <= '0';
                    WHEN "001000" => -- jr
                        pc_sel <= "10";
                        branch_type <= "00";
                        reg_dst <= '1';
                        reg_write <= '0';
                        reg_in_src <= '1';
                        alu_src <= '0';
                        add_sub <= '0';
                        logic_func <= "00";
                        func <= "00";
                        data_write <= '0';
                    WHEN OTHERS =>
                END CASE; -- end of func case
            WHEN "001111" => --lui
                pc_sel <= "00";
                branch_type <= "00";
                reg_dst <= '0';
                reg_write <= '1';
                reg_in_src <= '1';
                alu_src <= '1';
                add_sub <= '0';
                logic_func <= "00";
                func <= "00";
                data_write <= '0';
            WHEN "001000" => --addi
                pc_sel <= "00";
                branch_type <= "00";
                reg_dst <= '0';
                reg_write <= '1';
                reg_in_src <= '1';
                alu_src <= '1';
                add_sub <= '0';
                logic_func <= "00";
                func <= "10";
                data_write <= '0';
            WHEN "001010" => --slti
                pc_sel <= "00";
                branch_type <= "00";
                reg_dst <= '0';
                reg_write <= '1';
                reg_in_src <= '1';
                alu_src <= '1';
                add_sub <= '1';
                logic_func <= "00";
                func <= "10";
                data_write <= '0';
            WHEN "001100" => --andi
                pc_sel <= "00";
                branch_type <= "00";
                reg_dst <= '0';
                reg_write <= '1';
                reg_in_src <= '1';
                alu_src <= '1';
                add_sub <= '1';
                logic_func <= "00";
                func <= "11";
                data_write <= '0';
            WHEN "001101" => --ori
                pc_sel <= "00";
                branch_type <= "00";
                reg_dst <= '0';
                reg_write <= '1';
                reg_in_src <= '1';
                alu_src <= '1';
                add_sub <= '1';
                logic_func <= "01";
                func <= "11";
                data_write <= '0';
            WHEN "001110" => --xori
                pc_sel <= "00";
                branch_type <= "00";
                reg_dst <= '0';
                reg_write <= '1';
                reg_in_src <= '1';
                alu_src <= '1';
                add_sub <= '1';
                logic_func <= "10";
                func <= "11";
                data_write <= '0';
            WHEN "100011" => --lw
                pc_sel <= "00";
                branch_type <= "00";
                reg_dst <= '0';
                reg_write <= '1';
                reg_in_src <= '0';
                alu_src <= '1';
                add_sub <= '0';
                logic_func <= "10";
                func <= "10";
                data_write <= '0';
            WHEN "101011" => --sw
                pc_sel <= "00";
                branch_type <= "00";
                reg_dst <= '0';
                reg_write <= '0';
                reg_in_src <= '0';
                alu_src <= '1';
                add_sub <= '0';
                logic_func <= "10";
                func <= "10";
                data_write <= '1';
            WHEN "000010" => --j
                pc_sel <= "01";
                branch_type <= "00";
                reg_dst <= '0';
                reg_write <= '0';
                reg_in_src <= '0';
                alu_src <= '1';
                add_sub <= '0';
                logic_func <= "00";
                func <= "00";
                data_write <= '0';
            WHEN "000001" => --bltz
                pc_sel <= "00";
                branch_type <= "11";
                reg_dst <= '0';
                reg_write <= '0';
                reg_in_src <= '0';
                alu_src <= '1';
                add_sub <= '1';
                logic_func <= "00";
                func <= "00";
                data_write <= '0';
            WHEN "000100" => --beq
                pc_sel <= "00";
                branch_type <= "01";
                reg_dst <= '0';
                reg_write <= '0';
                reg_in_src <= '0';
                alu_src <= '0';
                add_sub <= '0';
                logic_func <= "00";
                func <= "00";
                data_write <= '0';
            WHEN "000101" => --bne
                pc_sel <= "00";
                branch_type <= "10";
                reg_dst <= '0';
                reg_write <= '0';
                reg_in_src <= '0';
                alu_src <= '1';
                add_sub <= '0';
                logic_func <= "00";
                func <= "00";
                data_write <= '0';
            WHEN OTHERS =>
        END CASE;

    END PROCESS;

END controller_arch;
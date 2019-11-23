LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY datapath IS
    PORT (

        -- global signal
        reset : IN std_logic;
        clk : IN std_logic;
    
        -- next address ports
        pc_sel : IN std_logic_vector(1 DOWNTO 0);
        branch_type : IN std_logic_vector(1 DOWNTO 0);

        -- reg_des MUX ports
        reg_dst : IN std_logic;

        -- sign extend ports
        func : IN std_logic_vector(1 DOWNTO 0);

        -- regfile ports block
        reg_write : IN std_logic;

        -- alu_src MUX ports
        alu_src : IN std_logic;
        
        -- alu ports
        add_sub : IN std_logic;
        logic_func : IN std_logic_vector(1 DOWNTO 0);
        func : IN std_logic_vector(1 DOWNTO 0);

        overflow : OUT std_logic;
        zero : OUT std_logic


        -- d-cache ports
        data_write : IN std_logic;

        -- reg_in_src MUX port
        reg_in_src : IN std_logic;
        

    );
END datapath;
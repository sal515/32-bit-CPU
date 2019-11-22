LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY datapath IS
    PORT (
        -- pc ports 
        reset : IN std_logic;
        clk : IN std_logic;
        pc_q: OUT std_logic_vector(31 DOWNTO 0);
        
        -- i-cache ports
        icache_instr : OUT std_logic_vector(31 DOWNTO 0);
        
        -- next address ports
        pc_sel : IN std_logic_vector(1 DOWNTO 0);
        branch_type : IN std_logic_vector(1 DOWNTO 0);
        next_pc : OUT std_logic_vector(31 DOWNTO 0);

        -- reg_des MUX ports
        reg_dst : IN std_logic;
        add : OUT std_logic;

        -- sign extend ports
        func : IN std_logic_vector(1 DOWNTO 0);
        sign_extnd_out : OUT std_logic_vector(31 DOWNTO 0);
        
        -- regfile ports block
        reg_write : IN std_logic;
        out_a : OUT std_logic_vector(31 DOWNTO 0);
        out_b : OUT std_logic_vector(31 DOWNTO 0);

        -- alu_src MUX ports
        alu_src : IN std_logic;


        add_sub : IN std_logic;



        logic_func : IN std_logic_vector(1 DOWNTO 0);
        data_write : IN std_logic;
        reg_in_src : IN std_logic;
        rt_output : OUT std_logic_vector(31 DOWNTO 0);
        overflow : OUT std_logic;
        zero : OUT std_logic
    );
END datapath;
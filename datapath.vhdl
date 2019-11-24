LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY datapath IS
    PORT (
        -- global signals
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

ARCHITECTURE datapath_arch OF datapath IS

    COMPONENT pc_register
        PORT (
            reset : IN std_logic := '0';
            clock : IN std_logic := '0';
            d : IN std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
            q : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT i_cache
        PORT (
            instr_addr : IN std_logic_vector(4 DOWNTO 0) := (OTHERS => '0');
            i_cache_instr_out : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT next_address
        PORT (
            rt, rs : IN std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
            pc : IN std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
            target_address : IN std_logic_vector(25 DOWNTO 0) := (OTHERS => '0');
            branch_type : IN std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
            pc_sel : IN std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
            next_pc : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT two_input_mux IS
        PORT (
            s : IN std_logic;
            in0 : IN std_logic_vector(31 DOWNTO 0);
            in1 : IN std_logic_vector(31 DOWNTO 0);
            mux_out : OUT std_logic_vector(31 DOWNTO 0);
        );
    END COMPONENT;
    
    COMPONENT regfile
        PORT (
            din : IN std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
            reset : IN std_logic := '0';
            clk : IN std_logic := '0';
            write : IN std_logic := '0';
            read_a : IN std_logic_vector(4 DOWNTO 0) := (OTHERS => '0');
            read_b : IN std_logic_vector(4 DOWNTO 0) := (OTHERS => '0');
            write_address : IN std_logic_vector(4 DOWNTO 0) := (OTHERS => '0');
            out_a : OUT std_logic_vector(31 DOWNTO 0);
            out_b : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT alu
        PORT (
            -- two input operands x and y both 32-bits  
            x, y : IN std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');

            -- 0 = add, 1 = sub
            add_sub : IN std_logic := '0';

            -- 00 = AND, 01 = OR, 10 = XOR, 11 = NOR
            logic_func : IN std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');

            -- 00 = lui, 01 = setlessthan0, 10 = arith, 11 = logic
            func : IN std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');

            output : OUT std_logic_vector(31 DOWNTO 0);
            overflow : OUT std_logic;
            zero : OUT std_logic
        );
    END COMPONENT;

    COMPONENT d_cache
        PORT (
            clock : IN std_logic := '0';
            data_write : IN std_logic := '0';
            reset : IN std_logic := '0';
            addr : IN std_logic_vector(4 DOWNTO 0) := (OTHERS => '0');
            d_in : IN std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
            d_out : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    -- internal signal declarations

    -- pc signals
    SIGNAL next_pc : std_logic_vector(31 DOWNTO 0);


    begin



        
END datapath_arch;
-- salman rahman
-- 27853815

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
        -- func : IN std_logic_vector(1 DOWNTO 0);

        -- regfile ports block
        reg_write : IN std_logic;

        -- alu_src MUX ports
        alu_src : IN std_logic;

        -- alu ports
        add_sub : IN std_logic;
        logic_func : IN std_logic_vector(1 DOWNTO 0);
        func : IN std_logic_vector(1 DOWNTO 0);

        overflow : OUT std_logic;
        zero : OUT std_logic;

        -- d-cache ports
        data_write : IN std_logic;

        -- reg_in_src MUX port
        reg_in_src : IN std_logic;

        -- control port
        instruction_out : OUT std_logic_vector(31 DOWNTO 0);

        rs_out : OUT std_logic_vector(31 DOWNTO 0);
        rt_out : OUT std_logic_vector(31 DOWNTO 0);
        pc_out : OUT std_logic_vector(31 DOWNTO 0)
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
            mux_out : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;



    COMPONENT two_input_mux_5_bit IS
        PORT (
            s : IN std_logic;
            in0 : IN std_logic_vector(4 DOWNTO 0);
            in1 : IN std_logic_vector(4 DOWNTO 0);
            mux_out : OUT std_logic_vector(4 DOWNTO 0)
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

    COMPONENT sign_extend
        PORT (
            func : IN std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
            sign_extend_in : IN std_logic_vector(15 DOWNTO 0) := (OTHERS => '0');
            sign_extend_out : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    -- internal component output signal declarations

    -- internal signals for pc register
    SIGNAL q_out : std_logic_vector(31 DOWNTO 0);

    -- internal signals for next_address
    SIGNAL next_pc_out : std_logic_vector(31 DOWNTO 0);

    -- internal signals for i_cache
    SIGNAL instruction_cache_out : std_logic_vector(31 DOWNTO 0);

    -- internal signal reg_dst mux
    SIGNAL addr_out : std_logic_vector(4 DOWNTO 0);

    -- internal signal sign_extend
    SIGNAL sign_extend_value_out : std_logic_vector(31 DOWNTO 0);

    -- internal signals register file 
    SIGNAL rs_data_out : std_logic_vector(31 DOWNTO 0);
    SIGNAL rt_data_out : std_logic_vector(31 DOWNTO 0);

    -- rs register bits - (25 downto 21)
    -- rt register bits - (20 downto 16)
    -- rd register bits - (15 downto 11)
    -- internal signal alu_src mux
    SIGNAL alu_mux_out : std_logic_vector(31 DOWNTO 0);

    -- alu internal signals
    SIGNAL alu_out : std_logic_vector(31 DOWNTO 0);

    -- d cache signals
    SIGNAL d_cache_out : std_logic_vector(31 DOWNTO 0);

    -- internal signal reg_in_src mux
    SIGNAL d_cache_mux_out : std_logic_vector(31 DOWNTO 0);

BEGIN

    pc_reg : pc_register PORT MAP(
        reset => reset,
        clock => clk,
        d => next_pc_out,
        q => q_out
    );

    icache : i_cache PORT MAP(
        instr_addr => q_out(4 DOWNTO 0),
        i_cache_instr_out => instruction_cache_out
    );

    next_addr : next_address PORT MAP(
        rt => rt_data_out,
        rs => rs_data_out,
        pc => q_out,
        target_address => instruction_cache_out(25 DOWNTO 0),
        branch_type => branch_type,
        pc_sel => pc_sel,
        next_pc => next_pc_out
    );

    reg_dst_mux : two_input_mux_5_bit PORT MAP(
        s => reg_dst,
        in0 => instruction_cache_out(20 DOWNTO 16),
        in1 => instruction_cache_out(15 DOWNTO 11),
        mux_out => addr_out
    );

    rf : regfile PORT MAP(
        din => d_cache_mux_out,
        reset => reset,
        clk => clk,
        write => reg_write,
        read_a => instruction_cache_out(25 DOWNTO 21),
        read_b => instruction_cache_out(20 DOWNTO 16),
        write_address => addr_out,
        out_a => rs_data_out,
        out_b => rt_data_out
    );

    signExt : sign_extend PORT MAP(
        func => func,
        sign_extend_in => instruction_cache_out(15 DOWNTO 0),
        sign_extend_out => sign_extend_value_out
    );

    alu_src_mux : two_input_mux PORT MAP(
        s => alu_src,
        in0 => rt_data_out,
        in1 => sign_extend_value_out,
        mux_out => alu_mux_out
    );

    alu_comp : alu PORT MAP(
        x => rs_data_out,
        y => alu_mux_out,
        add_sub => add_sub,
        logic_func => logic_func,
        func => func,
        output => alu_out,
        overflow => overflow,
        zero => zero
    );

    dcache : d_cache PORT MAP(
        clock => clk,
        data_write => data_write,
        reset => reset,
        addr => alu_out(4 DOWNTO 0),
        d_in => rt_data_out,
        d_out => d_cache_out
    );

    reg_in_src_mux : two_input_mux PORT MAP(
        s => reg_in_src,
        in0 => d_cache_out,
        in1 => alu_out,
        mux_out => d_cache_mux_out
    );



    rs_out <= rs_data_out;
    rt_out <= rt_data_out;
    pc_out <= q_out;

    instruction_out <= instruction_cache_out;


END datapath_arch;
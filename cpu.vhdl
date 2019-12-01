-- salman rahman
-- 27853815

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_signed.ALL;

ENTITY cpu IS
    PORT (
        reset : IN std_logic;
        clk : IN std_logic;
        rs_out, rt_out : OUT std_logic_vector(3 DOWNTO 0);
        -- output ports from the register file
        pc_out : OUT std_logic_vector(3 DOWNTO 0);
        overflow, zero : OUT std_logic
    );
END cpu;

ARCHITECTURE cpu_arch OF cpu IS

    COMPONENT datapath
        PORT (
            reset : IN std_logic;
            clk : IN std_logic;

            pc_sel : IN std_logic_vector(1 DOWNTO 0) := "00";
            branch_type : IN std_logic_vector(1 DOWNTO 0) := "00";

            reg_dst : IN std_logic := '0';
            reg_write : IN std_logic := '0';

            alu_src : IN std_logic := '0';

            add_sub : IN std_logic := '0';
            logic_func : IN std_logic_vector(1 DOWNTO 0) := "00";
            func : IN std_logic_vector(1 DOWNTO 0) := "00";

            overflow : OUT std_logic;
            zero : OUT std_logic;

            data_write : IN std_logic := '0';

            reg_in_src : IN std_logic := '0';

            instruction_out : OUT std_logic_vector(31 DOWNTO 0) := "00000000000000000000000000000000";

            rs_out : OUT std_logic_vector(31 DOWNTO 0):= "00000000000000000000000000000000";
            rt_out : OUT std_logic_vector(31 DOWNTO 0):= "00000000000000000000000000000000";
            pc_out : OUT std_logic_vector(31 DOWNTO 0):= "00000000000000000000000000000000"
        );
    END COMPONENT;

    COMPONENT controller
        PORT (
            pc_sel : OUT std_logic_vector(1 DOWNTO 0) :="00";
            branch_type : OUT std_logic_vector(1 DOWNTO 0) :="00";
            reg_dst : OUT std_logic :='0';
            reg_write : OUT std_logic :='0';
            alu_src : OUT std_logic :='0';
            add_sub : OUT std_logic :='0' ;
            logic_func : OUT std_logic_vector(1 DOWNTO 0):="00";
            func : OUT std_logic_vector(1 DOWNTO 0) :="00";
            data_write : OUT std_logic :='0';
            reg_in_src : OUT std_logic :='0';
            instruction_in : IN std_logic_vector(31 DOWNTO 0) := (OTHERS => '0')

        );
    END COMPONENT;

    -- datapath outputs
    SIGNAL overflow_out : std_logic;
    SIGNAL zero_out : std_logic;

    SIGNAL instruction_out : std_logic_vector(31 DOWNTO 0);
    SIGNAL pc_output : std_logic_vector(31 DOWNTO 0);
    SIGNAL rs_output : std_logic_vector(31 DOWNTO 0);
    SIGNAL rt_output : std_logic_vector(31 DOWNTO 0);
    -- control outputs
    SIGNAL pc_sel : std_logic_vector(1 DOWNTO 0);
    SIGNAL branch_type : std_logic_vector(1 DOWNTO 0);
    SIGNAL reg_dst : std_logic;
    SIGNAL reg_write : std_logic;
    SIGNAL alu_src : std_logic;
    SIGNAL add_sub : std_logic;
    SIGNAL logic_func : std_logic_vector(1 DOWNTO 0);
    SIGNAL func : std_logic_vector(1 DOWNTO 0);
    SIGNAL data_write : std_logic;
    SIGNAL reg_in_src : std_logic;

BEGIN
    ctrl : controller PORT MAP(
        pc_sel => pc_sel,
        branch_type => branch_type,
        reg_dst => reg_dst,
        reg_write => reg_write,
        alu_src => alu_src,
        add_sub => add_sub,
        logic_func => logic_func,
        func => func,
        data_write => data_write,
        reg_in_src => reg_in_src,
        instruction_in => instruction_out
    );

    dp : datapath PORT MAP(
        reset => reset,
        clk => clk,
        pc_sel => pc_sel,
        branch_type => branch_type,
        reg_dst => reg_dst,
        reg_write => reg_write,
        alu_src => alu_src,
        add_sub => add_sub,
        logic_func => logic_func,
        func => func,
        overflow => overflow_out,
        zero => zero_out,
        data_write => data_write,
        reg_in_src => reg_in_src,
        instruction_out => instruction_out,
        rs_out => rs_output,
        rt_out => rt_output,
        pc_out => pc_output
    );

rs_out <=  rs_output(3 downto 0);
rt_out <=  rt_output(3 downto 0);
pc_out <=  pc_output(3 downto 0);
overflow <=  overflow_out;
zero <=  zero_out;


--    rs_out <= not rs_output(3 downto 0);
 --   rt_out <= not rt_output(3 downto 0);
   -- pc_out <= not pc_output(3 downto 0);
    --overflow <= not overflow_out;
    --zero <= not zero_out;

END cpu_arch;
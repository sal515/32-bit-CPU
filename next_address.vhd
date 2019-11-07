-- next address calculation unit
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity next_address is
port(
    rt, rs          : in std_logic_vector(31 downto 0);
    pc              : in std_logic_vector(31 downto 0);
    target_address  : in std_logic_vector(25 downto 0);
    branch_type     : in std_logic_vector(1 downto 0);
    pc_sel          : in std_logic_vector(1 downto 0);
    next_pc         : out std_logic_vector(31 downto 0)
);
end next_address;

architecture next_address_arch of next_address is
    signal branch_out: std_logic_vector(next_pc'length-1 downto next_pc'right);
    signal on_branch_sign_ext: std_logic_vector(next_pc'length-1 downto next_pc'right);
    begin

        branch_select: process(on_branch_sign_ext, rs, rt, branch_type)
        begin
            case branch_type is
                when "00" =>
                    branch_out <= (others=>'0')
                when "01" =>
                    if(rs = rt) then
                        branch_out <= on_branch_sign_ext;         
                    end if;
                when "10" =>
                    if(rs /= rt) then
                        branch_out <= on_branch_sign_ext;
                    end if;
                when "11" =>
                    if(rs < 0) then
                        branch_out <= on_branch_sign_ext;
                    end if;
                when others =>
                    branch_out <= (others=>'U')
            end case;
        end process;


        pc_select: process(pc, branch_out, target_address, rs, pc_sel)
        begin
            case pc_sel is
                when "00" =>
                    next_pc <= pc + branch_out + 1;
                when "01" =>
                    next_pc <= "000000" & target_address;
                when "10" =>
                    next_pc <= rs;
                when others =>
                    next_pc <= (others => 'U'); 
                    --  11 is unused
            end case;
        end process;





end next_address_arch;






-- entity regfile is
-- port( 
--     din : in std_logic_vector(31 downto 0);
--     reset : in std_logic;
--     clk : in std_logic;
--     write : in std_logic;
--     read_a : in std_logic_vector(4 downto 0);
--     read_b : in std_logic_vector(4 downto 0);
--     write_address : in std_logic_vector(4 downto 0);
--     out_a : out std_logic_vector(31 downto 0);
--     out_b : out std_logic_vector(31 downto 0)
--     );
-- end regfile ;


-- architecture register_file_arch of regfile is
--     -- 32 registers in a register file, thus 0 to 31 in reg_arr
--     type register_array is array(0 to 31) of std_logic_vector(din'length-1 downto din'right);
--     signal reg_arr : register_array;

-- begin

--     read: process(read_a, read_b, reg_arr)
--     begin
--             -- converting std vector to integer - to find the appropriate register to access           
--             out_a <= reg_arr(CONV_INTEGER(read_a));
--             out_b <= reg_arr(CONV_INTEGER(read_b)); 
--     end process;

--     reg_file_update: process(clk, reset)
--     begin
        
--         if(reset = '1') then
--             reg_arr <= (others => (others => '0'));
        
--         elsif(clk'event and clk = '1' and write = '1') then
--             reg_arr(CONV_INTEGER(write_address)) <= din;
--         end if;
        
--     end process;



    

-- end register_file_arch ; 


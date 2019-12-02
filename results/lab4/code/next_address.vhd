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

        on_branch_sign_ext((target_address'length-1)-(5+5) downto target_address'right) <= target_address((target_address'length-1)-(5+5) downto target_address'right);
        on_branch_sign_ext(next_pc'length-1 downto target_address'length-(5+5)) <= (others => target_address((target_address'length-1)-(5+5)));


        branch_select: process(on_branch_sign_ext, rs, rt, branch_type)
        begin
            branch_out <= (others=>'0');
            case branch_type is
                when "00" =>
                    branch_out <= (others=>'0');
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
                    branch_out <= (others=>'U');
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


-- 32 x 32 register file
-- two read ports, one write port with write enable
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity regfile is
port( 
    din : in std_logic_vector(31 downto 0);
    reset : in std_logic;
    clk : in std_logic;
    write : in std_logic;
    read_a : in std_logic_vector(4 downto 0);
    read_b : in std_logic_vector(4 downto 0);
    write_address : in std_logic_vector(4 downto 0);
    out_a : out std_logic_vector(31 downto 0);
    out_b : out std_logic_vector(31 downto 0)
    );
end regfile ;


architecture register_file_arch of regfile is
    -- 32 registers in a register file, thus 0 to 31 in reg_arr
    type register_array is array(0 to 31) of std_logic_vector(din'length-1 downto din'right);
    signal reg_arr : register_array;

begin

    read: process(read_a, read_b)
        variable a : integer; 
        variable b : integer;     
    begin
            -- converting std vector to integer - to find the appropriate register to access 
            a := CONV_INTEGER(read_a);
            b := CONV_INTEGER(read_b);
            
            out_a <= reg_arr(a);
            out_b <= reg_arr(b); 
    end process;

    reg_file_update: process(clk, reset)
    begin
        
        if(reset = '1') then
            reg_arr <= (others => (others => '0'));
        
        elsif(clk'event and clk = '1' and write = '1') then
            reg_arr(CONV_INTEGER(write_address)) <= din;
        end if;
        
    end process;



    

end register_file_arch ; 


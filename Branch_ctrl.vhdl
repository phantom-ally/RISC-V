library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.branch_type.all;
entity branch is
PORT(
    is_branch:in std_logic;
    data1:in std_logic_vector(31 downto 0);
    data2:in std_logic_vector(31 downto 0);
    func3:in std_logic_vector(31 downto 0);
    branch_out:out std_logic;
    );
end branch;
architecture model of branch is
begin
    process(data1,data2,func3)
    variable taken :std_logic;
    begin
        taken:='0';
        case func3 is 
            when BEQ =>
                if(data1 = data2) then taken:='1'; end if;
            when BEN =>
                if(data1 /= data2) then taken:='1'; end if;
            when BLT =>
                if(signed(data1) <signed(data2)) then taken:='1'; end if;
            when BGE =>
                if(signed(data1) >= signed(data2)) then taken:='1'; end if;
            when BLTU =>
                if(data1 <data2) then taken:='1'; end if;
            when BGEU =>
                if(data1 >=data2) then taken:='1'; end if;
            when others=>null;
        end case;
        branch_out <= taken AND is_branch;
    end process;
end architecture;            
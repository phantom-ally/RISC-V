library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
Entity Register_b is
Port(
    r1 :in std_logic_vector (4 downto 0);
    r2 :in std_logic_vector(4 downto 0);
    rd: in std_logic_vector(4 downto 0);
    write_data:in std_logic_vector(31 downto 0);
    write_enable:in std_logic;
    data1:out std_logic_vector(31 downto 0);
    data2:out std_logic_vector(31 downto 0);
    reset: in std_logic;
    clock: in std_logic
);
end Register_b;
Architecture behavior of Register_b is
    type register_memory is array (0 to 31) of std_logic_vector(0 to 31);
    signal reg_mm :register_memory;
begin
    process(clock) 
    variable r1_p:integer;
    variable r2_p:integer;
    variable rd_p:integer;
    begin
        if rising_edge(clock) then 
            if reset='1' then 
                reg_mm<=(others=> (others=>'0'));
            else
                rd_p:=to_integer(unsigned(rd)); 
                r1_p:=to_integer(unsigned(r1));
                r2_p:=to_integer(unsigned(r2));
                if write_enable='1' then
                    reg_mm(rd_p)<=write_data;
                end if;
                reg_mm(0)<='00000';
            end if;
        end if;
        data1<=reg_mm(r1_p);
        data2<=reg_mm(r2_p);
    end process;
end behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Instruction_mm is
    PORT(
        Instruction_add : in std_logic_vector(31 downto 0);
        Instruction_data :out std_logic_vector(31 downto 0);
        Instruction_read:in std_logic;
        Reset:in std_logic;
        Clock:in std_logic);
end Instruction_mm;
architecture Model of Instruction_mm is 
type memory_type is array (0 to 1023) of std_logic_vector(7 downto 0);
signal memory:memory_type;
begin 
    process(Clock)
    variable addr:integer;
    begin
        if rising_edge(Clock) then 
            if Instruction_read='1' then 
                addr:=to_integer(unsigned(Instruction_add));   
                Instruction_data <=memory(addr) & memory(addr+1)& memory(addr+2)& memory(addr+3);
            else
            Instruction_data<= (others=>'0');
            end if;
        end if ;
    end process;
end Model;

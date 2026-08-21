library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity fetch is 
PORT(
    Instruction_data:in std_logic_vector(31 downto 0);
    Instruction_add:in std_logic_vector(31 downto 0);
    Instruction_read:in std_logic;
    Reset:in std_logic;
    Clock:in std_logic;
    PC:in std_logic_vector(31 downto 0);
    Instruction: out std_logic_vector(31 downto 0)
     );
end fetch;
architecture model of fetch is 
begin
    process(Clock)
    begin
        if rising_edge(Clock) then 
            if Reset='1' then
                Instruction_read<='0';
            else
                Instruction_read<='1';
                Instruction_add<=PC;
                Instruction<=Instruction_data;
            end if;
        end if;
    end process;   
end model;

-- THERE SHOULD BE FOUR THINGS ADDRESSS FROM PC ,2 ADDRESS TO INSTRUCTION MEMORY ,3 DATA FROM MEMORY ,4 DATA TO DECODER 
-- Define how  instruction data is getting data from instruction address of instruction memory , Define the functionality of it.

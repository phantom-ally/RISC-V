library library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Instruction_decoder is
    PORT(
        Instruction: in std_logic_vector(31 downto 0);
        instruction_type: out srd_logic(2 downto 0);
        reg_2:out std_logic_vector(4 downto 0);
        reg_1:out std_logic_vector(4 downto 0);
        reg_d:out std_logic_vector(4 downto 0);
        func7:out std_logic_vector(6 downto 0);
        func3:out std_logic_vector(2 downto 0);
        opcode: out std_logic_vector(6 downto 0);
        immediate : out srd_logic_vector(31 downto 0)
    );
end Instruction_decoder;
architecture  decoding of Instruction_decoder is
begin
     process(Instruction)
     begin
        case Instruction(6 downto 0) is 
        when '0110011' =>
            Instruction_type<='001';                                --001 is for R type instruction
            func7<= Instruction(31 downto 25);
            reg_2<=Instruction(24 downto 20);
            reg_1<=Instruction(19 downto 15);
            func3<= Instruction(14 downto 12);
            reg_d<=Instruction(11 downto 7);
            opcode<=Instruction(6 downto 0);
        when '0010011' | '0000011' | '1100111' | '1110011' => 
            Instruction_type<='010';                                --010 IS FOR I type instruction   
            Immediate<=Instruction(31 downto 20);
            reg_1<=Instruction(19 downto 15);
            func3<= Instruction(14 downto 12);
            reg_d<=Instruction(11 downto 7);
            opcode<=Instruction(6 downto 0);
        when '0100011' => 
            Instruction_type<='011';                                --011 IS FOR S type instruction   
            Immediate<=Instruction(31 downto 25) & Instruction(11 downto 7);
            reg_2<=Instruction(24 downto 20);
            reg_1<=Instruction(19 downto 15);
            func3<= Instruction(14 downto 12);
            opcode<=Instruction(6 downto 0);
        when '1100011' => 
            Instruction_type<='100';                                --100 IS FOR B type instruction   
            Immediate<=Instruction(31) & Instruction(7) & Instruction(30 downto 25) & Instruction(11 downto 8);
            reg_2<=Instruction(24 downto 20);
            reg_1<=Instruction(19 downto 15);
            func3<= Instruction(14 downto 12);
            opcode<=Instruction(6 downto 0);
        when '0110111' | '0010111' => 
            Instruction_type<='101';                                --101 IS FOR U type instruction
            Immediate<=Instruction(31 downto 12);
            reg_d<=Instruction(11 downto 7);
            opcode<=Instruction(6 downto 0);
        when '1101111' => 
            Instruction_type<='110';                                --110 IS FOR J type instruction  
            Immediate<=Instruction(31 downto 12);
            reg_d<=Instruction(11 downto 7);
            opcode<=Instruction(6 downto 0);
        when others=>
            Instruction_type<='000'; 
        end case;   
        
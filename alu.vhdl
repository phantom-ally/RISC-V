library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.alu_ip.all;
entity alu is
port(
    input1:in std_logic_vector(31 downto 0);
    input2:in std_logic_vector(31 downto 0);
    write_data:out std_logic_vector(31 downto 0);
    operation:in alu_op;
);
end entity;
architecture functioning of alu is 
begin
    process(input1,input2) 
    begin
        case operation  is
            when ADD => 
                write_data<=std_logic_vector(unsigned(input1)+unsigned(input2));
            when SUB => 
                write_data<=std_logic_vector(unsigned(input1)-unsigned(input2));
            when MUL => 
                write_data<=std_logic_vector(unsigned(input1)*unsigned(input2));
            when DIV => 
                write_data<=std_logic_vector(unsigned(input1)/unsigned(input2));
            when MOD => 
                write_data<=std_logic_vector(unsigned(input1)%unsigned(input2));
            when AND_ => 
                write_data<=std_logic_vector(unsigned(input1) AND unsigned(input2));
            when OR => 
                write_data<=std_logic_vector(unsigned(input1) OR unsigned(input2));
            when NAND => 
                write_data<=std_logic_vector(unsigned(input1) NAND unsigned(input2));
            when XOR => 
                write_data<=std_logic_vector(unsigned(input1) XOR unsigned(input2));
            when SLLI | SLL => 
                write_data<=std_logic_vector(shift_left(unsigned(input1),to_integer(unsigned(input2))));
            when SRLI | SRL=> 
                write_data<=std_logic_vector(shift_right(unsigned(input1),to_integer(unsigned(input2))));
            when SRAI | SRA => 
                write_data<=std_logic_vector(shift_right(signed(input1),to_integer(unsigned(input2))));
            when SLT =>
                write_data<=std_logic_vector(signed(input1)<signed(input2));
            when SLTU =>
                write_data<=std_logic_vector(unsigned(input1)<unsigned(input2));
        end case;
    end process;
end functioning;  
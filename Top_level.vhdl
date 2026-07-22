library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.Alu_ip.all;
use work.Data_type.all;
use work.branch_type.all;
entity top_level is
    PORT(
    Reset:in std_logic ;
    Clock:in  std_logic
);
end entity;
Architecture beh of top_level is
    signal Instruction_add,Instruction_data,Instruction,immediate,write_data:std_logic_vector(31 downto 0);
    signal data1,data2,alu_inp1,alu_inp2,alu_out:std_logic_vector(31 downto 0);
    signal data_address,mm_data_out:std_logic_vector(31 downto 0);
    signal Instruction_read,write_enable,data_wr_enable,data_req,data_zero_exd,branch_out:std_logic;
    signal Instruction_type,func3:std_logic_vector(2 downto 0);
    signal opcode,func7,:std_logic_vector(6 downto 0);
    signal reg_1,reg_2,reg_d :in std_logic_vector (4 downto 0);
    signal data_size :D_type;
    signal operation :alu_op;
begin
    Instruct_mm:entity work.Instruction_mm
    port map(
        Instruction_add=>Instruction_add,
        Instruction_data=>Instruction_data,
        Instruction_read=>Instruction_read,
        Reset=>Reset,
        Clock=>Clock);
    Fetch:entity work.Fetch
    port map(Instruction_add=>Instruction_add,
        Instruction_data=>Instruction_data,
        Instruction_read=>Instruction_read,
        Reset=>Reset,
        PC=>PC,
        Instruction=>Instruction,
        Clock=>Clock);
    Decode:entity work.Instruction_decoder 
    port map(
        Instruction=>Instruction,
        Instruction_type=>instruction_type,
        reg_1=>reg_1,
        reg_2=>reg_2,
        reg_d=>reg_d,
        func7=>func7,
        func3=>func3,
        opcode=>opcode,
        immediate=>immediate);
    RB:entity work.Register_b 
    port map(
        r1=>reg_1,
        r2=>reg_2,
        rd=>reg_d,
        write_data=>write_data,
        write_enable=>write_enable,
        data1=>data1,
        data2=>data2,
        reset=>reset,
        clock=>clock);
    ALUb:entity work.ALU
    port map(
        input1=>alu_inp1;
        input2=>alu_inp2;
        write_data=>alu_out;
        operation=>alu_op;
    );
    data_memory:entity work.Data_mm
    port map(
        Clock=>Clock,
        data_address=>data_address,
        data1=>data1,
        mm_data_out=>mm_data_out,
        data_wr_enable=>data_wr_enable,
        data_size=>data_size,
        data_req=>data_req,
        data_zero_exd=>data_zero_exd
    );
    branch_ctrl:entity work.branch
    port map(
        data1=>data1,
        data2=>data2,
        is_branch=>is_branch,
        func3=>func3,
        func7=>func7,
        branch_out=>branch_out
    );
end beh; 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
package Alu_ip is
    subtype Alu_op is std_logic_vector(4 downto 0);
        Constant ADD  : Alu_op:="00000";
        Constant SUB  : Alu_op:="00001";
        Constant MUL  : Alu_op:="00010";
        Constant DIV  : Alu_op:="00011";
        Constant MOD  : Alu_op:="00100";
        Constant AND_ : Alu_op:="00101";
        Constant OR_  : Alu_op:="00110";
        Constant NAND_: Alu_op:="00111";
        Constant XOR_ : Alu_op:="01001";
        Constant SLLI : Alu_op:="01010";
        Constant SRLI : Alu_op:="01011";
        Constant SLAI : Alu_op:="01001";
        Constant SLL  : Alu_op:="01010";
        Constant SRL  : Alu_op:="01011";
        Constant SLA  : Alu_op:="01100";
        Constant SLT  : Alu_op:="01101";
        Constant SLTU : Alu_op:="01110";
end package Alu_ip;
package body Alu_ip is
end  package body Alu_ip;
package Data_type is
    subtype D_type is std_logic_vector(1 downto 0);
    constant BYTE : D_type :="00";  
    constant HALF_WORD : D_type :="01";  
    constant WORD : D_type :="11";
    function zero_extend(data:std_logic_vector;out_width:integer)return std_logic_vector;
    function sign_extend(data:std_logic_vector;out_width:integer)return std_logic_vector ;
    -- subtype width_D_type is std_logic_vector(5 downto 0);
    --  function get_width(datatypes :D_type) return width_D_type;
    end package Data_type;
package body Data_type is
    function zero_extend(data:std_logic_vector; out_width:integer)return std_logic_vector is 
        variable result:std_logic_vector(out_width-1 downto 0);
        begin
            result:=(others=>'0');
            result(data'length-1 downto 0):=data;
            return result;
        end function;
    function sign_extend(data:std_logic_vector;out_width:integer)return std_logic_vector is
        variable result:std_logic_vector(out_width-1 downto 0);
        begin
            result:=(others=>data(data'high));
            result(data'length-1 downto 0):= data;
            return result;
            end function;
    -- function get_width(datatypes:D_type) return width_D_type is
    -- begin        
    -- case Datatypes is 
    -- when BYTE =>return "001000";
    -- when HALF_WORD => return "010000";
    -- when WORD => return "100000";
    --     when others => return "000000";
    -- end case;
    -- end function;
end package body Data_type;
package B_type is
    subtype b_type_ins is std_logic_vector(0 to 2);
    constant BEQ:b_type_ins:="000";
    constant BEN:b_type_ins:="001";
    constant BLT:b_type_ins:="100";
    constant BGE:b_type_ins:="101";
    constant BLTU:b_type_ins:="110";
    constant BGEU:b_type_ins:="111";
end package B_type;
package body B_type is
end package body B_type;
package R_type is
    subtype R_type_ins is std_logic_vector(4 downto 0);
       Constant R_ADD  : R_type_ins:="00000";
        Constant R_SUB  : R_type_ins:="00001";
        Constant R__MUL  : R_type_ins:="00010";
        Constant R_DIV  : R_type_ins:="00011";
        Constant R_MOD  : R_type_ins:="00100";
        Constant R_AND_ : R_type_ins:="00101";
        Constant R_OR  : R_type_ins:="00110";
        Constant R_NAND: R_type_ins:="00111";
        Constant R_XOR : R_type_ins:="01001";
        Constant R_SLLI : R_type_ins:="01010";
        Constant R_SRLI : R_type_ins:="01011";
        Constant R_SLAI : R_type_ins:="01001";
        Constant R_SLL  : R_type_ins:="01010";
        Constant R_SRL  : R_type_ins:="01011";
        Constant R_SLA  : R_type_ins:="01100";
        Constant R_SLT  : R_type_ins:="01101";
        Constant R_SLTU : R_type_ins:="01110";
end package R_type;
package body R_type is 
end package body R_type;
package I_type is
    subtype I_type_ins is std_logic_vector( 3 downto 0);
    constant I_LB:I_type_ins:="0000";
    constant I_LH:I_type_ins:="0001";
    constant I_LW:I_type_ins:="0010";
    constant I_LBU:I_type_ins:="0011";
    constant I_LHU:I_type_ins:="0100";
    constant I_SLLI:I_type_ins:="0101";
    constant I_SRLI_SRAI:I_type_ins:="0110";
    constant I_ADDI:I_type_ins:="0111";
    constant I_SLTI:I_type_ins:="1000";
    constant I_SLTIU:I_type_ins:="1001";
    constant I_AND:I_type_ins:="1010";
    constant I_OR:I_type_ins:="1011";
    constant I_NAND:I_type_ins:="1100";
    constant I_XOR:I_type_ins:="1101";
end package I_type;
package body I_type is 
end package body I_type;
package S_type is 
    subtype S_type_ins is std_logic_vector(1 downto 0 )
    constant S_LB:S_type_ins:="00";
    constant S_LH:S_type_ins:="01";
    constant S_LW:S_type_ins:="10";
end package S_type;
package body S_type is 
end package body S_type; 
package  SRC_type is
    subtype SRC_type_ins is std_logic_vector(1 downto 0)
    constant SRC_ALU:SRC_type_ins:="00";
    constant SRC_MEM:SRC_type_ins:="01";
    constant SRC_IMM:SRC_type_ins:="10";
    constant SRC_PC:SRC_type_ins:="11";
end package;
package body S_type is 
end package body S_type; 
package  control_var is
    subtype compos is std_logic_vector(2 downto 0)
    constant zero_extend :compos :="000";
    constant mem_valid :compos :="001";
    constant mem_write :compos :="010";
    constant imme :compos :="011";
    constant  :compos :="100";
    
end package;
package body S_type is 
end package body ; 
    

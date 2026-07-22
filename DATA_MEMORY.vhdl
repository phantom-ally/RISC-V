library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.Data_type.all;
entity Data_mm is
    generic(
        WIDTH:INTEGER:=8;
        SPACE:INTEGER:=8;
        BUS_width:INTEGER:=32;
    );
    port(
        Clock:in std_logic;
        data_address:in std_logic_vector(31 downto 0);
        data1:in std_logic_vector(BUS_Width-1 downto 0);
        mm_data_out:out std_logic_vector(31 downto 0);
        data_wr_enable:in std_logic;
        data_size:in D_type;
        data_req:in std_logic;
        data_zero_exd:in std_logic;
    );
end Data_mm;
architecture functionality of Data_mm is 
type Data_memory is array(0 to (2**SPACE)-1) of std_logic_vector((WIDTH-1) downto 0);
signal RAM : Data_memory;
begin
    process(Clock)
    variable data_ptr:integer;
    begin
        data_ptr:=to_integer(unsigned(data_address(SPACE-1 downto 0)));
        if rising_edge(Clock) then 
            if data_wr_enable='1' and data_req='1' then
            case data_size is
                when BYTE =>
                RAM(data_ptr)<=data1(7 downto 0);
                when HALF_WORD => 
                RAM(data_ptr+1)<=data1(15 downto 8);
                RAM(data_ptr)<=data1(7 downto 0);                            
                when WORD => 
                    RAM(data_ptr+3)<=data1(31 downto 24);
                    RAM(data_ptr+2)<=data1(23 downto 16);
                    RAM(data_ptr+1)<=data1(15 downto 8);
                    RAM(data_ptr)<=data1(7 downto 0);
                    when others=>null;
                end case;
            end if;
        end if;
    end process;
    process(all)
        variable data_ptr:integer;
    begin
        data_ptr:=to_integer(unsigned(data_address(SPACE-1 downto 0)));
    if data_wr_enable='0' and data_req='1' then
        if data_zero_exd ='1' then
            case data_size is
                when BYTE => mm_data_out<=zero_extend(RAM(data_ptr),BUS_Width);
                when HALF_WORD => mm_data_out<=zero_extend(RAM(data_ptr+1)&RAM(data_ptr),BUS_Width);
                when WORD => mm_data_out<=zero_extend(RAM(data_ptr+3)&RAM(data_ptr+2)& RAM(data_ptr+1)&RAM(data_ptr+0),BUS_Width);
                when others=>null;
            end case;
        else 
            case data_size is
                when BYTE => mm_data_out<=sign_extend(RAM(data_ptr),BUS_Width);
                when HALF_WORD => mm_data_out<=sign_extend(RAM(data_ptr+1)&RAM(data_ptr),BUS_Width);
                when WORD => mm_data_out<=sign_extend(RAM(data_ptr+3)&RAM(data_ptr+2)& RAM(data_ptr+1)&RAM(data_ptr+0),BUS_Width);
                when others=>null;
            end case;
        end if;
    end if;
    end process;
end architecture;
-- make it handle conditions where Suppose SPACE = 8 Then you're using 8 bits as the byte address and RAM has:256 bytes  
--A word access uses:RAM(data_ptr+3)If data_ptr = 255
--then 255 256 257 258 which is outside the RAM.
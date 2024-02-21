LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE std.textio.all;
USE std.standard.all;

-- New version 991203 abn

entity FILE_READ is
  generic (file_name : string; width : positive; datadelay : time);
  port (CLK, RESET :  in std_logic;
                 Q : out std_logic_vector(width-1 downto 0));
end FILE_READ;

architecture BEHAVE of FILE_READ is
begin
  process(clk)
    file INFILE : text is in FILE_NAME;
    variable IN_LINE : line;
    variable QDATA : integer;
  begin
    if (clk = '1') and (clk'event) then
      if (not(endfile(INFILE))) and (RESET='1') then
	readline(INFILE, IN_LINE);
	read(IN_LINE, QDATA);
	Q <= conv_std_logic_vector(QDATA,width) after datadelay;
      else
	Q <= conv_std_logic_vector(    0,width);
      end if;
    end if;
  end process;
end BEHAVE;

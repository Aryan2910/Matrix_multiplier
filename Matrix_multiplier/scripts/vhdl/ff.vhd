

library IEEE;
  use IEEE.std_logic_1164.all;


entity FF is
  generic(N:integer:=1);
  port(   D  :  in std_logic_vector(N-1 downto 0);
          Q  : out std_logic_vector(N-1 downto 0);
        clk  :  in std_logic
      );
end FF;



architecture BEHAVIORAL of FF is
begin

  process (clk)
  begin
    if (clk = '1') and (clk'EVENT) then
      Q <= D;
    end if;
  end process;
end BEHAVIORAL;





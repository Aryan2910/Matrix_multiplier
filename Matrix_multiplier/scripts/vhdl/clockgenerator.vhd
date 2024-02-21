

library IEEE;
  use IEEE.std_logic_1164.all;


entity CLOCKGENERATOR is
  generic( clkhalfperiod :time := 100 ns );
  port( clk : out std_logic);
end CLOCKGENERATOR;


architecture BEHAVIORAL of CLOCKGENERATOR is 
signal dummyclk : std_logic := '0';
begin
  process
  begin
    wait for clkhalfperiod;
    dummyclk <= not dummyclk;
    clk <= dummyclk;
  end process;
end BEHAVIORAL;

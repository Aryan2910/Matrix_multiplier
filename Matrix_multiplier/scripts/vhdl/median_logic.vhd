

library IEEE;
  use IEEE.std_logic_1164.all;


entity MEDIAN_LOGIC is
  port(  a :  in  std_logic;
         b :  in  std_logic;
         c :  in  std_logic;
         q :  out std_logic;
         w :  out std_logic
      );
end MEDIAN_LOGIC;



architecture BEHAVIORAL of MEDIAN_LOGIC is
begin
  process(a,b,c)
  variable abc:std_logic_vector(2 downto 0);
  variable qw:std_logic_vector(1 downto 0);
  begin
    abc := a & b & c;
    case abc is
      when "001" =>
      qw := "00";
      when "010" =>
      qw := "X1";
      when "011" =>
      qw := "10";
      when "100" =>
      qw := "10";
      when "101" =>
      qw := "X1";
      when "110" =>
      qw := "00";
      when others =>
      qw := "XX";
    end case;
    q <= qw(1);
    w <= qw(0);
  end process;
end BEHAVIORAL;


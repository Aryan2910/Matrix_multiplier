

library IEEE;
  use IEEE.std_logic_1164.all;


entity MUX2 is
  generic(N:integer:=1);
  port(  IN0 :  in std_logic_vector(N-1 downto 0);
         IN1 :  in std_logic_vector(N-1 downto 0);
           Q : out std_logic_vector(N-1 downto 0);
         SEL :  in std_logic
      );
end MUX2;



architecture BEHAVIORAL of MUX2 is
begin
  process(IN0,IN1,SEL)
  begin
    Q <= IN0;
    if SEL='0' then
      Q <= IN0;
    elsif SEL='1' then
      Q <= IN1;
    end if;
  end process;
end BEHAVIORAL;


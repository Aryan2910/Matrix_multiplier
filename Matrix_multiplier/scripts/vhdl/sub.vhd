

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_signed.all;


entity SUB is
  generic(N:integer:=1);
  port(  POS :  in std_logic_vector(N-1 downto 0);
         NEG :  in std_logic_vector(N-1 downto 0);
           Q : out std_logic_vector(  N downto 0)
      );
end SUB;



architecture BEHAVIORAL of SUB is
signal pos2 : std_logic_vector(N downto 0);
signal neg2 : std_logic_vector(N downto 0);
begin
  pos2(N-1 downto 0) <= POS;
  pos2(  N downto N) <= POS(N-1 downto N-1);
  neg2(N-1 downto 0) <= NEG;
  neg2(  N downto N) <= NEG(N-1 downto N-1);
  Q <= pos2 - neg2 ;
end BEHAVIORAL;







library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_signed.all;
  use IEEE.std_logic_arith.all;


entity MEDIANFILTER_BEHAVIORAL is
  generic(N:integer:=8);
  port(
         INP :  in std_logic_vector(N-1 downto 0);
         UTP : out std_logic_vector(N-1 downto 0);
         CLK :  in std_logic
      );
end MEDIANFILTER_BEHAVIORAL;


architecture BEHAVIORAL of MEDIANFILTER_BEHAVIORAL is


begin
  process
  variable p,q,r : integer;
  variable utd : integer;
  begin
    wait until CLK'event and CLK = '1';
    r:=q;
    q:=p;
    p:=conv_integer(INP);
    UTP <= conv_std_logic_vector(utd,N);
    utd := p;
    if    ( ( (p>=q) and (p<=r) ) or
            ( (p<=q) and (p>=r) ) ) then
      utd := p;
    elsif ( ( (q>=p) and (q<=r) ) or
            ( (q<=p) and (q>=r) ) ) then
      utd := q;
    elsif ( ( (r>=q) and (r<=p) ) or
            ( (r<=q) and (r>=p) ) ) then
      utd := r;
    end if;
  end process;
end BEHAVIORAL;





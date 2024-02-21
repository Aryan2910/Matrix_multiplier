

library IEEE;
  use IEEE.std_logic_1164.all;


entity MEDIANFILTER is
  generic(N:integer:=8);
  port(
         INP :  in std_logic_vector(N-1 downto 0);
         UTP : out std_logic_vector(N-1 downto 0);
         clk :  in std_logic
      );
end MEDIANFILTER;



architecture STRUCTURAL of MEDIANFILTER is
  component FF
  generic(N:integer:=1);
  port(   D  :  in std_logic_vector(N-1 downto 0);
          Q  : out std_logic_vector(N-1 downto 0);
        clk  :  in std_logic
      );
  end component;
  component MUX2
  generic(N:integer:=1);
  port(  IN0 :  in std_logic_vector(N-1 downto 0);
         IN1 :  in std_logic_vector(N-1 downto 0);
           Q : out std_logic_vector(N-1 downto 0);
         SEL :  in std_logic
      );
  end component;
  component SUB
  generic(N:integer:=1);
  port(  POS :  in std_logic_vector(N-1 downto 0);
         NEG :  in std_logic_vector(N-1 downto 0);
           Q : out std_logic_vector(  N downto 0)
      );
  end component;
  component MEDIAN_LOGIC
  port(  a :  in  std_logic;
         b :  in  std_logic;
         c :  in  std_logic;
         q :  out std_logic;
         w :  out std_logic
      );
  end component;

  signal inp1,inp2,inp3,mux0,utp0 : std_logic_vector(N-1 downto 0);
  signal a,b,c,q,w : std_logic;
  signal aa,bb,cc : std_logic_vector(N downto 0);

begin

  FF_0  : ff generic map (N=>N)
    port map( D => INP,  Q => inp1, clk => clk );
  FF_1  : ff generic map (N=>N)
    port map( D => inp1, Q => inp2, clk => clk );
  FF_2  : ff generic map (N=>N)
    port map( D => inp2, Q => inp3, clk => clk );

  MUX2_0 : mux2 generic map (N=>N)
    port map( IN0 => inp1, IN1 => inp2, Q => mux0, SEL => q );
  MUX2_1 : mux2 generic map (N=>N)
    port map( IN0 => mux0, IN1 => inp3, Q => utp0, SEL => w );

  FF_3  : ff generic map (N=>N)
    port map( D => utp0, Q => UTP, clk => clk );

  SUB_0 : sub generic map (N=>N)
    port map( POS => inp3, NEG => inp1, Q => aa );
  SUB_1 : sub generic map (N=>N)
    port map( POS => inp1, NEG => inp2, Q => bb );
  SUB_2 : sub generic map (N=>N)
    port map( POS => inp2, NEG => inp3, Q => cc );

  a <= aa(N);
  b <= bb(N);
  c <= cc(N);

  LOGIC : median_logic
    port map( a=>a, b=>b, c=>c, q=>q, w=>w );



end STRUCTURAL;





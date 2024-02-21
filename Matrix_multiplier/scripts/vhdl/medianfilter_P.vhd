--
-- File: medianfilter_P.vhd
--
-- Pads are inserted here since it does not seem possible to do in
-- the Design Compiler.
--

library IEEE, IO65LPHVT_SF_1V8_50A_7M4X0Y2Z;
  use IEEE.std_logic_1164.all;
  use IO65LPHVT_SF_1V8_50A_7M4X0Y2Z.all;


entity MEDIANFILTER is
  generic(N:integer:=8);
  port(
         INP : inout std_logic_vector(N-1 downto 0);
         UTP : inout std_logic_vector(N-1 downto 0);
         clk : inout std_logic
      );
end MEDIANFILTER;


architecture STRUCTURAL of MEDIANFILTER is

  component BD2SCARUDQP_1V8_SF_LIN
    port( ZI :  out std_logic;
           A :  in std_logic;
          EN :  in std_logic;
          TA :  in std_logic;
         TEN :  in std_logic;
          TM :  in std_logic;
         PUN :  in std_logic;
         PDN :  in std_logic;
        HYST :  in std_logic;
          IO :  inout std_logic );  -- Pad Surface
  end component;

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
  signal INPi, UTPi : std_logic_vector(N-1 downto 0);
  signal clki : std_logic;
  signal a,b,c,q,w : std_logic;
  signal aa,bb,cc : std_logic_vector(N downto 0);

  signal HIGH, LOW : std_logic;

begin

  HIGH <= '1';
  LOW  <= '0';

  InPads : for i in 0 to N-1 generate
    InPad : BD2SCARUDQP_1V8_SF_LIN
      port map( IO => INP(i), ZI => INPi(i), A => LOW, EN => HIGH, TA => LOW,
              TEN => HIGH, TM => LOW, PUN => LOW, PDN => LOW, HYST => LOW);
  end generate InPads;

  clkpad : BD2SCARUDQP_1V8_SF_LIN
    port map (IO => clk, ZI => clki, A => LOW, EN => HIGH, TA => LOW,
	      TEN => HIGH, TM => LOW, PUN => LOW, PDN => LOW, HYST => LOW); 

  OutPads : for i in 0 to N-1 generate
    OutPad : BD2SCARUDQP_1V8_SF_LIN
      port map(IO => UTP(i), A => UTPi(i), EN => LOW, TA => LOW,
          TEN => LOW, TM => LOW, PUN => HIGH, PDN => HIGH, HYST => LOW);
  end generate OutPads;

  FF_0  : ff generic map (N=>N)
    port map( D => INPi,  Q => inp1, clk => clki );
  FF_1  : ff generic map (N=>N)
    port map( D => inp1, Q => inp2, clk => clki );
  FF_2  : ff generic map (N=>N)
    port map( D => inp2, Q => inp3, clk => clki );

  MUX2_0 : mux2 generic map (N=>N)
    port map( IN0 => inp1, IN1 => inp2, Q => mux0, SEL => q );
  MUX2_1 : mux2 generic map (N=>N)
    port map( IN0 => mux0, IN1 => inp3, Q => utp0, SEL => w );

  FF_3  : ff generic map (N=>N)
    port map( D => utp0, Q => UTPi, clk => clki );

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





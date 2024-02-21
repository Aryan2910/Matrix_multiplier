

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_signed.all;

entity MEDIANFILTER_TB is
  constant N:integer         :=  8;
  constant halfperiod:time   := 20 ns;
  constant dataskew:time     :=  5 ns;
end MEDIANFILTER_TB;




architecture TESTBENCH of MEDIANFILTER_TB is
component MEDIANFILTER_BEHAVIORAL
  generic( N:integer );
  port(
         INP : in  std_logic_vector(N-1 downto 0);
         UTP : out std_logic_vector(N-1 downto 0);
         CLK : in  std_logic
      );
end component;
component CLOCKGENERATOR
  generic( clkhalfperiod :time );
  port(
         clk : out std_logic
      );
end component;
component MEDIANFILTER
--  generic( N:integer );
  port(
         INP : inout std_logic_vector(N-1 downto 0);
         UTP : inout std_logic_vector(N-1 downto 0);
         clk : inout std_logic
      );
  end component;
component FILE_READ
  generic ( file_name : string; width : positive ; datadelay : time);
  port(
    CLK, RESET :  in std_logic;
             Q : out std_logic_vector(width-1 downto 0)
  );
end component;

signal inputbus  : std_logic_vector(N-1 downto 0);
signal outputbus  : std_logic_vector(N-1 downto 0);
signal outputbus2 : std_logic_vector(N-1 downto 0);
signal clock     : std_logic;
signal logic_1   : std_logic;
signal error : integer;

signal outputbus_int,outputbus2_int,inputbus_int  : integer;

begin

  logic_1 <= '1';


  CLOCKGEN: clockgenerator
  generic map ( clkhalfperiod => halfperiod )
  port map( clk => clock );

  TESTGEN: file_read
  generic map ( file_name => "testvectors.txt", width =>N, datadelay => dataskew )
  port map( clk => clock, reset => logic_1, Q => inputbus );

  DUT: medianfilter
--  generic map (N=>N)
  port map( INP => inputbus, clk => clock, UTP => outputbus );

  CMP: medianfilter_behavioral
  generic map (N=>N)
  port map( INP => inputbus, clk => clock, UTP => outputbus2 );


  process
  variable err,int1,int2,int3 : integer := 0;
  begin
    wait until clock'event and clock = '1';
    if( outputbus /= outputbus2 ) then
      err := err + 1;
    end if;
  error <= err;
  int1:=conv_integer(outputbus);  --integer conversion to simplify read
  int2:=conv_integer(outputbus2);
  int3:=conv_integer(inputbus);
  outputbus_int<=int1;
  outputbus2_int<=int2;
  inputbus_int<=int3;
  end process;


end TESTBENCH;

--configuration CFG_SYN_MEDIANFILTER_TB of MEDIANFILTER_TB is
--  for TESTBENCH
--    for DUT : medianfilter
--      use entity WORK.MEDIANFILTER_N8(SYN_STRUCTURAL);
--    end for;
--  end for;
--end CFG_SYN_MEDIANFILTER_TB;


configuration CFG_MEDIANFILTER_TB of MEDIANFILTER_TB is
  for TESTBENCH
  end for;
end CFG_MEDIANFILTER_TB;


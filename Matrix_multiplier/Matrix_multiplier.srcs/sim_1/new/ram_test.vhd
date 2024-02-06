library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ram_test is
end;

architecture bench of ram_test is

  component RAM_controller
      Port ( clk : in STD_LOGIC;
             rst : in STD_LOGIC;
             load : in STD_LOGIC;
             read_ram : in std_logic;
             mul_en : in std_logic;
             MU_1_in : in STD_LOGIC_VECTOR (15 downto 0);
             MU_2_in : in STD_LOGIC_VECTOR (15 downto 0);
             MU_3_in : in STD_LOGIC_VECTOR (15 downto 0);
             MU_4_in : in STD_LOGIC_VECTOR (15 downto 0);
             MU_1_2_out : out STD_LOGIC_VECTOR (31 downto 0);
             MU_3_4_out : out STD_LOGIC_VECTOR (31 downto 0); 
             ready_to_start : out std_logic);
  end component;

  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal load: STD_LOGIC;
  signal read_ram: std_logic;
  signal mul_en: std_logic;
  signal MU_1_in: STD_LOGIC_VECTOR (15 downto 0);
  signal MU_2_in: STD_LOGIC_VECTOR (15 downto 0);
  signal MU_3_in: STD_LOGIC_VECTOR (15 downto 0);
  signal MU_4_in: STD_LOGIC_VECTOR (15 downto 0);
  signal MU_1_2_out: STD_LOGIC_VECTOR (31 downto 0);
  signal MU_3_4_out: STD_LOGIC_VECTOR (31 downto 0);
  signal ready_to_start: std_logic;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: RAM_controller port map ( clk            => clk,
                                 rst            => rst,
                                 load           => load,
                                 read_ram       => read_ram,
                                 mul_en         => mul_en,
                                 MU_1_in        => MU_1_in,
                                 MU_2_in        => MU_2_in,
                                 MU_3_in        => MU_3_in,
                                 MU_4_in        => MU_4_in,
                                 MU_1_2_out     => MU_1_2_out,
                                 MU_3_4_out     => MU_3_4_out,
                                 ready_to_start => ready_to_start );

  stimulus: process
  begin
  
    -- Put initialisation code here
    

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;




library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ram_test is
end;

architecture bench of ram_test is

  component RAM_controller
      Port ( clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             read_ram : in std_logic;
             MU_in : in STD_LOGIC_VECTOR (287 downto 0);
             RAM_out : out STD_LOGIC_VECTOR (8 downto 0);
             ready_to_start : out std_logic;
             fini : out std_logic
             );
  end component;

  signal clk: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal read_ram: std_logic;
  signal MU_in: STD_LOGIC_VECTOR (287 downto 0);
  signal ready_to_start: std_logic;
  signal fini: std_logic;
  signal RAM_out : std_logic_vector (8 downto 0);
  signal tb_clk : std_logic := '0';
  constant clock_period: time := 10 ns;
    
begin

  uut: RAM_controller port map ( clk            => clk,
                                 reset            => reset,
                                 read_ram       => read_ram,
                                 MU_in        => MU_in,
                                 RAM_out     => RAM_out,
                                 ready_to_start => ready_to_start,
                                 fini => fini );

tb_clk <= not clk after clock_period/2;
clk <= tb_clk;
  stimulus: process
  begin
    reset <= '1';
        read_ram <= '0';
     MU_in <= (others => '0');
    -- Put initialisation code here
     wait for 20 * clock_period;
     read_ram <= '1';
     reset <= '0';
     --wait for 144 * clock_period;
     MU_in <= "000000001000000011000000000000000001000000000000000010000000000000000011000000000000000100000000000000000101000000000000000110000000000000000111000000000000001001000000000000001010000000000000001011000000000000001100000000000000001101000000000000001110000000000000001111000000000000010000";
     wait for 112 * clock_period;
     read_ram <= '0';
     MU_in <= (others => '0');
     wait for 50 * clock_period;
     read_ram <= '1';
     MU_in <= "000000000000000011000000000000000001000000000000000010000000000000000011000000000000000100000000000000000101000000000000000110000000000000000111000000000000001001000000000000001010000000000000001011000000000000001100000000000000001101000000000000001110000000000000001111000000000000010000";   
     wait for 32 * clock_period;
     read_ram <= '0';
     MU_in <= (others => '0');
     wait for 50 * clock_period;
     read_ram <= '1';
     MU_in <= "000000000000000011000000000000000001000000000000000010000000000000000011000000000000000100000000000000000101000000000000000110000000000000000111000000000000001001000000000000001010000000000000001011000000000000001100000000000000001101000000000000001110000000000000001111000000000000010000";   
     wait for 32 * clock_period;
     read_ram <= '0';
     MU_in <= (others => '0');
     wait for 50 * clock_period;
     read_ram <= '1';
     MU_in <= "000000000000000011000000000000000001000000000000000010000000000000000011000000000000000100000000000000000101000000000000000110000000000000000111000000000000001001000000000000001010000000000000001011000000000000001100000000000000001101000000000000001110000000000000001111000000000000010000";   
     wait for 32 * clock_period;
     read_ram <= '0';
     MU_in <= (others => '0');
     wait for 50 * clock_period;
     read_ram <= '1';
     MU_in <= "000000000000000011000000000000000001000000000000000010000000000000000011000000000000000100000000000000000101000000000000000110000000000000000111000000000000001001000000000000001010000000000000001011000000000000001100000000000000001101000000000000001110000000000000001111000000000000010000";   
      
    
    -- Put test bench stimulus code here


    wait;
  end process;

end;




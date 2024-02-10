-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 5.2.2024 21:38:55 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_TOP is
end tb_TOP;

architecture tb of tb_TOP is

    component TOP
        port (clk      : in std_logic;
              reset    : in std_logic;
              ready    : in std_logic;
              input    : in std_logic_vector (7 downto 0);
              MU_1_out : out std_logic_vector (15 downto 0);
              MU_2_out : out std_logic_vector (15 downto 0);
              MU_3_out : out std_logic_vector (15 downto 0);
              MU_4_out : out std_logic_vector (15 downto 0));
    end component;

    signal clk      : std_logic;
    signal reset    : std_logic;
    signal ready    : std_logic;
    signal input    : std_logic_vector (7 downto 0);
    signal MU_1_out : std_logic_vector (15 downto 0);
    signal MU_2_out : std_logic_vector (15 downto 0);
    signal MU_3_out : std_logic_vector (15 downto 0);
    signal MU_4_out : std_logic_vector (15 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : TOP
    port map (clk      => clk,
              reset    => reset,
              ready    => ready,
              input    => input,
              MU_1_out => MU_1_out,
              MU_2_out => MU_2_out,
              MU_3_out => MU_3_out,
              MU_4_out => MU_4_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2;

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        ready <= '1';
        input <= (others => '0');
        ready <= '0';

        -- Reset generation
        wait for 20 * TbPeriod;
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;
        input <= "10001000";
        wait for 20 ns;
        -- EDIT Add stimuli here
        input <= "10001001";
        wait for 20 ns;
        input <= "10001010";
        wait for 20 ns;
        input <= "10001100";
        wait for 20 ns;
        input <= "10011000";
        wait for 20 ns;
        input <= "10101000";
        wait for 20 ns;
        input <= "10001100";
        wait for 20 ns;
        input <= "11001000";
        wait for 20 ns;
        input <= "10001110";
        wait for 20 ns;
        input <= "10001000";
        wait for 20 ns;
        
        

        -- Stop the clock and hence terminate the simulation
        
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.


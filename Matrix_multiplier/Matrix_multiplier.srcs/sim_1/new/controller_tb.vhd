-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 6.2.2024 18:13:09 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_Controller is
end tb_Controller;

architecture tb of tb_Controller is

    component Controller
        port (clk        : in std_logic;
              reset      : in std_logic;
              input      : in std_logic_vector (7 downto 0);
              load       : in std_logic;
              
              ready      : in std_logic;
              mul_en     : out std_logic;
              read_ram   : out std_logic;
              s_reg1_out : out std_logic_vector (63 downto 0);
              s_reg2_out : out std_logic_vector (63 downto 0);
              s_reg3_out : out std_logic_vector (63 downto 0);
              s_reg4_out : out std_logic_vector (63 downto 0));
    end component;

    signal clk        : std_logic;
    signal reset      : std_logic;
    signal input      : std_logic_vector (7 downto 0);
    signal mul_en     : std_logic;
    signal read_ram     : std_logic;
    signal load       : std_logic;
    signal ready      : std_logic;
    signal s_reg1_out : std_logic_vector (63 downto 0);
    signal s_reg2_out : std_logic_vector (63 downto 0);
    signal s_reg3_out : std_logic_vector (63 downto 0);
    signal s_reg4_out : std_logic_vector (63 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Controller
    port map (clk        => clk,
              reset      => reset,
              input      => input,
              read_ram   => read_ram,
              mul_en     => mul_en,
              load       => load,
              ready      => ready,
              s_reg1_out => s_reg1_out,
              s_reg2_out => s_reg2_out,
              s_reg3_out => s_reg3_out,
              s_reg4_out => s_reg4_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2;

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        input <= (others => '0');
        load <= '0';
        ready <= '0';
        reset <= '1';
        wait for 10 ns;
        ready <= '1';
        -- Reset generation
        wait for 20 * TbPeriod;
        -- EDIT: Check that reset is really your reset signal
        
        wait for 10 ns;
        reset <= '0';
        --wait for 10 ns;
        
        -- EDIT Add stimuli here
        input <= "10001000";
        wait for 10 ns;
        -- EDIT Add stimuli here
        input <= "10001001";
        wait for 10 ns;
        input <= "10001010";
        wait for 10 ns;
        input <= "10001100";
        wait for 10 ns;
        input <= "10011000";
        wait for 10 ns;
        input <= "10101000";
        wait for 10 ns;
        input <= "10001100";
        wait for 10 ns;
        input <= "11001000";
        wait for 10 ns;
        input <= "10001110";
        wait for 10 ns;
        input <= "10001000";
        wait for 10 ns;
        
        load <= '1';

        -- Stop the clock and hence terminate the simulation
        
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

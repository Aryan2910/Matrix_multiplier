----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.02.2024 15:12:53
-- Design Name: 
-- Module Name: mul_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



library ieee;
use ieee.std_logic_1164.all;

entity mul_tb is
end mul_tb; 

architecture tb of mul_tb is

    component Multiplier_unit
        port (clk      : in std_logic;
              reset    : in std_logic;
              s_reg1   : in std_logic_vector (63 downto 0);
              s_reg2   : in std_logic_vector (63 downto 0);
              s_reg3   : in std_logic_vector (63 downto 0);
              s_reg4   : in std_logic_vector (63 downto 0);
              mul_en    : in std_logic;
              MU_out : out std_logic_vector (287 downto 0));
    end component;

    signal clk      : std_logic;
    signal reset    : std_logic;
    signal s_reg1   : std_logic_vector (63 downto 0);
    signal s_reg2   : std_logic_vector (63 downto 0);
    signal s_reg3   : std_logic_vector (63 downto 0);
    signal s_reg4   : std_logic_vector (63 downto 0);
    signal mul_en    : std_logic;
    signal MU_out : std_logic_vector (287 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Multiplier_unit
    port map (clk      => clk,
              reset    => reset,
              s_reg1   => s_reg1,
              s_reg2   => s_reg2,
              s_reg3   => s_reg3,
              s_reg4   => s_reg4,
              mul_en    => mul_en,
              MU_out => MU_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2;

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        reset <= '1';
        s_reg1 <= (others => '0');
        s_reg2 <= (others => '0');
        s_reg3 <= (others => '0');
        s_reg4 <= (others => '0');
        mul_en <= '0';

        -- EDIT Add stimuli here
        wait for 20 * TbPeriod;
        reset <= '0';
        s_reg1 <= "0110001100001100010010010110100001010010010001010101011101100011";
        s_reg2 <= "0011000100010001000010000000001001011101001001100001011100001010";
        s_reg3 <= "0001111101111000000111100000010101010010010111110010111101110110";
        s_reg4 <= "0011001101111001001011010001010100111001000110000100111101100011";
        mul_en <= '1';
        -- Stop the clock and hence terminate the simulation
        wait;
    end process;

end tb;

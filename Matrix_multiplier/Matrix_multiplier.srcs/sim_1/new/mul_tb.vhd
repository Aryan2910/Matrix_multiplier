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
              clear    : in std_logic;
              s_reg1   : in std_logic_vector (63 downto 0);
              s_reg2   : in std_logic_vector (63 downto 0);
              s_reg3   : in std_logic_vector (63 downto 0);
              s_reg4   : in std_logic_vector (63 downto 0);
              mu_en    : in std_logic;
              dataROM  : in std_logic_vector (13 downto 0);
              MU_1_out : out std_logic_vector (14 downto 0);
              MU_2_out : out std_logic_vector (14 downto 0);
              MU_3_out : out std_logic_vector (14 downto 0);
              MU_4_out : out std_logic_vector (14 downto 0));
    end component;

    signal clk      : std_logic;
    signal clear    : std_logic;
    signal s_reg1   : std_logic_vector (63 downto 0);
    signal s_reg2   : std_logic_vector (63 downto 0);
    signal s_reg3   : std_logic_vector (63 downto 0);
    signal s_reg4   : std_logic_vector (63 downto 0);
    signal mu_en    : std_logic;
    signal dataROM  : std_logic_vector (13 downto 0);
    signal MU_1_out : std_logic_vector (14 downto 0);
    signal MU_2_out : std_logic_vector (14 downto 0);
    signal MU_3_out : std_logic_vector (14 downto 0);
    signal MU_4_out : std_logic_vector (14 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Multiplier_unit
    port map (clk      => clk,
              clear    => clear,
              s_reg1   => s_reg1,
              s_reg2   => s_reg2,
              s_reg3   => s_reg3,
              s_reg4   => s_reg4,
              mu_en    => mu_en,
              dataROM  => dataROM,
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
        clear <= '1';
        s_reg1 <= (others => '0');
        s_reg2 <= (others => '0');
        s_reg3 <= (others => '0');
        s_reg4 <= (others => '0');
        mu_en <= '0';
        dataROM <= (others => '0');

        -- EDIT Add stimuli here
        wait for 20 * TbPeriod;
        clear <= '0';
        s_reg1 <= "0001000100010001000100010001000100010001000100010001000100011111";
        s_reg2 <= "0001000100010001000100010001000100010001000100010001000100011111";
        s_reg3 <= "0001000100010001000100010001000100010001000100010001000100010001";
        s_reg4 <= "0001000100010001000100010001000100010001000100010001000100010001";
        mu_en <= '1';
        dataRom <= "00010001000101";
        -- Stop the clock and hence terminate the simulation
        wait;
    end process;

end tb;

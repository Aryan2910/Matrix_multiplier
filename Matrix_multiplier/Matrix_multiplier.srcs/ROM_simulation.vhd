----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2024 01:22:59 PM
-- Design Name: 
-- Module Name: ROM_simulation - Behavioral
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

entity ROM_simulation is
end entity;

architecture Behavioral of ROM_simulation is
--Define signals 
signal clk: std_logic := '0';
signal address_input: std_logic_vector (3 downto 0);
signal dataRom_output: std_logic_vector (13 downto 0);   
--Clock period signal
constant clk_period : time := 10 ns;


component ROM is 
    port(
        clk : in std_logic;
        address_input : in std_logic_vector(3 downto 0);
        dataRom_output : out std_logic_vector (13 downto 0)
    );
 end component;   



begin
DUT_rom : ROM port map (
        clk => clk,
        address_input => address_input,
        dataRom_output => dataRom_output
);

     clk <= not clk after clk_period/2;
    address_input <=  "0000", -- 001
                    "0001" after 2*4*clk_period, -- 3
                    "0010" after 3*4*clk_period; -- 8
--                    "00101000" after 4*3*clk_period; -- 27
--                    "00000000" after 5*3*clk_period, -- 0
--                    "11111111" after 6*3*clk_period, -- 255
--                    "00000110" after 7*3*clk_period, -- 6
--                    "00001110" after 8*3*clk_period; -- 14
end Behavioral;

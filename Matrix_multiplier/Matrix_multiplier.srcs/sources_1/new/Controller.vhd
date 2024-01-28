----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.01.2024 15:43:33
-- Design Name: 
-- Module Name: Controller - Behavioral
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


entity Controller is
    Port ( 
           valid : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in std_logic;
           reset : in std_logic;
           
           );
           
end Controller;

architecture Behavioral of Controller is
    
begin


end Behavioral;

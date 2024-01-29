----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2024 11:53:48 AM
-- Design Name: 
-- Module Name: ROM - Behavioral
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
use ieee.std_logic_unsigned.all;

entity ROM is 

    port (  
            clk           : in std_logic;
            address_input : in std_logic_vector(3 downto 0);
            dataRom_output : out std_logic_vector(13 downto 0)
         );

end ROM;

architecture behavioral of ROM is
    signal rom_output,rom_output_next : std_logic_vector(13 downto 0);

begin
    dataRom_output <= rom_output;
    
    reg:process(clk)
    begin
    if rising_edge(clk) then
        rom_output <= rom_output_next;
    end if;
    
    end process;

    read_rom: process(address_input,clk)
	   
        begin
        case address_input is
            when "0000" => rom_output_next <= "00000110010110";
            when "0001" => rom_output_next <= "00010110000001";
            when "0010" => rom_output_next <= "00010000000011";
            when "0011" => rom_output_next <= "00000010000010";
            when "0100" => rom_output_next <= "00010000001111";
            when "0101" => rom_output_next <= "00000100000100";
            when "0110" => rom_output_next <= "00011000000110";
            when "0111" => rom_output_next <= "00000010000010";
            when "1000" => rom_output_next <= "00100100101000";
            when "1001" => rom_output_next <="00000110000010";
            when "1010" => rom_output_next <="00100000001001";
            when "1011" => rom_output_next <="00000010000010";
            when "1100" => rom_output_next <="00000010001010";
            when "1101" => rom_output_next <="00001000000000";
            when "1110" => rom_output_next <="00000100001100";
            when "1111" => rom_output_next <="00000010000010";
            when others => rom_output_next <= (others => '0');
            end case;
        end process;

end behavioral;

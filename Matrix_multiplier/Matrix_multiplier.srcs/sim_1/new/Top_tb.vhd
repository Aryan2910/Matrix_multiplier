----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/12/2024 11:42:38 AM
-- Design Name: 
-- Module Name: Top_tb - Behavioral
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
use IEEE.std_logic_textio.ALL;
use ieee.std_logic_arith.all;
use ieee. numeric_std.all;
use ieee.std_logic_unsigned.all;
use STD.textio.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_tb is

end Top_tb;

architecture Behavioral of Top_tb is

--signal
file input_file : text;
constant period : time := 10ns;
signal clk : std_logic := '0';
signal reset : std_logic := '1';
signal input : std_logic_vector (7 downto 0) := "00000000";
signal ready : std_logic := '0';
signal RAM_out : std_logic_vector (8 downto 0);
signal ready_to_start : std_logic;

--Component
    component TOP is
     port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ready : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (7 downto 0);
           RAM_out : out STD_LOGIC_VECTOR (8 downto 0);
           ready_to_start : out STD_LOGIC);
           
           end component;
begin
    clk <= not(clk) after period*0.5;

    DUT : TOP port map (
        clk => clk,
        reset => reset,
        input => input,
        ready => ready,
        RAM_out => RAM_out,
        ready_to_start => ready_to_start   
    );
    process
--read_input : process    
--                variable v_ILINE : line;
--                variable v_SPACE : character;
--                variable variable_input : std_logic_vector (7 downto 0);
--                variable count : integer;    
    begin
--        count := 0;
        
        reset <= '1';
        wait for 2*period;
        reset <= '0';
        ready <= '1';    
        wait for period;
        ready <= '0'; 
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
        wait; 
        
--        file_open(input_file, "/h/dk/f/ar4013si-s/ICP_VP1/Matrix_nmultiplier_work/Matrix_multiplier/Stimuli files/input_stimuli.txt", READ_MODE);    
--        while not endfile(input_file) loop
--            count := count + 1;
--            readline (input_file, v_ILINE);
--            read (v_ILINE, variable_input);
--            input <= variable_input;
--            wait for period;
--            if ((count mod 32)= 0 and count/32 /=1) then
--            input <= (others => '0');
--            ready <= '1';
--            end if;
            
--            end loop;
        
--        file_close (input_file);
            
    end process;
end Behavioral;

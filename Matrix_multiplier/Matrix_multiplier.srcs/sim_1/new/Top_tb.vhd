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
file output_file : text;
constant period : time := 10ns;
signal clk : std_logic := '0';
signal reset : std_logic := '1';
signal input : std_logic_vector (7 downto 0) := "00000000";
signal ready : std_logic := '0';
signal RAM_out : std_logic_vector (8 downto 0);
signal ready_to_start : std_logic;
signal fini: std_logic;
signal write_done : std_logic;
signal count, count_next : std_logic_vector (5 downto 0);
--states
type state_type is (state_idle, state_read, state_wait, state_write);
signal state_reg, state_next : state_type;
--Component
    component TOP is
     port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ready : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (7 downto 0);
           RAM_out : out STD_LOGIC_VECTOR (8 downto 0);
           write_done : inout std_logic;
           ready_to_start : inout STD_LOGIC;
           fini : inout STD_LOGIC
           );
           
           end component;
begin
    clk <= not(clk) after period*0.5;
    reset <= '0'after period * 10;

    
    DUT : TOP port map (
        clk => clk,
        reset => reset,
        input => input,
        ready => ready,
        RAM_out => RAM_out,
        ready_to_start => ready_to_start,
        write_done  => write_done,
        fini => fini
           
    );
    
    sequential : process (clk, reset) begin
        if (rising_edge (clk) ) then
            if (reset = '1') then
                count <= (others => '0');
                state_reg <= state_idle;
            else
                count <= count_next;
                state_reg <= state_next;
            end if;
        end if;
    end process;
    


    
    Behavioral : process (count, state_reg, ready_to_start, fini, write_done)
    
                variable v_ILINE : line;  --Input line
                variable v_OLINE : line;  --Output line
                variable variable_input : std_logic_vector (7 downto 0);
                variable variable_output : std_logic_vector (17 downto 0);
                file input_file : text open read_mode is "/h/dk/f/ar4013si-s/ICP_VP1/Matrix_nmultiplier_work/Matrix_multiplier/Stimuli files/input_stimuli.txt"; 
                file output_file : text open write_mode is "/h/dk/f/ar4013si-s/ICP_VP1/Matrix_nmultiplier_work/Matrix_multiplier/Stimuli files/output_stimuli_tb.txt"; 
                variable flag : boolean; 
    begin

           
        count_next <= count;
        state_next <= state_reg;
        flag := False;
        
        
            case state_reg is 
                
                when state_idle =>
                    state_next <= state_read;
                    ready <= '1';
                    
                when state_read =>
                if (not endfile (input_file )) then
                    if count = "100000" then
                        state_next <= state_wait;
                        count_next <= "000000";
                    else
                        ready <= '0';
                        readline (input_file, v_ILINE);
                        read (v_ILINE, variable_input);
                        input <= variable_input;
                        count_next <= count + 1;
                        state_next <= state_read;
                    end if;
                else 
                    state_next <= state_wait;
                end if;
                
                
                when state_wait =>
                
                if ready_to_start  = '1' then 
                    state_next <= state_write;
               elsif write_done = '1' then 
                    state_next <= state_idle;
                --else
                   -- state_next <= state_wait;
                    end if;
                    
                    
                when state_write => 
                  
                    if fini = '1' then
                    state_next <= state_idle;
                    else
                    write (v_OLINE, RAM_out);
                        if flag = FALSE  then
                            flag := TRUE;
                            else
                            flag := FALSE;
                            writeline (output_file, v_OLINE);
                        end if;    
                    end if;
                end case;

   
       
    
            
    end process;
end Behavioral;

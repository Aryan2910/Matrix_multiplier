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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Controller is
    Port ( 
           clk : in std_logic;
           reset : in std_logic;
           input : in STD_LOGIC_VECTOR (7 downto 0);
           load : in std_logic;
           ready : in std_logic;
           write_done : in std_logic;            --From RAM
           
           
           -- output logoc for trigger 
           
           mul_en : out std_logic; --output that triggers multiplier unit
           read_ram : out std_logic; -- output that triggers the RAM
           
           -- outputs
           s_reg1_out : out std_logic_vector (63 downto 0);
           s_reg2_out : out std_logic_vector (63 downto 0);
           s_reg3_out : out std_logic_vector (63 downto 0);
           s_reg4_out : out std_logic_vector (63 downto 0);
           read_tb : out std_logic            --TO TOP
           );
           
end Controller;

architecture Behavioral of Controller is
--Signals defined   
 
signal shift_count : std_logic_vector(2 downto 0);    
signal shift_count_next : std_logic_vector(2 downto 0);    
signal count : std_logic_vector(5 downto 0);    
signal count_next : std_logic_vector(5 downto 0);
signal s_reg1 : std_logic_vector (63 downto 0);
signal s_reg1_next : std_logic_vector (63 downto 0);
signal s_reg2 : std_logic_vector (63 downto 0);
signal s_reg2_next : std_logic_vector (63 downto 0);
signal s_reg3 : std_logic_vector (63 downto 0);
signal s_reg3_next : std_logic_vector (63 downto 0);
signal s_reg4 : std_logic_vector (63 downto 0);    
signal s_reg4_next : std_logic_vector (63 downto 0); 
    
    
--states
type state_type is (state_idle, state_shifting, state_multiply, state_load);
signal state_reg, state_next : state_type;


begin

Sequential: process(clk, reset)
        begin
            if (rising_edge(clk)) then
                if (reset = '1') then
                --All registers to zero
                    shift_count <= (others => '0');
                    count <= (others => '0');
                    s_reg1 <= (others => '0');
                    s_reg2 <= (others => '0');
                    s_reg3 <= (others => '0');
                    s_reg4 <= (others => '0');
                    state_reg <= state_idle;
                    
               else

                    shift_count <= shift_count_next;
                    count <= count_next;
                    s_reg1 <= s_reg1_next;
                    s_reg2 <= s_reg2_next;
                    s_reg3 <= s_reg3_next;
                    s_reg4 <= s_reg4_next;
                    state_reg <= state_next;
                end if;
            end if;
end process;


  
Shifting: process(shift_count,state_reg,s_reg1,s_reg2,s_reg3,s_reg4,count, load, write_done, input, ready)
begin
            --stating initial conditions(to aavoid latches)
            state_next <= state_reg;
            s_reg1_next <= s_reg1;   
            s_reg2_next <= s_reg2;   
            s_reg3_next <= s_reg3;   
            s_reg4_next <= s_reg4;
            shift_count_next <= shift_count;
            count_next <= count;
            mul_en <= '0';
            read_ram <= '0';
            read_tb <= '0';
            
            --FSM
            case state_reg is 
                --Idle
                when state_idle =>
                  if ready = '1' then
                  state_next <= state_shifting;
                  shift_count_next <= "000";
                  else
                  state_next <= state_idle;
                  end if;   
                
                --Shfiting
                when state_shifting =>
                if count = "100000" then
                  count_next <= "000000";                                    --putting count to 0 //Added new
                  state_next <= state_multiply;
                  mul_en <= '1';
                else
                    if shift_count = "000" then
                        count_next <= count + 1;
                        shift_count_next <= shift_count + 1;
                        s_reg1_next <= s_reg1(55 downto 0) & input;    
                     elsif shift_count = "001" then
                        count_next <= count + 1;
                        shift_count_next <= shift_count + 1;
                        s_reg2_next <= s_reg2(55 downto 0) & input;
                     elsif shift_count = "010" then
                        count_next <= count + 1;
                        shift_count_next <= shift_count + 1;
                        s_reg3_next <= s_reg3(55 downto 0) & input;
                     elsif shift_count = "011" then
                        count_next <= count + 1;
                        shift_count_next <= "000";
                        s_reg4_next <= s_reg4(55 downto 0) & input;
                     else
                        count_next <= count;
                        shift_count_next <= shift_count;
                        end if;
                        state_next <= state_shifting;
                  end if;
                       
             when state_multiply =>
                
                  
                  state_next <= state_multiply;
                  mul_en <= '0'; 

                if load = '1' then 
                    state_next <= state_load;
                    read_ram <= '1';            
                end if;
             when state_load => 
                if write_done  = '1' then
                    state_next <= state_idle;                   
                    read_tb <= '1';
                    read_ram <= '0';               
                else
                    read_ram <= '0';                       
                  state_next <= state_load;
                end if;          
            end case;     
end process;
       s_reg1_out <= s_reg1;   
       s_reg2_out <= s_reg2;   
       s_reg3_out <= s_reg3;   
       s_reg4_out <= s_reg4;

            
end Behavioral;

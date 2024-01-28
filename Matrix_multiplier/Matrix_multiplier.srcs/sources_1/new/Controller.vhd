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
           valid : in std_logic;
           input : in STD_LOGIC_VECTOR (7 downto 0);
           data_rom : in std_logic_vector (13 downto 0);
           MU1 : in std_logic_vector (14 downto 0);
           MU2 : in std_logic_vector (14 downto 0);
           MU3 : in std_logic_vector (14 downto 0);
           MU4 : in std_logic_vector (14 downto 0);
           
           load : out std_logic; --output that triggers ram
           MU1_out : out std_logic_vector (14 downto 0);
           MU2_out : out std_logic_vector (14 downto 0);
           MU3_out : out std_logic_vector (14 downto 0);
           MU4out : out std_logic_vector (14 downto 0)

           
           
           );
           
end Controller;

architecture Behavioral of Controller is
--Signals defined
signal mat_coeff_1 : std_logic_vector(6 downto 0);    
signal mat_coeff_1_next : std_logic_vector(6 downto 0);    
signal mat_coeff_2 : std_logic_vector(6 downto 0);    
signal mat_coeff_2_next : std_logic_vector(6 downto 0);    
signal count_mul : std_logic_vector(2 downto 0);    
signal count_mul_next : std_logic_vector(2 downto 0);    
signal count_col : std_logic_vector(2 downto 0);    
signal count_col_next : std_logic_vector(2 downto 0);    
signal shift_count : std_logic_vector(1 downto 0);    
signal shift_count_next : std_logic_vector(1 downto 0);    
signal count : std_logic_vector(4 downto 0);    
signal count_next : std_logic_vector(4 downto 0);
signal s_reg1 : std_logic_vector (63 downto 0);
signal s_reg1_next : std_logic_vector (63 downto 0);
signal s_reg2 : std_logic_vector (63 downto 0);
signal s_reg2_next : std_logic_vector (63 downto 0);
signal s_reg3 : std_logic_vector (63 downto 0);
signal s_reg3_next : std_logic_vector (63 downto 0);
signal s_reg4 : std_logic_vector (63 downto 0);    
signal s_reg4_next : std_logic_vector (63 downto 0);    
--states
type state_type is (s_reg_1_state, s_reg_2_state, s_reg_3_state, s_reg_4_state);
signal state_reg, state_next : state_type;

begin

Sequential: process(clk, reset)
        begin
            if (rising_edge(clk)) then
                if (reset = '1') then
                --All registers to zero
                    mat_coeff_1 <= (others => '0');
                    mat_coeff_2 <= (others => '0');
                    count_mul <= (others => '0');
                    count_col <= (others => '0');
                    shift_count <= (others => '0');
                    count <= (others => '0');
                    state_reg <= s_reg_1_state;
               else
                    mat_coeff_1 <= mat_coeff_1_next;
                    mat_coeff_2 <= mat_coeff_2_next;
                    count_mul <= count_mul_next;
                    count_col <= count_col_next;
                    shift_count <= shift_count_next;
                    count <= count_next;
                    state_reg <= state_next;
                end if;
            end if;
end process;
    
Shifting: process(shift_count,state_reg,s_reg1,s_reg2,s_reg3,s_reg4)
begin
            --stating initial conditions(to aavoid latches)
            state_next <= state_reg;
            s_reg1_next <= s_reg1;   
            s_reg2_next <= s_reg2;   
            s_reg3_next <= s_reg3;   
            s_reg4_next <= s_reg4;
            shift_count_next <= shift_count;
            --Shifting FSM
            case state_reg is --should we create seperate component for shifting?
                when s_reg_1_state =>
                    if shift_count = "00" then
                        shift_count_next <= shift_count + 1;
                       -- s_reg1 <= shift_left(input);
                        state_next <= s_reg_2_state;
                     else
                        shift_count_next <= shift_count;
                        state_next <= s_reg_1_state;   
                    end if;
                end case;     
end process;  
            
end Behavioral;

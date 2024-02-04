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
           data_rom : in std_logic_vector (13 downto 0);
           MU1 : in std_logic_vector (14 downto 0);
           MU2 : in std_logic_vector (14 downto 0);
           MU3 : in std_logic_vector (14 downto 0);
           MU4 : in std_logic_vector (14 downto 0);
           
           mul_en : out std_logic; --output that triggers multiplier unit
           load : out std_logic; --output that triggers ram
           s_reg1_out : out std_logic_vector (63 downto 0);
           s_reg2_out : out std_logic_vector (63 downto 0);
           s_reg3_out : out std_logic_vector (63 downto 0);
           s_reg4_out : out std_logic_vector (63 downto 0);
           MU1_out : out std_logic_vector (14 downto 0);
           MU2_out : out std_logic_vector (14 downto 0);
           MU3_out : out std_logic_vector (14 downto 0);
           MU4_out : out std_logic_vector (14 downto 0)

           
           
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
signal address_input : std_logic_vector(3 downto 0);
signal dataRom_output : std_logic_vector (13 downto 0);
--one bit signal
signal mu_en : std_logic;
signal ready : std_logic;      
signal clear : std_logic;      
signal valid : std_logic;      
--states
type state_type is (state_idle, state_shifting, state_multiply, state_load);
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
                    state_reg <= state_idle;
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


  
Shifting: process(shift_count,state_reg,s_reg1,s_reg2,s_reg3,s_reg4,count)
begin
            --stating initial conditions(to aavoid latches)
            state_next <= state_reg;
            s_reg1_next <= s_reg1;   
            s_reg2_next <= s_reg2;   
            s_reg3_next <= s_reg3;   
            s_reg4_next <= s_reg4;
            shift_count_next <= shift_count;
            count_next <= count;
            
            
            
            --FSM
            case state_reg is 
                when state_idle =>
                ready <= '1';
                mat_coeff_1 <= dataRom_output(6 downto 0); 
                mat_coeff_2 <= dataRom_output(13 downto 7); 
                count_mul <= (others => '0');
                count_col <= (others => '0');
                valid <= '1';
                --Should we add MU1-4??
                    if valid = '1' then 
                    state_next <= state_shifting;
                    else
                    --ram???
                    end if;
                when state_shifting =>
                    if shift_count = "00" then
                        count_next <= count + 1;
                        s_reg1_next <= s_reg1(55 downto 0) & input;    
                     elsif shift_count = "01" then
                        count_next <= count + 1;
                        s_reg2_next <= s_reg2(55 downto 0) & input;
                     elsif shift_count = "10" then
                        count_next <= count + 1;
                        s_reg3_next <= s_reg3(55 downto 0) & input;
                     elsif shift_count = "11" then
                        count_next <= count + 1;
                        s_reg4_next <= s_reg4(55 downto 0) & input;
                     else 
                        if count = "100000" then
                        state_next <= state_multiply;
                        
                        else
                        shift_count_next <= shift_count + 1;
                        end if;
                  end if;
                       
             when state_multiply =>
                        mu_en <= '1';
                        
             when state_load => 
                        --Insert how ram can be initiated      
            end case;     
end process;

  
            
end Behavioral;

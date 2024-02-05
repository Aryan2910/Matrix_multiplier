----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2024 12:50:13 PM
-- Design Name: 
-- Module Name: RAM_controller - Behavioral
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

entity RAM_controller is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load : in STD_LOGIC;
           read_ram : in std_logic;
           mul_en : in std_logic;
           MU_1_in : in STD_LOGIC_VECTOR (14 downto 0);
           MU_2_in : in STD_LOGIC_VECTOR (14 downto 0);
           MU_3_in : in STD_LOGIC_VECTOR (14 downto 0);
           MU_4_in : in STD_LOGIC_VECTOR (14 downto 0);
          
           ready_to_start : out std_logic);
           
end RAM_controller;

architecture Behavioral of RAM_controller is
--states
type state_type is (s_idle, s__write_1, s_write2, s_read);
signal state_reg, state_next : state_type;
--signal

signal data_in, data_out : std_logic_vector (31 downto 0);
signal result : std_logic_vector (31 downto 0);
signal address_count, address_count_next : std_logic_vector (7 downto 0);
--One bit signals
signal LOW : std_logic;
signal write_enable : std_logic;
signal RY : std_logic;
--Component Definition

component sram_wrapper
    port(        
        clk: in std_logic;
        cs_n: in std_logic;  -- Active Low
        we_n: in std_logic;  --Active Low
        address: in std_logic_vector(7 downto 0);
        ry: out std_logic;
        write_data: in std_logic_vector(31 downto 0);
        read_data: out std_logic_vector(31 downto 0)
        );
        
 
end component;
begin
wrapper : sram_wrapper port map(
        clk => clk,
        cs_n =>  LOW,
        we_n => write_enable,
        address => address_count,
        ry => RY,
        write_data => data_in,
        read_data => data_out        
);

sequential: process (clk, rst) begin
            if (rising_edge (clk)) then 
              if rst = '1' then 
                data_in <= (others => '0');
                data_out <= (others => '0');
                address_count <= (others => '0');
                LOW <= (others => '0');
                write_enable <= (others => '0');
                RY <= (others => '0');  --???
                state_reg <= s_idle;
             end if;
            else 
                address_count <= address_count_next;
                write_enable <= '1';
                state_reg <= state_next;
            end if;
    
end process;
    
behavior: process (state_reg, state_next, rst) begin
--Default 
address_count_next <= address_count;
           
        case state_reg is 
            
            when s_idle =>
                   if rst = '1' then
                    write_en <= '0';
                    data_in <= (others => '0');
                    address_count_next <= address_count + 1;
                    address <= address_count_next;
                    state_next <= s_idle;
                   else
                    write_en <= '1';
                    state_next <= s__write_1;
                   end if; 
            
            when s_write_1 =>
                    data_in <= MU_1_in & MU_2_in;
                    address_count_next <= address_count + 1;
                    result <= MU_3_in & MU_4_in;
                    state_next <= s_write2;
            when s_write_2 =>
                    data_in <= result;
                    address_count_next <= address_count + 1;
                    state_next <= s_read;
            when s_read =>
            
            end case;
end process;    


end Behavioral;

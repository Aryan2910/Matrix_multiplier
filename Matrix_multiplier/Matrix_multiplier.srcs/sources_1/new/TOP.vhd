----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.02.2024 22:36:33
-- Design Name: 
-- Module Name: TOP - Behavioral
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

entity TOP is
        port (
        
        clk : in std_logic;
        reset : in std_logic;
        ready : in std_logic;
        input : in std_logic_vector (7 downto 0);
        RAM_out : out std_logic_vector (8 downto 0);
        write_done : inout std_logic;
        ready_to_start : inout std_logic;
        fini : inout std_logic
        );
        
end TOP;

architecture Behavioral of TOP is


--Controller
component Controller
    Port ( 
           clk : in std_logic;
           reset : in std_logic;
           input : in STD_LOGIC_VECTOR (7 downto 0);
           load : in std_logic;
           ready : in std_logic;
           
           -- output logoc for trigger 
           
           write_done : in std_logic; --Input that comes from ram
           mul_en : out std_logic; --output that triggers multiplier unit
           read_ram : out std_logic; -- output that triggers the RAM
           
           -- outputs
           s_reg1_out : out std_logic_vector (63 downto 0) := (others => '0');
           s_reg2_out : out std_logic_vector (63 downto 0) := (others => '0');
           s_reg3_out : out std_logic_vector (63 downto 0) := (others => '0');
           s_reg4_out : out std_logic_vector (63 downto 0) := (others => '0')
           );
           
end component;

--Multiply Unit
component Multiplier_unit
    port (
           clk : in std_logic;
           reset : in std_logic;
           --Register inputs
           s_reg1 : in std_logic_vector (63 downto 0);
           s_reg2 : in std_logic_vector (63 downto 0);
           s_reg3 : in std_logic_vector (63 downto 0);
           s_reg4: in std_logic_vector (63 downto 0);
           mul_en : in std_logic;
           
           --outputs
           MU_out : out std_logic_vector (287 downto 0);
           load : out std_logic 
        
    );
    end component;

--Ram Controller 
component RAM_controller
    port (
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           read_ram : in std_logic;
           MU_in : in STD_LOGIC_VECTOR (287 downto 0);
           
           --Outputs
           RAM_out : out STD_LOGIC_VECTOR (8 downto 0);
           write_done: out std_logic;
           ready_to_start : out std_logic;
           fini : out std_logic
           
        
    );
    end component;    
-- signals used to link all the modules
signal s_load : std_logic;
signal s_write_done : std_logic;
signal s_mul_en : std_logic;
signal s_read_ram : std_logic;
signal s_reg1_out :  std_logic_vector (63 downto 0);
signal s_reg2_out :  std_logic_vector (63 downto 0);
signal s_reg3_out :  std_logic_vector (63 downto 0);
signal s_reg4_out :  std_logic_vector (63 downto 0);
signal s_MUL_out :  std_logic_vector (287 downto 0);

--signal that come from one module and go in the other module
begin
--Port maps
    controller_use : Controller 
    port map (
           clk => clk,
           reset => reset,
           input => input,
           load => s_load,
           ready => ready,
           write_done => write_done,
           -- output logic for trigger 
           
           mul_en => s_mul_en, --output that triggers multiplier unit
           read_ram => s_read_ram, -- output that triggers the RAM
           
           -- outputs
           s_reg1_out => s_reg1_out,
           s_reg2_out => s_reg2_out,
           s_reg3_out => s_reg3_out,
           s_reg4_out => s_reg4_out

    
    );
    
    multiply_unit_use : Multiplier_unit
    port map (            
           clk => clk,
           reset => reset,
           --Register inputs
           s_reg1 => s_reg1_out,
           s_reg2 => s_reg2_out,
           s_reg3 => s_reg3_out,
           s_reg4 => s_reg4_out,
           mul_en => s_mul_en,
           
           --outputs
           MU_out => s_MUL_out,
           load => s_load
           
    );
    
    Ram_controller_use : RAM_controller
    port map (            
           clk => clk,
           reset => reset,
           read_ram => s_read_ram,
           MU_in => s_MUL_out,
           write_done => write_done,
           --Outputs
           RAM_out => RAM_out,
           ready_to_start => ready_to_start,
           fini => fini
           
    );
end Behavioral;

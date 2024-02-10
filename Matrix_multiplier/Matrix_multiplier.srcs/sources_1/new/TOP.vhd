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
        MU_1_out : out std_logic_vector (15 downto 0);
        MU_2_out : out std_logic_vector (15 downto 0);
        MU_3_out : out std_logic_vector (15 downto 0);
        MU_4_out : out std_logic_vector (15 downto 0)
        
        );
        
end TOP;

architecture Behavioral of TOP is

--ROM
component ROM
   port(
        clk : in std_logic;
        address_input : in std_logic_vector (3 downto 0);
        dataRom_output : out std_logic_vector (13 downto 0)
        );
end component;
--Controller
component Controller
    Port ( 
           clk : in std_logic;
           reset : in std_logic;
           input : in STD_LOGIC_VECTOR (7 downto 0);
           data_rom : in std_logic_vector (13 downto 0);
           valid : in std_logic;
--           MU1 : in std_logic_vector (14 downto 0);
--           MU2 : in std_logic_vector (14 downto 0);
--           MU3 : in std_logic_vector (14 downto 0);
--           MU4 : in std_logic_vector (14 downto 0);
           
           mul_en : out std_logic; --output that triggers multiplier unit
           --load : out std_logic; --output that triggers ram -- already triggered in MU ????
           s_reg1_out : out std_logic_vector (63 downto 0);
           s_reg2_out : out std_logic_vector (63 downto 0);
           s_reg3_out : out std_logic_vector (63 downto 0);
           s_reg4_out : out std_logic_vector (63 downto 0)
--           MU1_out : out std_logic_vector (14 downto 0);
--           MU2_out : out std_logic_vector (14 downto 0);
--           MU3_out : out std_logic_vector (14 downto 0);
--           MU4_out : out std_logic_vector (14 downto 0)
           );
           
end component;

--Multiply signal
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
           dataROM : in std_logic_vector (13 downto 0);
           --outputs
           MU_1_out : out std_logic_vector (15 downto 0);
           MU_2_out : out std_logic_vector (15 downto 0);
           MU_3_out : out std_logic_vector (15 downto 0);
           MU_4_out : out std_logic_vector (15 downto 0);
           address_out : out std_logic_vector (3 downto 0);
           load : out std_logic
           --valid : out std_logic
        
    );
    end component;
    
-- signals used to link all the modules
--signal that come from one module and go in the other module
signal dataRom_output : std_logic_vector(13 downto 0);
signal address_out : std_logic_vector (3 downto 0);
signal load : std_logic;
signal clear : std_logic;
signal s_reg1   : std_logic_vector (63 downto 0);
signal s_reg2   : std_logic_vector (63 downto 0);
signal s_reg3   : std_logic_vector (63 downto 0);
signal s_reg4   : std_logic_vector (63 downto 0);
signal s_reg1_out   : std_logic_vector (63 downto 0);
signal s_reg2_out   : std_logic_vector (63 downto 0);
signal s_reg3_out   : std_logic_vector (63 downto 0);
signal s_reg4_out   : std_logic_vector (63 downto 0);
signal mul_en : std_logic;
signal valid : std_logic;
--signal MU_1_out : std_logic_vector (14 downto 0);
--signal MU_2_out : std_logic_vector (14 downto 0);
--signal MU_3_out : std_logic_vector (14 downto 0);
--signal MU_4_out : std_logic_vector (14 downto 0);

begin
--Port maps
    rom_use : ROM
    port map ( clk => clk,
               address_input => address_out,
               dataRom_output => dataRom_output
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
           mul_en => mul_en,
           dataROM => dataRom_output,
           --outputs
           MU_1_out => MU_1_out,
           MU_2_out => MU_2_out,
           MU_3_out => MU_3_out,
           MU_4_out => MU_4_out,
           address_out => address_out,
           load => load
           --valid => valid
           
    );
    
    controller_use : Controller 
    port map (
           clk  => clk,
           reset => reset,
           input => input,
           data_rom => dataRom_output,
--           MU1 : in std_logic_vector (14 downto 0);
--           MU2 : in std_logic_vector (14 downto 0);
--           MU3 : in std_logic_vector (14 downto 0);
--           MU4 : in std_logic_vector (14 downto 0);
           
           mul_en => mul_en,--output that triggers multiplier unit
           --load => load,--output that triggers ram -- already triggered in MU ????
           valid => valid,
           s_reg1_out => s_reg1_out,
           s_reg2_out => s_reg2_out,
           s_reg3_out => s_reg3_out,
           s_reg4_out => s_reg4_out
--           MU1_out => MU_1_out,
--           MU2_out => MU_2_out,
--           MU3_out => MU_3_out,
--           MU4_out => MU_4_out
    
    );
end Behavioral;

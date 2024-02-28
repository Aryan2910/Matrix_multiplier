----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2024 01:27:25 PM
-- Design Name: 
-- Module Name: TOP_with_pads - Behavioral
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

entity TOP_with_pads is 
    port(  
    
        clk_in : in std_logic;
        reset_in : in std_logic;
        ready_in : in std_logic;
        input_in : in std_logic_vector (7 downto 0);
        RAM_out_out : out std_logic_vector (8 downto 0);
        write_done_out : out std_logic;
        fini_out : out std_logic
        );
end TOP_with_pads;


architecture TOP_with_pads_arch of TOP_with_pads is

-- SIGNAL DEFINITIONS
    signal clk_sig : std_logic;
    signal reset_sig : std_logic;
    signal input_sig : std_logic_vector(7 downto 0);
    signal ready_sig : std_logic;
    signal write_done_sig : std_logic;
    signal fini_sig : std_logic;
    signal RAM_out_sig : std_logic_vector(8 downto 0);


-- COMPONENT DEFINITION

component TOP is 

    port (          
    
        clk : in std_logic;
        reset : in std_logic;
        ready : in std_logic;
        input : in std_logic_vector (7 downto 0);
        RAM_out : out std_logic_vector (8 downto 0);
        write_done : out std_logic;
        fini : out std_logic
        
         );

end component;

component CPAD_S_74x50u_IN is 
    port (
        COREIO : out std_logic;
        PADIO : in std_logic
        );
end component; 

component CPAD_S_74x50u_OUT is 
    port (
        COREIO : in std_logic;
        PADIO : out std_logic
        );
end component; 

begin 

clk_pad : CPAD_S_74x50u_IN 
    port map(
        COREIO => clk_sig,
        PADIO => clk_in
        );

rst_pad : CPAD_S_74x50u_IN 
    port map(
        COREIO => reset_sig,
        PADIO => reset_in
        );

ready_pad : CPAD_S_74x50u_IN 
    port map(
        COREIO => ready_sig,
        PADIO => ready_in
        );

InPads : for i in 0 to 7 generate
InPads : CPAD_S_74x50u_IN
  port map( 
        COREIO => input_sig(i),
        PADIO => input_in(i)
        );
end generate InPads;

fini_pad : CPAD_S_74x50u_OUT 
    port map(
        COREIO => fini_sig,
        PADIO => fini_out
        );

write_done_pad : CPAD_S_74x50u_OUT 
    port map(
        COREIO => write_done_sig,
        PADIO => write_done_out
        );

RAM_OutPads : for i in 0 to 8 generate
RAM_OutPads : CPAD_S_74x50u_OUT
  port map( 
        COREIO => RAM_out_sig(i),
        PADIO => RAM_out_out(i)
        );
end generate RAM_OutPads;

TOP_module : TOP

    port map(              
            clk     	=> clk_sig,
            reset    	=> reset_sig,
            input   	=> input_sig,
            ready 	=> ready_sig,
            write_done 	=> write_done_sig,
            fini  	=> fini_sig,
            RAM_out 	=> RAM_out_sig
         );



end TOP_with_pads_arch;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
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
           read_ram : in std_logic;
           MU_in : in STD_LOGIC_VECTOR (17 downto 0);
           RAM_out : out STD_LOGIC_VECTOR (31 downto 0);
           ready_to_start : out std_logic);
           
end RAM_controller;

architecture Behavioral of RAM_controller is
--states
type state_type is (s_idle, s_write, s_read);
signal state_reg, state_next : state_type;
--signal
signal data_in, data_out : std_logic_vector (31 downto 0);
signal address_write_count, address_write_count_next : std_logic_vector (7 downto 0);
signal address_read_count, address_read_count_next : std_logic_vector (7 downto 0);
signal address : std_logic_vector (7 downto 0);
signal read_count, read_count_next : std_logic_vector (1 downto 0);
signal mu : std_logic_vector (31 downto 0);
signal mu_next : std_logic_vector (31 downto 0);
--One bit signals
signal write_enable : std_logic;
signal RY : std_logic;
--Constant
constant LOW: std_logic := '0';

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
        address => address,
        ry => RY,
        write_data => data_in,
        read_data => data_out        
);

sequential: process (clk, rst) begin
            if (rising_edge (clk)) then 
              if rst = '1' then 
                address_write_count <= (others => '0');
                address_read_count <= (others => '0');
                read_count <= "00";
                RY <= '0';  --???
                state_reg <= s_idle;
                mu <= (others => '0');
                
            else 
                address_write_count <= address_write_count_next;
                address_read_count <= address_read_count_next;
                read_count <= read_count_next;
                state_reg <= state_next;
                mu <= mu_next;
                
            end if;
        end if;
end process;
    
behavior: process (state_reg, state_next, write_enable, read_count, read_ram, address_read_count, address_write_count, RY) begin --, MU_1_in, MU_2_in, MU_3_in, MU_4_in
--Default 
address_write_count_next <= address_write_count;
address_read_count_next <= address_read_count;
read_count_next <= read_count;
write_enable <= '1';
state_next <= state_reg;
data_in <= (others => '0');
address  <= std_logic_vector (address_write_count);
--For output
mu_next <= mu;                     
ready_to_start <= '0';   

      if read_ram = '1' then  
      --CASE  
        case state_reg is 
            
            when s_idle =>
            
               if write_enable = '1' then
                data_in <= (others => '0');
                address_write_count_next <= address_write_count + 1;
                
                  if address_write_count = "00010000" then
                    address_write_count_next <= (others => '0');
                    state_next <= s_write;
                  else
                   state_next <= s_idle;
                   end if; 
                end if;
            when s_write =>
                    if address_write_count = "00010000" then 
                        state_next <= s_read;    
                        else
                        state_next <= s_write;
                        write_enable <= '0';                   --should we add wr_en = 0 in both the states?
                        data_in <= "00000000000000" & MU_in;
                        address_write_count_next <= address_write_count + 1;
                    end if;
                    
            when s_read =>
                    if read_count = "00" then
                        address  <= std_logic_vector (address_read_count);
                        state_next <= s_read;
                        read_count_next <= read_count + 1;
                    elsif read_count = "01" then 
                        address  <= std_logic_vector (address_read_count);
                        mu_next <= data_out;                       
                        read_count_next <= read_count + 1;  
                        state_next <= s_read;                                      
                    elsif read_count = "10" then    
                        address  <= std_logic_vector (address_read_count);
                        if address_read_count = "00010000" then  
                                read_count_next <= "00";
                                ready_to_start <= '1';
                                state_next <= s_write;
                            else
                                address_read_count_next <= address_read_count + 1;
                                read_count_next <= "00";
                                state_next <= s_read;
                        
                            end if;
                    end if;           
            end case;
          
     end if;
end process;    

--Taking outputs
RAM_out <= mu;



end Behavioral;

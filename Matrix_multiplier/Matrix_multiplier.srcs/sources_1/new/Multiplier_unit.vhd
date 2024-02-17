library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee. numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Multiplier_unit is
    Port ( 
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
           --valid : out std_logic
           );
end Multiplier_unit;

architecture Behavioral of Multiplier_unit is
--Component --ROM
component ROM
   port(
        clk : in std_logic;
        address_input : in std_logic_vector (3 downto 0);
        dataRom_output : out std_logic_vector (13 downto 0)
        );
end component;
--signals
signal mu1, mu1_next : std_logic_vector (17 downto 0);
signal mu2, mu2_next : std_logic_vector (17 downto 0);
signal mu3, mu3_next : std_logic_vector (17 downto 0);
signal mu4, mu4_next : std_logic_vector (17 downto 0);

signal sig_sreg1_next, sig_sreg2_next, sig_sreg3_next, sig_sreg4_next : std_logic_vector (63 downto 0);
signal sig_sreg1, sig_sreg2, sig_sreg3, sig_sreg4 : std_logic_vector (63 downto 0);
signal dataROM : std_logic_vector (13 downto 0);
signal s_MU_out, s_MU_out_next : std_logic_vector (287 downto 0);

--Count
signal count_mul, count_mul_next: std_logic_vector (3 downto 0);
signal count_coeff, count_coeff_next: std_logic_vector (1 downto 0);
signal count_col, count_col_next : std_logic_vector (2 downto 0);
signal coeff, coeff_next : std_logic_vector (6 downto 0);
signal address, next_address : std_logic_vector (3 downto 0);
signal address_out: std_logic_vector (3 downto 0);
--One bit signal
signal load_next : std_logic;

--state
type state_type is (state_load, select_coeff, clear_mu, multiply, state_shift, state_ram);
signal state_reg, state_next : state_type;
BEGIN
--Port map    
    rom_use : ROM
    port map ( clk => clk,
               address_input => address_out,
               dataRom_output => dataROM
    );
    
    
sequential: process (clk,reset) begin
    if (rising_edge (clk)) then
        if reset = '1' then
            mu1 <= (others => '0');
            mu2 <= (others => '0');
            mu3 <= (others => '0');
            mu4 <= (others => '0');           
            coeff <= (others => '0');
            load <= '0';
            count_mul <= (others => '0');
            count_coeff <= (others => '0');
            count_col <= (others => '0');
            state_reg <= state_load;
            address <= (others => '0');  
            sig_sreg1 <= (others => '0');
            sig_sreg2 <= (others => '0');
            sig_sreg3 <= (others => '0');
            sig_sreg4 <= (others => '0');
            s_MU_out <= (others => '0');
             
            else
            mu1 <= mu1_next;
            mu2 <= mu2_next;
            mu3 <= mu3_next;
            mu4 <= mu4_next;
            count_col <= count_col_next;
            count_mul <= count_mul_next;
            count_coeff <= count_coeff_next;
            coeff <= coeff_next;
            load <= load_next;              
            address <= next_address;
            state_reg <= state_next;
            sig_sreg1 <= sig_sreg1_next;
            sig_sreg2 <= sig_sreg2_next;
            sig_sreg3 <= sig_sreg3_next;
            sig_sreg4 <= sig_sreg4_next;
            s_MU_out <= s_MU_out_next;
        end if;    
    end if;
end process;

----taking input



combinational: process (mul_en,state_reg, state_next, count_mul, s_reg1, s_reg2, s_reg3, s_reg4, sig_sreg1, 
sig_sreg2, sig_sreg3, sig_sreg4,count_col, mu1, mu2, mu3, mu4, dataROM, coeff  ) 
begin
mu1_next <= mu1;
mu2_next <= mu2;
mu3_next <= mu3;
mu4_next <= mu4;
address_out <= (others => '0');
load_next <= '0';
count_mul_next <= count_mul;
count_coeff_next <= count_coeff;
count_col_next <= count_col;
sig_sreg1_next <= sig_sreg1;
sig_sreg2_next <= sig_sreg2;
sig_sreg3_next <= sig_sreg3;
sig_sreg4_next <= sig_sreg4;
next_address <= address;
address_out <= std_logic_vector (address);
state_next <= state_reg;
coeff_next <= coeff;
s_MU_out_next <= s_MU_out;

     
        case state_reg is
            when state_load =>
               if mul_en = '1' then 
                sig_sreg1_next <= s_reg1;
                sig_sreg2_next <= s_reg2;
                sig_sreg3_next <= s_reg3;
                sig_sreg4_next <= s_reg4;
                state_next <= clear_mu;
                else
                state_next <= state_load ;
                end if;
            when clear_mu => 
                           mu1_next <= (others => '0');
                           mu2_next <= (others => '0');
                           mu3_next <= (others => '0');
                           mu4_next <= (others => '0');
                           state_next <= select_coeff;
            
            when select_coeff =>
                if count_mul(0) = '1' then
                    coeff_next <= dataROM(6 downto 0);
                    --next_address <= address + 1; -- why is the address updating here?
                    state_next <= multiply;
                    
                else
                    coeff_next <= dataROM(13 downto 7);
                    --next_address <= address + 1;
                    state_next <= multiply;
                end if;
             
            when multiply =>
                
                mu1_next <= coeff * sig_sreg1(63 downto 56) + mu1;
                mu2_next <= coeff * sig_sreg2(63 downto 56) + mu2;
                mu3_next <= coeff * sig_sreg3(63 downto 56) + mu3;
                mu4_next <= coeff * sig_sreg4(63 downto 56) + mu4;
                 
                count_mul_next <= count_mul + 1;                                                    --Count mul 
                count_coeff_next <= count_coeff + 1;                                                --Count coeff
                if count_coeff = "01" then
                    next_address <= address + 1;
                    count_coeff_next <= "00";
                else 
                    next_address <= address; -- how is this address linked in the ROM??
                end if;
                state_next <= state_shift;
                                
            when state_shift =>
                    if count_mul = "1000" then   --Counting till 8 since we were skipping a clock cycle 
                        count_mul_next <= "0000";     --Count_mul reset //Added new
                        sig_sreg1_next <= sig_sreg1(55 downto 0) & sig_sreg1(63 downto 56);
                        sig_sreg2_next <= sig_sreg2(55 downto 0) & sig_sreg2(63 downto 56);
                        sig_sreg3_next <= sig_sreg3(55 downto 0) & sig_sreg3(63 downto 56);
                        sig_sreg4_next <= sig_sreg4(55 downto 0) & sig_sreg4(63 downto 56);
                        
                        if count_col = "000" then
                            s_MU_out_next <= s_MU_out (215 downto 0) & mu1_next & mu2_next & mu3_next & mu4_next;
                            count_col_next <= count_col + 1; -- 
                            state_next <= clear_mu; 
                            elsif count_col = "001" then  
                            s_MU_out_next <= s_MU_out (215 downto 0) & mu1_next & mu2_next & mu3_next & mu4_next;
                            count_col_next <= count_col + 1;
                            state_next <= clear_mu; 
                            elsif count_col = "010" then 
                            s_MU_out_next <= s_MU_out (215 downto 0) & mu1_next & mu2_next & mu3_next & mu4_next;
                            count_col_next <= count_col + 1;
                            state_next <= clear_mu; 
                            elsif count_col = "011" then 
                            s_MU_out_next <= s_MU_out (215 downto 0) & mu1_next & mu2_next & mu3_next & mu4_next;
                            state_next <= state_ram; 
                            count_col_next <= "000";
                            load_next <= '1';
                        end if;   
                    else 
                    sig_sreg1_next <= sig_sreg1(55 downto 0) & sig_sreg1(63 downto 56);
                    sig_sreg2_next <= sig_sreg2(55 downto 0) & sig_sreg2(63 downto 56);
                    sig_sreg3_next <= sig_sreg3(55 downto 0) & sig_sreg3(63 downto 56);
                    sig_sreg4_next <= sig_sreg4(55 downto 0) & sig_sreg4(63 downto 56);
                    state_next <= select_coeff;
                     
                    end if;
                    
             when state_ram => 
                           load_next <= '1';
                           state_next <= state_load;
                               
            end case;   
end process;
--Taking output 
MU_out <= s_MU_out;
end Behavioral;

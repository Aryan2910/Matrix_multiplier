library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee. numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Multiplier_unit is
    Port ( 
           clk : in std_logic;
           clear : in std_logic;
           --Register inputs
           s_reg1 : in std_logic_vector (63 downto 0);
           s_reg2 : in std_logic_vector (63 downto 0);
           s_reg3 : in std_logic_vector (63 downto 0);
           s_reg4: in std_logic_vector (63 downto 0);
           mu_en : in std_logic;
           dataROM : in std_logic_vector (13 downto 0);
           --outputs
           MU_1_out : out std_logic_vector (14 downto 0);
           MU_2_out : out std_logic_vector (14 downto 0);
           MU_3_out : out std_logic_vector (14 downto 0);
           MU_4_out : out std_logic_vector (14 downto 0);
           load : out std_logic 
           );
end Multiplier_unit;

architecture Behavioral of Multiplier_unit is
--signals
signal mu1, mu1_next : std_logic_vector (14 downto 0);
signal mu2, mu2_next : std_logic_vector (14 downto 0);
signal mu3, mu3_next : std_logic_vector (14 downto 0);
signal mu4, mu4_next : std_logic_vector (14 downto 0);
signal coeff, coeff_next : std_logic_vector (6 downto 0);
signal address, next_address : std_logic_vector (3 downto 0);
signal sig_sreg1_next, sig_sreg2_next, sig_sreg3_next, sig_sreg4_next : std_logic_vector (63 downto 0);
signal sig_sreg1, sig_sreg2, sig_sreg3, sig_sreg4 : std_logic_vector (63 downto 0);
--Count
signal count_mul, count_mul_next: std_logic_vector (3 downto 0);
--One bit signal
signal load_next : std_logic;
--state
type state_type is (state_load, select_coeff, multiply, state_shift);
signal state_reg, state_next : state_type;
BEGIN

sequential: process (clk,clear) begin
    if (rising_edge (clk)) then
        if clear = '1' then
            mu1 <= (others => '0');
            mu2 <= (others => '0');
            mu3 <= (others => '0');
            mu4 <= (others => '0');           
            coeff <= (others => '0');
            load <= '0';
            count_mul <= (others => '0');
            state_reg <= state_load;
            address <= (others => '0');   
            else
            mu1 <= mu1_next;
            mu2 <= mu1_next;
            mu3 <= mu1_next;
            mu4 <= mu1_next;
            count_mul <= count_mul_next;
            coeff <= coeff_next;
            load <= load_next;
            address <= next_address;
            state_reg <= state_next;
        end if;    
    end if;
end process;

----taking input



combinational: process (mu_en,state_reg, state_next, count_mul) begin
mu1_next <= mu1;
mu2_next <= mu2;
mu3_next <= mu3;
mu4_next <= mu4;
MU_1_out <= (others => '0');
MU_2_out <= (others => '0');
MU_3_out <= (others => '0');
MU_4_out <= (others => '0');
load_next <= '0';
count_mul_next <= count_mul;
sig_sreg1 <= sig_sreg1_next;
sig_sreg2 <= sig_sreg2_next;
sig_sreg3 <= sig_sreg3_next;
sig_sreg4 <= sig_sreg4_next;
next_address <= address;
state_next <= state_reg;
coeff_next <= coeff;
    if mu_en = '1' then 
        case state_reg is
            when state_load =>
                sig_sreg1 <= s_reg1;
                sig_sreg1_next <= sig_sreg1;
                sig_sreg2 <= s_reg2;
                sig_sreg2_next <= sig_sreg2;
                sig_sreg3 <= s_reg3;
                sig_sreg3_next <= sig_sreg3;
                sig_sreg4 <= s_reg4;
                sig_sreg4_next <= sig_sreg4;
                state_next <= select_coeff;
            when select_coeff =>
                if count_mul(0) = '1' then
                    coeff_next <= dataRom(13 downto 7);
                    next_address <= address + 1;
                    state_next <= multiply;
                    
                else
                    coeff_next <= dataRom(6 downto 0);
                    next_address <= address + 1;

                    state_next <= multiply;
                end if;
                
            when multiply =>
                mu1_next <= coeff_next * sig_sreg1(63 downto 56) + mu1;
                mu2_next <= coeff_next * sig_sreg2(63 downto 56) + mu2;
                mu3_next <= coeff_next * sig_sreg3(63 downto 56) + mu3;
                mu4_next <= coeff_next * sig_sreg4(63 downto 56) + mu4;
                count_mul_next <= count_mul + 1;
                state_next <= state_shift;
                
                
            when state_shift =>
                    if count_mul = "111" then 
                    load_next <= '1';
                    MU_1_out <= mu1_next;
                    MU_2_out <= mu2_next;
                    MU_3_out <= mu3_next;
                    MU_4_out <= mu4_next;
                    state_next <= state_shift;
                    else 
                    sig_sreg1_next <= sig_sreg1(55 downto 0) & sig_sreg1(63 downto 56);
                    sig_sreg2_next <= sig_sreg2(55 downto 0) & sig_sreg2(63 downto 56);
                    sig_sreg3_next <= sig_sreg3(55 downto 0) & sig_sreg3(63 downto 56);
                    sig_sreg4_next <= sig_sreg4(55 downto 0) & sig_sreg4(63 downto 56);
                    state_next <= select_coeff;
                    end if;    
        end case;
    end if;    
end process;

end Behavioral;

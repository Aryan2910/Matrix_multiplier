library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
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
           MU_4_out : out std_logic_vector (14 downto 0)
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
--Count
signal count_mul, count_mul_next : std_logic_vector (3 downto 0);
--state
type state_type is (select_coeff, multiply, shift);
signal state_reg, state_next : state_type;
BEGIN

sequential: process (clk,clear) begin
    if (rising_edge (clk)) then
        if clear = '1' then
            mu1 <= (others => '0');
            mu2 <= (others => '0');
            mu3 <= (others => '0');
            mu4 <= (others => '0');
            count_mul <= (others => '0');
            coeff <= (others => '0');
            state_reg <= select_coeff;   
            else
            mu1 <= mu1_next;
            mu2 <= mu1_next;
            mu3 <= mu1_next;
            mu4 <= mu1_next;
            count_mul <= count_mul_next;
            coeff <= coeff_next;
            state_reg <= state_next;
        end if;    
    end if;
end process;

combinational: process (mu_en) begin
mu1_next <= mu1;
mu2_next <= mu2;
mu3_next <= mu3;
mu4_next <= mu4;
count_mul_next <= count_mul;


    if mu_en = '1' then 
        case state_reg is
            when select_coeff =>
                if count_mul(0) = '1' then
                    coeff <= dataRom(13 downto 0);
                    next_address <= address + 1;
                else
                    coeff <= dataRom(6 downto 0);
                    next_address <= address + 1;
                end if;
                state_next <= multiply;
            when multiply =>
                mu1_next <= coeff * s_reg1(63 downto 56) + mu1;
                mu2_next <= coeff * s_reg2(63 downto 56) + mu2;
                mu3_next <= coeff * s_reg3(63 downto 56) + mu3;
                mu4_next <= coeff * s_reg4(63 downto 56) + mu4;
                state_next <= shift;
            when shift =>
                -- we will have to somehow shift the MSB to the start of the s_reg register..should we create a new register? 
                
        end case;
    end if;    
end process;

end Behavioral;

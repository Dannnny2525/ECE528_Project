library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm is
    Generic(
     R	: integer := 8
    );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           duty : in STD_LOGIC_VECTOR (R-1 downto 0);
           dvsr 	: in std_logic_vector(31 downto 0);
           pwm_out : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is

signal q_reg 	: unsigned(31 downto 0);  -- 32 bit register
signal q_next 	: unsigned(31 downto 0);

signal d_reg 	: unsigned(R-1 downto 0); -- 8 bit register
signal d_next 	: unsigned(R-1 downto 0);
signal d_ext 	: unsigned(R downto 0);   -- 9 bit register

signal pwm_reg	: std_logic;
signal pwm_next	: std_logic;
signal tick		: std_logic;

begin

process(clk, reset)
begin
	if reset = '1' then                -- Default signals to '0'
		q_reg <= (others => '0');
		d_reg <= (others => '0');
		pwm_reg <= '0';
	elsif rising_edge(clk) then
		q_reg <= q_next;               -- Q register assigned next value
		d_reg <= d_next;               -- D register assigned next value
		pwm_reg <= pwm_next;           -- PWM register assigned next value
	end if;
end process;

-- If q_reg == dvsr value then "q_next" = 0 else "q_next" = q_reg + 1. This is to generate 20 kHz
q_next <= (others => '0') when q_reg = unsigned(dvsr) else q_reg + 1;		-- prescaler counter. "when" creates priority mux	

-- Tick signal = 1 when q_reg gets reset/equals 0/half period, else = 0		
tick <= '1' when q_reg = 0 else '0';		

-- If tick == 1 then "d_next" = d_reg + 1, else "d_next" = d_reg just latches				
d_next <= d_reg + 1 when tick = '1' else d_reg;     --duty cycle counter

-- d_ext gets d_reg with padded zero
d_ext <= '0' & d_reg;

-- PWM outputs 1 while d_ext is less than duty value, else outputs 0
pwm_next <= '1' when d_ext < unsigned(duty) else '0';

pwm_out <= pwm_reg;

end Behavioral;
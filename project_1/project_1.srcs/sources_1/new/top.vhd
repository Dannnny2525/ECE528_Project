library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity top is
  port(
	clk	   : in std_logic;
	rst	   : in std_logic;
	DOUT    : in STD_LOGIC;
    PD_SCK  : out STD_LOGIC;
	pwm1   : out std_logic                       -- Signal to Driver Motor to control RPM. 20 kHz PWM signal with variable duty cycle
    );
end top;


architecture Behavioral of top is

------------------------------------Components-----------------------------------------------------
component pwm is 
    generic(
	   R	: integer := 8
    );
    port(
        clk		: in std_logic;
        reset 	: in std_logic;
        duty 	: in std_logic_vector(R-1 downto 0);	   -- Duty Cycle value from 0 to 512 for 0 to 100% 
        dvsr 	: in std_logic_vector(31 downto 0);
        pwm_out : out std_logic); 
end component;

component ADC_HX711 is
  Port ( 
    clk     : in STD_LOGIC;
    rst     : in STD_LOGIC;
    DOUT    : in STD_LOGIC;
    PD_SCK  : out STD_LOGIC;
    data    : out STD_LOGIC_VECTOR(23 downto 0)
  ); 
end component;

------------------------------------Signals-----------------------------------------------------
constant resolution : integer := 8;                                                     
constant dvsr       : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(23,32));	-- 20kHz = 125M/(2^8*20k) = 24.4 = f_sys/(2^resolution*f_pwm)

signal pwm_reg1     : std_logic;
signal duty_reg     : std_logic_vector(7 downto 0);

signal data_reg     : std_logic_vector(23 downto 0);

signal DOUT_buf1    : std_logic;
signal DOUT_buf2    : std_logic;


begin
------------------------------------Logic-----------------------------------------------------

pwm_uut: pwm generic map(R	=> resolution)	
	Port map(
	clk		=> clk,
	reset 	=> rst, 
	duty 	=> duty_reg,		
	dvsr 	=> dvsr,         
	pwm_out => pwm_reg1);    
	
ADC_uut: ADC_HX711 
  port map( 
    clk     => clk,
    rst     => rst,
    DOUT    => DOUT_buf2,
    PD_SCK  => PD_SCK,
    data    => data_reg
  ); 


process(clk, rst)
begin
	if rst = '1' then                -- Default signals to '0'
        duty_reg <= (others => '0');     -- 0%  --Duty Cycle value from 0 to 256 for 0 to 100%
	elsif rising_edge(clk) then
    
        if to_integer(unsigned(data_reg)) < 1000 then
            duty_reg <= "01000000";     -- 25%  --Duty Cycle value from 0 to 256 for 0 to 100%           
         elsif (to_integer(unsigned(data_reg)) > 1000) AND (to_integer(unsigned(data_reg)) < 3000) then 
            duty_reg <= "10000000";     -- 50%           
         else 
            duty_reg <= "11000000";     -- 75% 
         end if;   
                        
	end if;
end process;



pwm1 <= pwm_reg1;
	    	
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ADC_HX711_tb is
--  Port ( );
end ADC_HX711_tb;

architecture Behavioral of ADC_HX711_tb is

constant CP : time := 8ns;      -- Time Period for 125Mhz

signal clk_tb       : std_logic;
signal rst_tb       : std_logic;
signal DOUT_tb      : std_logic;
signal PD_SCK_tb    : std_logic;
signal data_tb      : std_logic_vector(23 downto 0);



component ADC_HX711 is
  port(
     clk, rst, DOUT   : in std_logic; 
     PD_SCK           : out std_logic;
     data             : out std_logic_vector(23 downto 0)
  );
end component ADC_HX711;


begin

ADC_HX711_i: ADC_HX711 port map(
    clk     => clk_tb,
    rst     => rst_tb,
    DOUT    => DOUT_tb,    
    PD_SCK  => PD_SCK_tb,    
    data    => data_tb
    );

--125 MHz     
process 
begin
clk_tb <= '1';
wait for CP/2;
clk_tb <= '0';
wait for CP/2;
end process;

process 
begin

rst_tb  <= '1';
DOUT_tb <= '1';

wait for CP;
rst_tb <= '0';

wait for CP;
DOUT_tb <= '0';

wait for 12*CP;
DOUT_tb <= '1';     -- Bit 1 MSB
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 2
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 3
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 4

wait for 250*CP;
DOUT_tb <= '1';     -- Bit 5
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 6
wait for 250*CP;
DOUT_tb <= '1';     -- Bit 7
wait for 250*CP;
DOUT_tb <= '1';     -- Bit 8

wait for 250*CP;
DOUT_tb <= '1';     -- Bit 9
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 10
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 11
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 12

wait for 250*CP;
DOUT_tb <= '0';     -- Bit 13
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 14
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 15
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 16

wait for 250*CP;
DOUT_tb <= '0';     -- Bit 17
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 18
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 19
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 20

wait for 250*CP;
DOUT_tb <= '0';     -- Bit 21
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 22
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 23
wait for 250*CP;
DOUT_tb <= '1';     -- Bit 24
-- Sending value 9,142,273 == "1000 1011 1000 0000 0000 0001"


wait for 500*CP;            -- NEED 500*CP of delay after every packer. Will need to test with hardware. Might need to create a state for this
DOUT_tb <= '0';
wait for 12*CP;     -- Delay

DOUT_tb <= '0';     -- Bit 23 MSB
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 22
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 21
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 20

wait for 250*CP;
DOUT_tb <= '0';     -- Bit 19
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 18
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 17
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 16

wait for 250*CP;
DOUT_tb <= '1';     -- Bit 15
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 14
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 13
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 12

wait for 250*CP;
DOUT_tb <= '0';     -- Bit 11
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 10
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 9
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 8

wait for 250*CP;
DOUT_tb <= '1';     -- Bit 7
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 6
wait for 250*CP;
DOUT_tb <= '1';     -- Bit 5
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 4

wait for 250*CP;
DOUT_tb <= '1';     -- Bit 3
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 2
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 1
wait for 250*CP;
DOUT_tb <= '1';     -- Bit 0
-- Sending value 32,937 == "0000 0000 1000 0000 1010 1001"


wait for 500*CP;            -- NEED 500*CP of delay after every packer. Will need to test with hardware. Might need to create a state for this
DOUT_tb <= '0';
wait for 12*CP;     -- Delay

DOUT_tb <= '0';     -- Bit 23 MSB
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 22
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 21
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 20

wait for 250*CP;
DOUT_tb <= '0';     -- Bit 19
wait for 250*CP;
DOUT_tb <= '1';     -- Bit 18
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 17
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 16

wait for 250*CP;
DOUT_tb <= '1';     -- Bit 15
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 14
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 13
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 12

wait for 250*CP;
DOUT_tb <= '1';     -- Bit 11
wait for 250*CP;
DOUT_tb <= '1';     -- Bit 10
wait for 250*CP;
DOUT_tb <= '1';     -- Bit 9
wait for 250*CP;
DOUT_tb <= '1';     -- Bit 8

wait for 250*CP;
DOUT_tb <= '1';     -- Bit 7
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 6
wait for 250*CP;
DOUT_tb <= '1';     -- Bit 5
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 4

wait for 250*CP;
DOUT_tb <= '1';     -- Bit 3
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 2
wait for 250*CP;
DOUT_tb <= '0';     -- Bit 1
wait for 250*CP;
DOUT_tb <= '1';     -- Bit 0
-- Sending value 298,921 == "0000 0100 1000 1111 1010 1001"




wait;
end process;

end Behavioral;


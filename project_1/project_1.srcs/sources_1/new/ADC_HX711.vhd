-- 1) When DOUT is high '1' when not ready for to send data out
-- and PD_SCK should be low.

-- When DOUT goes low '0' then data is ready to be sent out 
-- Wait 0.1us before pulsing, so 12 counts with 125 MHz SCLK
-- Apply 24 pulses at PD_SCK at a frequency of 500kHz
-- Data, 24bits, will be shifted out from DOUT
-- Each pulse will shift 1 bit starting with MSB
-- 25th bit will pull DOUT back to high


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ADC_HX711 is
  Port ( 
    clk     : in STD_LOGIC;
    rst     : in STD_LOGIC;
    DOUT    : in STD_LOGIC;
    PD_SCK  : out STD_LOGIC;
    data    : out STD_LOGIC_VECTOR(23 downto 0)
  ); 
end ADC_HX711;

architecture Behavioral of ADC_HX711 is

signal delayCount : integer range 0 to 13;        -- Limit to 13
signal periodCount : integer range 0 to 13;        -- Limit to 251
signal pulseCount : integer range 0 to 25;        -- Limit to 251

constant pulseHalfPeriod: integer := 125;	

type StateType is (Initial,Delay,lowPulse,highPulse);
signal current_state: StateType := Initial;

signal data_reg	: std_logic_vector(23 downto 0);

begin

process(clk, rst)
begin

	if rst = '1' then
	
		delayCount    <= 0;
		periodCount   <= 0;
		pulseCount    <= 0;
		PD_SCK        <= '0';
		current_state <= Initial;
		data_reg      <= (others => '0');
        data <= (others => '0');
	elsif rising_edge(clk) then
	
		if current_state = Initial then
			if DOUT = '1' then                   -- Detect when ready to receive data
				current_state <= Initial;	
			else		
				current_state <= delay;    
			end if;		
			
		elsif current_state = delay then
            delayCount <= delayCount + 1;    -- Wait 0.1us before pulsing   
            
            if delayCount = 12 then
                current_state <= lowPulse;
                PD_SCK        <= '1';           -- Start pulse high 
                delayCount    <= 0;
            else
            end if;
			
		elsif current_state = lowPulse then
            periodCount <= periodCount + 1;    
                
			if periodCount = pulseHalfPeriod-1 then                 -- Toggle low when half of 500kHz period
			    pulseCount <= pulseCount + 1;
			    
			    if pulseCount = 24 then 		  
			        PD_SCK        <= '0';	
			        current_state <= Initial;
			        periodCount   <= 0;	
			        pulseCount    <= 0;
        
			    elsif pulseCount < 24 then
                    PD_SCK        <= '0'; 
                    current_state <= highPulse;
                    periodCount   <= 0;
                    data_reg <= data_reg(22 downto 0) & DOUT;  
                else
                    PD_SCK        <= '0';
                    current_state <= highPulse;
                    periodCount   <= 0;
                end if;
			else 				
			end if;
			
		elsif current_state = highPulse then
            periodCount <= periodCount + 1;    
                
			if periodCount = pulseHalfPeriod-1 then                 -- Toggle high when half of 500kHz period
				PD_SCK        <= '1'; 
				current_state <= lowPulse;
				periodCount   <= 0;
			else 
				
			end if;	
								
		else                                      -- Default
			current_state <= Initial;
		end if;
		
	end if;
end process;


end Behavioral;

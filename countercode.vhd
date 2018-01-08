
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity jkff is 
Port ( j : in STD_LOGIC; 
k : in STD_LOGIC; 
number: in STD_LOGIC_VECTOR(2 downto 0);
clock : in STD_LOGIC; 
reset : in STD_LOGIC; 
q : out STD_LOGIC 
); 
end jkff; 

architecture rtl of jkff is 
signal jk : std_logic_vector(1 downto 0) := "00"; 
signal qsignal : std_logic := '0';

begin 
jk <= j & k; 
process(reset,clock) 
begin 
	if (reset = '1')then 
 
		case (number) is 
			when "000" => qsignal <= '0'; 
			when "001" => qsignal <= '1'; 
			when "010" => qsignal <= '0'; 
			when "011" => qsignal <= '1';  
			when others => qsignal <= '0'; 
		end case; 

	elsif (clock'event and clock = '1')then 
		case (jk) is 
			when "00" => qsignal <= qsignal; 
			when "01" => qsignal <= '0'; 
			when "10" => qsignal <= '1'; 
			when others => qsignal <= not qsignal; 
		end case; 
	end if; 
end process;

q <= qsignal; 
end rtl; 


library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity jkc is 
Port ( clock : in std_logic; reset : in std_logic; 
count : out std_logic_vector(4 downto 0) ); 
end jkc;

architecture rtl of jkc is 
COMPONENT jkff 
PORT( 
clock : in std_logic; 
number: in STD_LOGIC_VECTOR(2 downto 0);
reset : in std_logic; 
j : in std_logic; 
k : in std_logic; 
q : out std_logic 
); 
END COMPONENT;

signal temp : std_logic_vector(4 downto 0) := "00000"; 
signal nottemp : std_logic_vector(4 downto 0) := "11111"; 
begin 
d0 : jkff port map ( reset => reset, clock => clock,number => "000",j => '0', k => '1', q => temp(4) ); 
d1 : jkff port map ( reset => reset, clock => clock, number => "001",j => '1', k => '1', q => temp(3) ); 
d2 : jkff port map ( reset => reset, clock => nottemp(3), number => "010",j => '1', k => '1', q => temp(2) ); 
d3 : jkff port map ( reset => reset, clock => nottemp(2), j => '1', number => "011",k => '1', q => temp(1) ); 
d4 : jkff port map ( reset => reset, clock => nottemp(1), j => '1', number => "100",k => '1', q => temp(0) ); 

nottemp(0)<= not temp(0);
nottemp(1) <= not temp(1); 
nottemp(2) <= not temp(2); 
nottemp(3) <= not temp(3); 
nottemp(4) <= not temp(4); 

count(4)<= temp(0);
count(3) <= temp(1); 
count(2) <= temp(2); 
count(1) <= temp(3); 
count(0) <= temp(4); 
end rtl; 




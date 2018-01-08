
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity onebitadder is
port( P,G : in std_logic_vector(3 downto 0) ;
	Cin: in std_logic;
	C:out std_logic_vector(4 downto 0));
end entity;

architecture mixed of onebitadder is
begin 

C(0) <= Cin;
C(1) <= G(0) or (P(0) and Cin);
C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Cin);
C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and Cin);
C(4) <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and Cin);

end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity fourbitadder is
port(Ain,Bin : in std_logic_vector(3 downto 0);
	Sout : out std_logic_vector(3 downto 0);
	Cinitial: in std_logic;
	Cfinal: out std_logic);
end entity;

architecture structure of fourbitadder is

signal P ,G : std_logic_vector(3 downto 0);
signal C : std_logic_vector(4 downto 0 );


component onebitadder is 
port(P,G : in std_logic_vector(3 downto 0);
	cin: in std_logic;
	C:out std_logic_vector(4 downto 0));
end component;

begin

P <= Ain xor Bin;
G <= Ain and Bin;

Label1 : onebitadder port map(P,G,Cinitial,C);

Sout <= P xor C (3 downto 0 );
Cfinal <= C(4);

end architecture;
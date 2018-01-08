library ieee;
use ieee.std_logic_1164.all;

entity inputc is
port(
input:in std_logic_vector(20 downto 0);
clock:in std_logic;
output:out std_logic
);
end entity;

architecture arc_inputc of inputc is
type states is (s0,s1,s2);
signal currstate:states:=s0;
signal index:integer:=0;
begin
process(clock,currstate)
begin
	if(clock'event and clock='1')then
		case (currstate) is
			when s0=>
				if(input(index)='1')then
					currstate <= s2;
					output<='0';
				else
					currstate <= s1;
					output<='0';
				end if;
			when s1=>
				if(input(index)='1')then
					currstate <= s0;
					output<='1';
				else
					currstate <= s1;
					output<='0';
				end if;
			when s2=>
				if(input(index)='1')then
					currstate <= s2;
					output<='0';
				else
					currstate <= s0;
					output<='1';
				end if;
		end case;
		index<=index+1;			
	end if;

end process;
end architecture;
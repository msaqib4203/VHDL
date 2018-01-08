library ieee;
use ieee.std_logic_1164.all;

entity fourmux is
port(
A0,A1,A2,A3: in std_logic;
sel: in std_logic_vector(1 downto 0);
sout: out std_logic
);
end entity;

architecture arc_four of fourmux is
begin
sout<= (not sel(0) and not sel(1) and A0) or (not sel(0) and sel(1) and A2) or (not sel(1) and sel(0) and A1) or (sel(0) and sel(1) and A3);

end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity dff is
port(clock,reset,qin:in std_logic;
qout:out std_logic
);
end entity;

architecture arc_dff of dff is
begin
process(clock,reset)
begin
	if(reset = '1')then
		qout<='0';
	elsif(clock'EVENT and clock='1')then
		qout<=qin;
	end if;
end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
entity unishift is
port(input:in std_logic_vector(3 downto 0);
control: in std_logic_vector(1 downto 0);
output: out std_logic_vector(3 downto 0);
clk,rst:in std_logic
);
end entity;

architecture arc_uni of unishift is
component fourmux is
port(
A0,A1,A2,A3: in std_logic;
sel: in std_logic_vector(1 downto 0);
sout: out std_logic
);
end component;
component dff is
port(clock,reset,qin:in std_logic;
qout:out std_logic
);
end component;
signal q0,q1,q2,q3,out0,out1,out2,out3:std_logic:='0';

begin
F0: dff port map(clk,rst,out0,q0);
L0: fourmux port map(q0,'0',q1,input(0),control,out0);
output(0)<=q0;
F1: dff port map(clk,rst,out1,q1);
L1: fourmux port map(q1,q0,q2,input(1),control,out1);
output(1)<=q1;
F2: dff port map(clk,rst,out2,q2);
L2: fourmux port map(q2,q1,q3,input(2),control,out2);
output(2)<=q2;
F3: dff port map(clk,rst,out3,q3);
L3: fourmux port map(q3,q2,'0',input(3),control,out3);
output(3)<=q3;
end architecture;


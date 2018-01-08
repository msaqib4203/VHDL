library ieee;
use ieee.std_logic_1164.all;

entity fa is
port(
    ai,bi,ci:in std_logic;
    co,so:out std_logic
);
end entity;

architecture fa_arc of fa is
begin
so<= (ai xor bi) xor ci;
co<= (ai and bi) or (ci and (ai xor bi));
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity bada is
port(
ain,bin: in std_logic_vector(3 downto 0);
cout: out std_logic;
cin: in std_logic;
sout: out std_logic_vector(3 downto 0)
);
end entity;

architecture bada_arc of bada is
component fa is
port(
    ai,bi,ci:in std_logic;
    co,so:out std_logic
);
end component;

signal c1,c2,c3:std_logic;
signal t1,t2,t3,t4:std_logic;

begin
t1<=bin(0) xor cin;
t2<=bin(1) xor cin;
t3<=bin(2) xor cin;
t4<=bin(3) xor cin;
L1: fa port map(ain(0),t1,cin,c1,sout(0));
L2: fa port map(ain(1),t2,c1,c2,sout(1));
L3: fa port map(ain(2),t3,c2,c3,sout(2));
L4: fa port map(ain(3),t4,c3,cout,sout(3));

end architecture;









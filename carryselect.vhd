library ieee;
use ieee.std_logic_1164.all;

entity ripple is
port(
arin,brin:in std_logic_vector(2 downto 0);
crin: in std_logic;
crout:out std_logic;
srout:out std_logic_vector(2 downto 0)
);
end entity;
architecture rip_Arc of ripple is
component fa is
port(
    ai,bi,ci:in std_logic;
    co,so:out std_logic
);
end component;
signal cr1,cr2:std_logic;
begin
L1: fa port map(arin(0),brin(0),crin,cr1,srout(0));
L2: fa port map(arin(1),brin(1),cr1,cr2,srout(1));
L3: fa port map(arin(2),brin(2),cr2,crout,srout(2));
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity mux is
port(
sel:in std_logic;
r0,r1:in std_logic_vector(3 downto 0);
muxout:out std_logic_vector(3 downto 0)
);
end entity;
architecture arc_mux of mux is

begin
muxout(0)<= (r1(0) and sel) or (r0(0) and (not sel));
muxout(1)<= (r1(1) and sel) or (r0(1) and (not sel));
muxout(2)<= (r1(2) and sel) or (r0(2) and (not sel));
muxout(3)<= (r1(3) and sel) or (r0(3) and (not sel));
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity carryselect is

port(
acin,bcin:in std_logic_vector(3 downto 0);
ccin: in std_logic;
ccout: out std_logic;
scout: out std_logic_vector(3 downto 0)
);

end entity;

architecture arc_carry of carryselect is
component fa is
port(
    ai,bi,ci:in std_logic;
    co,so:out std_logic
);
end component;

component ripple is
port(
arin,brin:in std_logic_vector(2 downto 0);
crin: in std_logic;
crout:out std_logic;
srout:out std_logic_vector(2 downto 0)
);
end component;

component mux is
port(
sel:in std_logic;
r0,r1:in std_logic_vector(3 downto 0);
muxout:out std_logic_vector(3 downto 0)
);
end component;
signal carryselector,rb:std_logic;
signal result0,result1:std_logic_vector(3 downto 0);
begin
FA1: fa port map (acin(0),bcin(0),ccin,carryselector,rb);
result0(0)<=rb;
result1(0)<=rb;
RIP0: ripple port map (acin(3 downto 1),bcin(3 downto 1),'0',ccout,result0(3 downto 1));
RIP1: ripple port map (acin(3 downto 1),bcin(3 downto 1),'1',ccout,result1(3 downto 1));
MUXC: mux port map (carryselector,result0(3 downto 0),result1(3 downto 0),scout(3 downto 0));
end architecture;

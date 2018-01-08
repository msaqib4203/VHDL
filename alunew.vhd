library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
	port (
		a,b,carry_in:IN STD_LOGIC;
      		sum,carry_out:OUT STD_LOGIC);
end adder;

architecture arc_adder of adder is
begin
	sum<= a xor b xor carry_in;
	carry_out<= (a and b) or (carry_in and a) or (carry_in and b);
end arc_adder;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity subtractor is
	port (
		a,b,carry_in:IN STD_LOGIC;
      		sum,carry_out:OUT STD_LOGIC);
end subtractor;

architecture arc_subtractor of subtractor is
begin
	sum<= a xor ( not b ) xor carry_in;
	carry_out<= (a and ( not b )) or (carry_in and a) or (carry_in and ( not b ));
end arc_subtractor;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alunit is
	port (
		A,B: in std_logic_vector(4 downto 1);
		S: in std_logic_vector(4 downto 1);
		Cin: in std_logic;
		E: out std_logic_vector(4 downto 1);
		Cout: out std_logic);
end alunit;

architecture arc_alu of alunit is

component adder
	port (
		a,b,carry_in:IN STD_LOGIC;
      		sum,carry_out:OUT STD_LOGIC);
end component adder;

component subtractor
	port (
		a,b,carry_in:IN STD_LOGIC;
      		sum,carry_out:OUT STD_LOGIC);
end component subtractor;

signal e_add,e_sub: std_logic_vector(4 downto 1);
signal c_add,c_sub: std_logic_vector(5 downto 2);
begin

u1 : adder port map (A(1),B(1),Cin,e_add(1),c_add(2));
u2 : adder port map (A(2),B(2),c_add(2),e_add(2),c_add(3));
u3 : adder port map (A(3),B(3),c_add(3),e_add(3),c_add(4));
u4 : adder port map (A(4),B(4),c_add(4),e_add(4),c_add(5));

u5 : subtractor port map (A(1),B(1),'1',e_sub(1),c_sub(2));
u6 : subtractor port map (A(2),B(2),c_sub(2),e_sub(2),c_sub(3));
u7 : subtractor port map (A(3),B(3),c_sub(3),e_sub(3),c_sub(4));
u8 : subtractor port map (A(4),B(4),c_sub(4),e_sub(4),c_sub(5));

process(A,B,S,e_add,c_add,e_sub,c_sub)
begin


	if ( S = "0000" ) then --Addition
		E(1) <= e_add(1);
		E(2) <= e_add(2);
		E(3) <= e_add(3);
		E(4) <= e_add(4);
		Cout <= c_add(5);
	elsif ( S = "0001" ) then --Subtraction
		E(1) <= e_sub(1);
		E(2) <= e_sub(2);
		E(3) <= e_sub(3);
		E(4) <= e_sub(4);
		Cout <= c_sub(5);
	elsif ( S = "0010" ) then --logical shift left
		E(1) <= '0';
		E(2) <= A(1);
		E(3) <= A(2);
		E(4) <= A(3);
	elsif ( S = "0011" ) then --logical shift right
		E(1) <= A(2);
		E(2) <= A(3);
		E(3) <= A(4);
		E(4) <= '0';
	elsif ( S = "0100" ) then --arithmetic shift left
		E(1) <= '0';
		E(2) <= A(1);
		E(3) <= A(2);
		E(4) <= A(3);
	elsif ( S = "0101" ) then --arithmetic shift right
		E(1) <= A(2);
		E(2) <= A(3);
		E(3) <= A(4);
		E(4) <= A(4);
	elsif ( S = "0110" ) then --rotate left
		E(1) <= A(4);
		E(2) <= A(1);
		E(3) <= A(2);
		E(4) <= A(3);
	elsif ( S = "0111" ) then --rotate right
		E(1) <= A(2);
		E(2) <= A(3);
		E(3) <= A(4);
		E(4) <= A(1);
	elsif ( S = "1000" ) then --and
		E <= A and B ;
	elsif ( S = "1001" ) then --or
		E <= A or B ;
	elsif ( S = "1010" ) then --xor
		E <= A xor B ;
	elsif ( S = "1011" ) then --not
		E <= not ( A ) ;
	elsif ( S = "1100" ) then --xnor
		E <= A xnor B ;
	end if;
end process;
end arc_alu;
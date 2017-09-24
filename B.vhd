library IEEE;
Use ieee.STD_LOGIC_1164.all;

entity partB is 
  generic (N: integer := 16);
  port(a, b: in std_logic_vector(N-1 downto 0);
       s1, s0: in std_logic;
       f: out std_logic_vector(N-1 downto 0));
end;

architecture partBArch of partB is
  begin
    f <= (a and b) when s1 = '0' and s0 = '0'
    else (a or b) when s1 = '0' and s0 = '1'
    else (a xor b) when s1 = '1' and s0 = '0'
    else (not a);
  end partBArch;
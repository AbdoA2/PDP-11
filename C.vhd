library IEEE;
Use ieee.STD_LOGIC_1164.all;

entity partC is 
  generic (N: integer := 16);
  port(a: in std_logic_vector(N-1 downto 0);
       s1, s0, cin: in std_logic;
       f: out std_logic_vector(N-1 downto 0);
       c, v: out STD_LOGIC);
end;

architecture partCArch of partC is
  begin
    f <= "0" & a(N-1 downto 1) when s1 = '0' and s0 = '0'
    else a(0) & a(N-1 downto 1) when s1 = '0' and s0 = '1'
    else cin & a(N-1 downto 1) when s1 = '1' and s0 = '0'
    else a(N-1) & a(N-1 downto 1);
    
    -- set flags
    c <= a(0);
    v <= a(N-1) xor a(N-2);
    
  end partCArch;
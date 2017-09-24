library IEEE;
Use ieee.STD_LOGIC_1164.all;

entity partD is 
  generic (N: integer := 16);
  port(a: in std_logic_vector(N-1 downto 0);
       s1, s0, cin: in std_logic;
       f: out std_logic_vector(N-1 downto 0);
       c, v: out STD_LOGIC);
end;

architecture partDArch of partD is
  begin
    
    f <= a(N-2 downto 0) & "0" when s1 = '0' and s0 = '0'     -- SHIFT LEFT
    else a(N-2 downto 0) & a(N-1) when s1 = '0' and s0 = '1'  -- ROTATE LEFT
    else a(N-2 downto 0) & cin when s1 = '1' and s0 = '0'     -- ROTATE LEFT WITH CARRY
    else (N-1 downto 0 => '0');                               -- ZEROS
      
    -- set flags
    v <= a(N-1) when s1 = '1' and s0 = '1'
    else a(N-1) xor a(N-2);
      
    -- carry flag
    c <= '0' when s1 = '1' and s0 = '1'
    else a(N-1);
  end partDArch;
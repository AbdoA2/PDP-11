library IEEE;
Use ieee.STD_LOGIC_1164.all;

entity ALSU is
  generic (N: integer := 16);
  port(a, b: in STD_LOGIC_VECTOR(N-1 downto 0);
       s: in STD_LOGIC_VECTOR(3 downto 0);
       cin: in STD_LOGIC;
       f: inout STD_LOGIC_VECTOR(N-1 downto 0);
       CF, VF, NF, ZF: out STD_LOGIC);
end;

architecture ALSUI of ALSU is
  component partA is
    generic (N: integer := 16);
    port(a, b: in STD_LOGIC_VECTOR (N-1 downto 0);
         cin, s1, s0: in STD_LOGIC;
         F: out STD_LOGIC_VECTOR (N-1 downto 0);
         cout, v: out STD_LOGIC);
  end component;
     
  component partB is 
    generic (N: integer := 16);
    port(a, b: in STD_LOGIC_VECTOR(N-1 downto 0);
         s1, s0: in STD_LOGIC;
         f: out STD_LOGIC_VECTOR(N-1 downto 0));
  end component;
  
  component partC is 
    generic (N: integer := 16);
    port(a: in STD_LOGIC_VECTOR(N-1 downto 0);
         s1, s0, cin: in STD_LOGIC;
         f: out STD_LOGIC_VECTOR(N-1 downto 0);
         c, v: out STD_LOGIC);
  end component;
  
  component partD is 
    generic (N: integer := 16);
    port(a: in STD_LOGIC_VECTOR(N-1 downto 0);
         s1, s0, cin: in STD_LOGIC;
         f: out STD_LOGIC_VECTOR(N-1 downto 0);
         c, v: out STD_LOGIC);
  end component;
  
  signal f0, f1, f2, f3, zero_flag_compare: STD_LOGIC_VECTOR(N-1 downto 0);
  signal c0, v0, v2, v3, c2, c3: STD_LOGIC;
  
  begin
    
    u0: partA generic map(N) port map(a, b, cin, s(1), s(0), f0, c0, v0);
    u1: partB generic map(N) port map(a, b, s(1), s(0), f1);
    u2: partC generic map(N) port map(a, s(1), s(0), cin, f2, c2, v2);
    u3: partD generic map(N) port map(a, s(1), s(0), cin, f3, c3, v3);
      
    f <= f0 when s(3 downto 2) = "00"
    else f1 when s(3 downto 2) = "01"
    else f2 when s(3 downto 2) = "10"
    else f3;
      
    -- set flags --
    -- Carry Flag
    CFmux: entity work.mux4_1bit port map(c0, '0', c2, c3, s(1 downto 0), CF);
    
    -- Overflow Flag 
    VFmux: entity work.mux4_1bit port map(v0, '0', v2, v3, s(1 downto 0), VF);
      
     -- Negative flag
    NF <= f(N-1); 
    zero_flag_compare <= (others =>'0');
    ZF <= '1' when f = zero_flag_compare else '0';
    
  end ALSUI;
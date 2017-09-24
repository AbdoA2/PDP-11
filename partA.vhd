Library ieee;
Use ieee.STD_LOGIC_1164.all;

entity partA is
  generic (N: integer := 16);
  port(a, b: in STD_LOGIC_VECTOR (N-1 downto 0);
       cin, s1, s0: in STD_LOGIC;
       F: out STD_LOGIC_VECTOR (N-1 downto 0);
       cout, v: out STD_LOGIC);
end partA;

architecture partASynth of partA is
  component mux4 is
    generic (N: integer := 16);
    port (d0, d1, d2, d3: in STD_LOGIC_VECTOR(N-1 downto 0);
		      s1, s0: in STD_LOGIC;
		      y: out STD_LOGIC_VECTOR(N-1 downto 0));
	end component;
	
	component adder is
	  generic (N: integer := 16);
	  port (a,b: in std_logic_vector(N-1 downto 0);
          cin: in std_logic;
          s: out std_logic_vector(N-1 downto 0);
          cout, v: out std_logic);
  end component;
  
  signal iB, b_in, s, zs, ones: STD_LOGIC_VECTOR(N-1 downto 0);
  begin
    zs <= (N-1 downto 0 => '0');
    ones <= (N-1 downto 0 => '1');
    iB <= not b;
    muxB: mux4 generic map(N) port map(zs, b, iB, ones, s1, s0, b_in);
    
    -- adder
    adderA: adder generic map(N) port map(a, b_in, cin, s, cout, v);
    -- final output
    F <= zs when (s1 = '1' and s0 = '1' and cin = '1') else s;
  end partASynth;
    
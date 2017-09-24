Library ieee;
Use ieee.std_logic_1164.all;

entity mux4 is 
  generic (N: integer := 16);
	port (d0, d1, d2, d3: in STD_LOGIC_VECTOR(N-1 downto 0);
	      s1, s0: in STD_LOGIC;
			  y: out STD_LOGIC_VECTOR(N-1 downto 0));
end mux4;

-- take care of the usage of when else 
architecture  Data_flow of mux4 is
  begin
     y <=   d0 WHEN s1 = '0' and s0 ='0'
       ELSE d1 WHEN s1 = '0' and s0 ='1'
       ELSE d2 WHEN s1 = '1' and s0 ='0'
	   ELSE d3;
  end Data_flow;

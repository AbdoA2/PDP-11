Library ieee;
Use ieee.STD_LOGIC_1164.all;

entity mux4_1bit  is  
		port (a, b, c, d: in STD_LOGIC;
		      s: in STD_LOGIC_VECTOR(1 downto 0);
		      x: out STD_LOGIC);    
	end entity mux4_1bit;


-- take care of the usage of when else 
architecture  Data_flow of mux4_1bit is
begin
     -- TODO : write the architecture of mux4
    x <= a when s = "00"
    else b when s = "01"
    else c when s = "10"
    else d;
end Data_flow;



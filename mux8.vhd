-- interface 
entity mux8 is
port( a,b,c,d,e,f,g,h : in bit;
           s : in bit_vector (2 downto 0);
           x : out bit);
end mux8;

-- implementation
architecture struct of mux8 is
-- includes 
	component mux4	is	
		port (a, b, c, d ,s0,s1: in bit ; y : out bit);	
	end component;
	-- replace it with your implementation and interface
    component mux2  is  
		port (a, b,s0 : in bit ; x : out bit   );    
	end component ;
-- wires 
    signal  x1,x2 : bit;
	
begin
-- inserting actual modules
-- concurrancy 
	u0: mux4 port map (a,b,c,d,s(0),s(1),x1);
	u1: mux4 port map (e,f,g,h,s(0),s(1),x2);
   -- u2: mux2 port map (x1,x2,s(2),x);
end struct;


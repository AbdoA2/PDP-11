Library ieee;

Use ieee.std_logic_1164.all;

Entity mux_seq is 

port (a,b,c,d : in std_logic;
		s : in std_logic_vector (1 downto 0 );
		x : out std_logic);
		
end mux_seq;

Architecture a_mux_seq of mux_seq is
begin
	process(a,b,c,d,s)
	begin
		if(s = "00") then
			x <= a ;
		elsif (s = "01") then
			x <= b;
		elsif (s = "10") then
			x <= c;	
		else
			x <= d;
		end if;
	
	
	end process;

end a_mux_seq;


Architecture b_mux_seq of mux_seq is
begin
	process(a,b,c,d,s)
	begin
	
	case s is
		when "00" =>
			x <= d ;
		when "01" =>
			x <= c;
		when "10" =>
			x <= b;	
		when Others =>
			x <= a;
		end case;
	
	
	end process;

end b_mux_seq;

 --SIGNAL bus : bit_vector(0 TO 7) := (4=>'1', OTHERS=>'0');  -- default value 
		-- of "bus" is B"0000_1000"
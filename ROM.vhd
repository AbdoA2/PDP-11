library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.NUMERIC_STD_UNSIGNED.ALL;


entity rom is
  generic(N: integer := 32; M: integer := 8);
  port(address: in std_logic_vector(M-1 downto 0);
       dataout: out std_logic_vector(N-1 downto 0));
end rom;
-- control word is src_en(2) dst_en(3) rm we
architecture syncroma of rom is
  type ram_type is array(0 to 2**M - 1) of std_logic_vector(N-1 downto 0);
  signal ram : ram_type; 
  begin
    
    dataout <= ram(to_integer(unsigned(address)));
    
  end architecture syncroma;



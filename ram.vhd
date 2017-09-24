library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.NUMERIC_STD_UNSIGNED.ALL;


entity ram is
  generic(N: integer := 8; M: integer := 6);
  port(clk: in std_logic;
       we: in std_logic;
       address: in std_logic_vector(M-1 downto 0);
       datain: in std_logic_vector(N-1 downto 0);
       dataout: out std_logic_vector(N-1 downto 0));
end ram;

architecture syncrama of ram is
  type ram_type is array(0 to 2**M - 1) of std_logic_vector(N-1 downto 0);
  signal ram : ram_type; 
  
  begin
    
    process(clk) begin
      if rising_edge(clk) then  
        if we = '1' then
          ram(to_integer(unsigned(address))) <= datain;
        end if;
      end if;
    end process;
    dataout <= ram(to_integer(unsigned(address)));
    
  end architecture syncrama;

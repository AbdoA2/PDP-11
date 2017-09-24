library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top is
  port(clk, rst: in STD_LOGIC);
end entity Top;
  
architecture TopArch of Top is
  
  signal data_PDP_to_RAM, data_RAM_to_PDP, addr: STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal write_memory: STD_LOGIC;
  
  begin
    
    PDP: entity work.pdp port map(clk, rst, data_RAM_to_PDP, data_PDP_to_RAM, addr, write_memory);
    RAM0: entity work.RAM generic map(16, 16) port map(clk, write_memory, addr, data_PDP_to_RAM, data_RAM_to_PDP);

end;
library IEEE;
use ieee.std_logic_1164.all;

entity testbench is
   generic(N: integer := 16; M: integer := 2);
end;

architecture test of testbench is
  signal clk, rst: STD_LOGIC;
  begin
   
    process begin
      clk <= '1';
      wait for 100 ps;
      clk <= '0';
      wait for 100 ps;
    end process;
    
    process begin
      rst <= '1';
      wait for 100 ps;
      rst <= '0';
      wait;
    end process;
   
   TOP0: entity work.Top port map(clk, rst);
     
    
  end;

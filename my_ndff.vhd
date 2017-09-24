Library ieee;
Use ieee.std_logic_1164.all;

Entity my_nDFF is
  Generic (N: integer := 16);
  port(clk, rst, en: in std_logic;
       d: in std_logic_vector(N-1 downto 0);
       q: out std_logic_vector(N-1 downto 0));
end my_nDFF;

Architecture a_my_nDFF of my_nDFF is
  begin
    Process (clk, rst, en)
      begin
        if rst = '1' then
          q <= (others=>'0');
        elsif rising_edge(clk) and en = '1' then
          q <= d;
      end if;
    end process;
  end a_my_nDFF;

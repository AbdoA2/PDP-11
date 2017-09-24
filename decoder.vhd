library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity decoder is
  generic(N: integer := 2);
  port(s: in STD_LOGIC_VECTOR(N-1 downto 0);
       y: out STD_LOGIC_VECTOR(2**N - 1 downto 0);
       en: in STD_LOGIC);
end decoder;

architecture decoderSynth of decoder is
  begin
    process(s, en) begin
      y <= (others => '0');
      if en = '1' then
        y(to_integer(s)) <= '1';
      end if;
    end process;
  end decoderSynth;
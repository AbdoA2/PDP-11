Library ieee;
use ieee.std_logic_1164.all;

entity tri_state is
  generic(N: integer := 16);
  port(d: in STD_LOGIC_VECTOR(N-1 downto 0);
       y: out STD_LOGIC_VECTOR(N-1 downto 0);
       en: in STD_LOGIC);
end tri_state;

architecture tri_stateSynth of tri_state is
  begin
    y <= (others => 'Z') when en = '0' else d;
  end tri_stateSynth;
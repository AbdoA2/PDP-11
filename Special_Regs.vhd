Library ieee;
use ieee.std_logic_1164.all;

entity Special_Regs is
  generic(N: integer := 16);
  port(clk, rst: in STD_LOGIC;
       SRC_IN, DST_IN, TMP_IN: in STD_LOGIC;
       SRC_OUT, DST_OUT, TMP_OUT: in STD_LOGIC;
       db: inout STD_LOGIC_VECTOR(N-1 downto 0));
end Special_Regs;

architecture Special_RegsII of Special_Regs is
  
  type RAM_R is array(4 downto 0) of STD_LOGIC_VECTOR(N-1 downto 0);
  signal q: RAM_R;
  signal en_src, en_dst: STD_LOGIC_VECTOR(4 downto 0);
  
  begin
      
    src: entity work.my_nDFF generic map(N) port map(clk, rst, SRC_IN, db, q(2));
    tri2: entity work.tri_state generic map(N) port map(q(2), db, SRC_OUT);
    
    dst: entity work.my_nDFF generic map(N) port map(clk, rst, DST_IN, db, q(3));
    tri3: entity work.tri_state generic map(N) port map(q(3), db, DST_OUT);
      
    tmp: entity work.my_nDFF generic map(N) port map(clk, rst, TMP_IN, db, q(4));
    tri4: entity work.tri_state generic map(N) port map(q(4), db, TMP_OUT);
      
    --src_decoder: entity work.decoder generic map(3) port map(src_reg, en_src, RE);
    --dst_decoder: entity work.decoder generic map(3) port map(dst_reg, en_dst, WE);
    
  end;
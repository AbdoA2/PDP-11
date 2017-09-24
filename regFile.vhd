Library ieee;
use ieee.std_logic_1164.all;

entity regFile is
  generic(N: integer := 16; M: integer := 2);
  port(clk, rst: in STD_LOGIC;
       SS: in STD_LOGIC_VECTOR(M-1 downto 0);
       SD: in STD_LOGIC_VECTOR(M-1 downto 0);
       RE: in STD_LOGIC;
       WE: in STD_LOGIC;
       db: inout STD_LOGIC_VECTOR(N-1 downto 0));
end regFile;

architecture regFileSynth of regFile is
  component decoder is
    generic(N: integer := 2);
    port(s: in STD_LOGIC_VECTOR(N-1 downto 0);
         y: out STD_LOGIC_VECTOR(2**N - 1 downto 0);
         en: in STD_LOGIC);
  end component;
  
  component my_nDFF is
    generic (N: integer := 16);
    port(clk, rst, en: in std_logic;
         d: in std_logic_vector(N-1 downto 0);
         q: out std_logic_vector(N-1 downto 0));
  end component;
  
  component tri_state is
    generic(N: integer := 8);
    port(d: in STD_LOGIC_VECTOR(N-1 downto 0);
         y: out STD_LOGIC_VECTOR(N-1 downto 0);
         en: in STD_LOGIC);
  end component;
  
  type RAM_R is array(2**M - 1 downto 0) of STD_LOGIC_VECTOR(N-1 downto 0);
  signal q: RAM_R;
  signal en_src, en_dst: STD_LOGIC_VECTOR(2**M - 1 downto 0);
  
  begin
    
    -- registers and associated tri state buffers;
    GEN_REG:
    for i in 0 to 2**M - 1 generate
      reg1: my_nDFF generic map(N) port map(clk, rst, en_dst(i), db, q(i));
      tri1: tri_state generic map(N) port map(q(i), db, en_src(i));
    end generate GEN_REG;
    
    -- decoders --
    src_decoder: decoder generic map(M) port map(SS, en_src, RE);
    dst_decoder: decoder generic map(M) port map(SD, en_dst, WE);
      
  end regFileSynth;
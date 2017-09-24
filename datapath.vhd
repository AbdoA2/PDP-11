library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity datapath is
  generic(N: integer := 16; M: integer := 2);
  port(clk, rst: in STD_LOGIC;
       datain: in STD_LOGIC_VECTOR(N-1 downto 0);
       dataout, addr, IRout: out STD_LOGIC_VECTOR(N-1 downto 0);
       -- REGS
       MDR_IN, MAR_IN, IR_IN, Z_IN, Y_IN, REGS_IN: in STD_LOGIC;
       MDR_OUT, Z_OUT, REGS_OUT: in STD_LOGIC;
       -- SPECIAL REGS
       SRC_IN, DST_IN, TMP_IN: in STD_LOGIC;
       SRC_OUT, DST_OUT, TMP_OUT: in STD_LOGIC;
       -- FLAGS
       flagsout: out STD_LOGIC_VECTOR(3 downto 0); -- THE FLAGS Q 
       FLAGS_IN: in STD_LOGIC_VECTOR(3 downto 0); -- Enable of separate bits (FFs)!
       -- REGS
       src_reg, dst_reg: in STD_LOGIC_VECTOR(M-1 downto 0);
       CLR_Y: in STD_LOGIC;
       -- ALU
       aluop: in STD_LOGIC_VECTOR(3 downto 0);
       -- RAM
       read_memory, cin: in STD_LOGIC);
end datapath;

architecture datapathSynth of datapath is
  
  signal databus, MDR_d, MDR_q, YOut, ZOut, ALUOut: STD_LOGIC_VECTOR(N-1 downto 0);
  signal flagsD: STD_LOGIC_VECTOR(3 downto 0);
  signal Y_CLEAR, cout, neg_clk, mdrEn: STD_LOGIC;
  begin
    
    MDR_d <= datain when read_memory = '1' else databus;
    mdrEn <= MDR_IN or read_memory;
    MDR: entity work.my_nDFF generic map(N) port map(clk, rst, mdrEn , MDR_d, MDR_q);
    tri: entity work.tri_state generic map(N) port map(MDR_q, databus, MDR_OUT);
    dataout <= MDR_q;
    
    -- Memory Address register
    neg_clk <= not clk;
    MAR: entity work.my_nDFF generic map(N) port map(neg_clk, rst, MAR_IN, databus, addr);
      
    -- Instruction register
    IR: entity work.my_nDFF generic map(N) port map(clk, rst, IR_IN, databus, IROut);
      
    -- register file
    regs: entity work.regFile generic map(N, M) port map(clk, rst, src_reg, dst_reg, REGS_OUT, REGS_IN, databus);
    
    -- special register array
    special_regs:  entity work.Special_Regs generic map(N) port map(clk, rst, SRC_IN, DST_IN, TMP_IN,
       SRC_OUT, DST_OUT, TMP_OUT, databus);
      
    -- Y register
    Y_CLEAR <= (rst or CLR_Y); -- CLR_Y momken t3mel mshakel fel awel (lw undefined)!
    Y: entity work.my_nDFF generic map(N) port map(clk, Y_CLEAR, Y_IN, databus, YOut);
      
    -- ALU
    ALU: entity work.ALSU generic map(N) port map(YOut, databus, aluop, cin, ALUOut, flagsD(3), flagsD(2), flagsD(1), flagsD(0));
    FLAGS: entity work.flags generic map(4) port map(clk, rst, flagsD, FLAGS_IN, flagsout);
    
    -- Z register
    Z: entity work.my_nDFF generic map(N) port map(clk, rst, Z_IN, ALUOut, ZOut);
    tri1: entity work.tri_state generic map(N) port map(ZOut, databus, Z_OUT);
      
  end datapathSynth;
       

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pdp is 
  generic(N: integer := 16; M: integer := 2);
  port(clk, rst: in STD_LOGIC;
       datain: in STD_LOGIC_VECTOR(N-1 downto 0);
       dataout, addr: out STD_LOGIC_VECTOR(N-1 downto 0);
       write_memory: out STD_LOGIC);
end pdp;

architecture pdpSynth of pdp is
  signal IRout: STD_LOGIC_VECTOR(N-1 downto 0);
  signal src_reg, dst_reg: STD_LOGIC_VECTOR(M-1 downto 0);
  signal control_word: STD_LOGIC_VECTOR(31 downto 0);
  signal rom_addr, next_addr: STD_LOGIC_VECTOR(7 downto 0);
  signal read_memory: STD_LOGIC;
  signal MDR_IN, MAR_IN, IR_IN, Z_IN, Y_IN, REGS_IN: STD_LOGIC;
  signal MDR_OUT, Z_OUT, REGS_OUT: STD_LOGIC;
  signal SRC_IN, DST_IN, TMP_IN: STD_LOGIC;
  signal SRC_OUT, DST_OUT, TMP_OUT: STD_LOGIC;
  signal CARRY_IN, CLR_Y: STD_LOGIC;
  signal flagsout, FLAGS_IN, aluop: STD_LOGIC_VECTOR(3 downto 0);
  begin
   
    -- microprogram counter
    MPC: entity work.my_ndff generic map(8) port map(clk, rst, '1', next_addr, rom_addr);
    
    -- ROM
    ROM0: entity work.ROM generic map(32, 8) port map(rom_addr, control_word);
      
    -- Control Unit
    CONTROL_UNIT0: entity work.control_unit port map(control_word, IRout, flagsout,
        MDR_IN, MAR_IN, IR_IN, Z_IN, Y_IN, REGS_IN,
        MDR_OUT, Z_OUT, REGS_OUT,
        SRC_IN, DST_IN, TMP_IN,
        SRC_OUT, DST_OUT, TMP_OUT,
        src_reg, dst_reg,
        read_memory, write_memory,
        aluop,
        CARRY_IN,
        CLR_Y,
        next_addr);
      
    -- DATAPATH
    DATAPATH0: entity work.datapath generic map(N) port map(clk, rst,
       datain,
       dataout, addr, IRout,
       -- REGS
       MDR_IN, MAR_IN, IR_IN, Z_IN, Y_IN, REGS_IN,
       MDR_OUT, Z_OUT, REGS_OUT,
       -- SPECIAL REGS
       SRC_IN, DST_IN, TMP_IN,
       SRC_OUT, DST_OUT, TMP_OUT,
       -- FLAGS
       flagsout, -- THE FLAGS Q 
       FLAGS_IN, -- Enable of separate bits (FFs)!
       -- REGS
       src_reg, dst_reg,
       CLR_Y,
       -- ALU
       aluop,
       -- RAM
       read_memory, CARRY_IN);
       
  end;
Library ieee;
Use ieee.std_logic_1164.all;

entity my_adder is
  port (a,b,cin: in std_logic;
        s , cout: out std_logic);
end my_adder;

Architecture a_my_adder of my_adder is
  begin 
    process ( a ,b , cin) begin 
      s <= a xor b xor cin;
      cout <= (a and b) or (cin and (a xor b));
    end process;
  end a_my_adder;
  
------- 16 bit adder
Library ieee;
Use ieee.std_logic_1164.all;

entity adder is
  generic (N: integer := 16);
  port (a,b: in std_logic_vector (N-1 downto 0);
        cin: in std_logic;
        s: out std_logic_vector (N-1 downto 0);
        cout, v: out std_logic);
end adder;


Architecture adderSynth of adder is
  component my_adder is
    port (a,b,cin : in std_logic;
          s , cout : out std_logic);
  end component;
  
  signal c: STD_LOGIC_VECTOR (N-1 downto 0);
  begin 
    -- first adder
    a0: my_adder port map(a(0), b(0), cin, s(0), c(0));
    -- remaining adders
    GEN_ADDER:
    for i in 1 to N-1 generate
      a1: my_adder port map(a(i), b(i), c(i-1), s(i), c(i));
    end generate GEN_ADDER; 
    cout <= c(N-1);
    v <= c(N-1) xor c(N-2);
    
end adderSynth;
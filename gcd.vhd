LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;

entity GCD is
  port(
    clk, reset, start : in std_logic;
    Ain, Bin: in std_logic_vector(7 downto 0);
    GCDout: out std_logic_vector(7 downto 0);
    done: out std_logic
  );
end GCD;

architecture BEHAV of GCD is
  component CONTROLLER
    port (
      start, reset, clk : in STD_LOGIC;
      AeqB, AltB : in STD_LOGIC;
      selA, selB, loadA, loadB, loadGCD, done : out STD_LOGIC;
    );
  end component;

  component DATAPATH
    port (
      reset, clk, selA, selB, loadA, loadB, loadGCD : in STD_LOGIC;
      AeqB, AltB : out STD_LOGIC;
      Ain : in STD_LOGIC_VECTOR(7 DOWNTO 0);
      Bin : in STD_LOGIC_VECTOR(7 DOWNTO 0);
      GCD : out STD_LOGIC_VECTOR(7 DOWNTO 0);
    );
  end component;

  signal equal, lessthan, sa, sb, la, lb, loadgcd: STD_LOGIC;

  begin
    datapath : DATAPATH port map (reset, clk, sa, sb, la, lb, loadgcd, Ain, Bin, GDCOut);
    controller : CONTROLLER port map(start, reset, clk, equal, lessthan, sa, sb, la, lb, loadgcd, done);
end BEHAV;
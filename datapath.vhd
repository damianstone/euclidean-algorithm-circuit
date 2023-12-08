LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;


entity DATAPATH is
    port (
        reset, clk, selA, selB, loadA, loadB, loadGCD : in STD_LOGIC;
        AeqB, AltB : out STD_LOGIC;
        Ain : in STD_LOGIC_VECTOR(7 DOWNTO 0);
        Bin : in STD_LOGIC_VECTOR(7 DOWNTO 0);
        GCD : out STD_LOGIC_VECTOR(7 DOWNTO 0));
end DATAPATH;

architecture BEHAV of DATAPATH is
    --------------------- IMPORTING COMPONENTS -----------------------
    component MUX
        port (
            Sel : in STD_LOGIC;
            A, B : in STD_LOGIC_VECTOR(7 DOWNTO 0);
            C : out STD_LOGIC_VECTOR(7 DOWNTO 0));
    end component;

    component REG
        port (
            clk, load, reset : in STD_LOGIC;
            I : in STD_LOGIC_VECTOR(7 DOWNTO 0);
            O : out STD_LOGIC_VECTOR(7 DOWNTO 0));
    end component;

    component COMPARATOR
        port (
            A, B : in STD_LOGIC_VECTOR(7 DOWNTO 0);
            AequalB, AlessB : out STD_LOGIC);
    end component;

    component SUB
        port (
            A, B : in STD_LOGIC_VECTOR(7 downto 0);
            Y : out STD_LOGIC_VECTOR(7 downto 0));
    end component;

    --------------------- INTERNAL SIGNALS ----------------------- 
    -- internal signals for each arrow (output of component) from the diagram
    signal m1, m2, r1, r2, s1, s2 : STD_LOGIC_VECTOR(7 downto 0);

begin
    mux1 : MUX PORT MAP(selA, sub1, Ain, m1);
    mux2 : MUX PORT MAP(selB, sub2, Bin, m2);

    reg1 : REG PORT MAP(clk, loadA, reset, m1, r1);
    reg2 : REG PORT MAP(clk, loadB, reset, m2, r2);

    sub1 : SUB PORT MAP(r1, r2, sub1);
    sub2 : SUB PORT MAP(r2, r1, sub2);

    compare : comparator PORT MAP(r2, r1, AltB, AeqB);

    -- tristate buffer logic
    GDC <= r1 when (loadGCD == '1') else (others => 'z')

end BEHAV;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROLLER is 
  port (
    start, reset, clk : in STD_LOGIC;
    AeqB, AltB : in STD_LOGIC;
    selA, selB, loadA, loadB, loadGCD, done : out STD_LOGIC;
  )
end CONTROLLER;

architecture BEHAV of CONTROLLER is

  component DATAPATH 
    port (
      reset, clk, selA, selB, loadA, loadB, loadGCD : in STD_LOGIC;
      AeqB, AltB : out STD_LOGIC;
      Ain : in STD_LOGIC_VECTOR(7 DOWNTO 0);
      Bin : in STD_LOGIC_VECTOR(7 DOWNTO 0);
      GCD : out STD_LOGIC_VECTOR(7 DOWNTO 0));
  end component;

  type state_type is (INIT, LOAD_DATA, COMPARE, UPDATE_A, UPDATE_B, DONE);

  signal current_state, next_state : state_type := INIT;

  process(reset, clk)
  begin
    if reset = '1' then
      curren_state <= INIT
    elsif rising_edge(clk) then
      current_state <= next_state  
    end if; 
  end process;

  process(current_state, start, AeqB, AltB)
  begin
    loadA <= '0'; loadB <= '0'; loadgcd <= '0';
    selA <= '0'; selB <= '0'; ready <= '0';

    case current_state is
      when INIT => 
        if start = '1' then 
          next_state <= LOAD_DATA
        else
          next_state <= INIT
        end if;
      
      when LOAD_DATA => 
        loadA, loadB, selA, selB <= '1'
        loadGCD, done <= '0'
        next_state <= COMPARE
      
      when COMPARE => 
        loadA, loadB <= '0'
        loadGCD, done <= '0'

        if AeqB = '1' then
          next_state <= DONE
        elsif AltB = '0' then
          next_state <= UPDATE_B
        else  
          next_state <= UPDATE_A
        end if;
      
      when UPDATE_A => 
          loadA <= '1'
          selA <= '0'
          next_state <= COMPARE

      when UPDATE_B =>
          loadB <= '1'
          selB <= '0'
          next_state <= COMPARE
      
      when DONE => 
          loadGCD <= '1'
          done <= '1'
          next_state <= INIT
      
      end case;
  end process;  
end BEHAV;
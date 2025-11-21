----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2025 12:52:30 PM
-- Design Name: 
-- Module Name: debounce - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce is
  Port ( 
  btn,clk: in std_logic;
  dbnc: out std_logic 
  );
end debounce;

architecture Behavioral of debounce is
    signal counter: std_logic_vector(21 downto 0) := (others => '0');
    signal shiftreg: std_logic_vector(1 downto 0):=(others => '0');

begin

process(clK)
    begin 
        if rising_edge(clk) then
          shiftreg(1) <= shiftreg(0);
          shiftreg(0) <= btn;
             if unsigned(counter) > 2499999 and shiftreg(1) = '1' then
                dbnc <='1';
              elsif shiftreg(1) = '1' then 
                counter <= std_logic_vector(unsigned(counter) + 1);
              else
                counter <= (others => '0');
                dbnc <= '0';
              end if;
         end if;
    end process;

end Behavioral;

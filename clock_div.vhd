----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2025 12:22:04 PM
-- Design Name: 
-- Module Name: clock_div - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 125,000,000Hz to 115,200Hz clock pulse. Clock pulse of length of 1 clock in 125MHz clock.
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

entity clock_div is
  Port ( 
  clk: in std_logic;
  div: out std_logic 
  );
end clock_div;

architecture Behavioral of clock_div is
    signal counter : std_logic_vector(10 downto 0) := (others => '0');
   
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (unsigned(counter) < 1084) then
                counter <= std_logic_vector(unsigned(counter) + 1);
                div <= '0';
            else
                div <= '1';
                counter <= (others => '0');
            end if;
        end if;
    
    end process;

end Behavioral;

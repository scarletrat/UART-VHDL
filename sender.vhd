----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2025 11:02:37 PM
-- Design Name: 
-- Module Name: sender - Behavioral
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

entity sender is
  Port ( 
  clk,rst,clk_en,btn,ready: in std_logic;
  send: out std_logic;
  char: out std_logic_vector(7 downto 0)
  );
end sender;

architecture Behavioral of sender is
type state is(idle,busyA,busyB,busyC);
signal curr: state := idle;
type netid is array (0 to 4) of std_logic_vector(7 downto 0);
constant my_netid: netid := (
    x"47", x"4C", x"35", x"34", x"38"
);
constant n: natural := 5;
signal output: std_logic_vector(7 downto 0);
signal counter: natural range 0 to 9 := 0;
begin

process(clk)
begin
    if rising_edge(clk) then
        if clk_en = '1' then
            if rst = '1' then
                counter <=  0;
                output <= (others => '0');
                curr <= idle;
            else 
                case curr is
                    when idle =>
                        if (ready = '1') and (btn = '1') and (counter < n) then
                            send <= '1';
                            counter <= counter + 1;
                            output <= my_netid((counter));
                            curr <= busyA;
                        elsif(ready = '1') and (btn='1') and (counter = 5) then
                            counter <= 0;
                            curr <= idle;
                        else
                            curr <= idle;
                        end if;
                    when busyA =>
                        curr <= busyB;
                        char <= output;
                    when busyB =>
                        send <= '0';
                        curr <= busyC;
                    when busyC =>
                        if (ready = '1') and (btn = '0') then
                            curr <= idle;
                        else
                            curr <= busyC;
                        end if;
                end case;
            end if;
        end if;
    
    end if;
end process;

end Behavioral;

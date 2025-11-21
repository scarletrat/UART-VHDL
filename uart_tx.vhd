----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2025 10:29:46 AM
-- Design Name: 
-- Module Name: uart_tx - Behavioral
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

entity uart_tx is
  Port ( 
  clk, en, send, rst: in std_logic;
  char: in std_logic_vector(7 downto 0);
  ready, tx: out std_logic 
  );
end uart_tx;

architecture fsm of uart_tx is
type state is(idle,start,transmit);
signal current: state := idle;
signal msg: std_logic_vector(7 downto 0):= (others => '0');
signal count: natural range 0 to 8;
begin

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        msg <= (others => '0');
        count <=0;
        tx <= '1';
        ready <= '1';
        current <= idle;
      else
        case current is 
          when idle =>
            if en = '1' then
                ready <= '1';
                tx <= '1';
                if send = '1' then
                    current <= start;
                end if;
            end if;
          when start =>
            ready <= '0';
            msg <= char;
            tx <= '0';
            count <=0;
            current <= transmit;
            
          when transmit =>
            if en = '1' then
                if (count) < 8 then
                    tx <= msg(count);
                    count <= count + 1;
                else
                    tx <= '1';
                    current <= idle;
                end if;
            end if;
          when others =>
            current <= idle;
        end case;
      end if;
    end if;
  end process;


end fsm;

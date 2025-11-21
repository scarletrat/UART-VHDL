----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2025 08:05:10 PM
-- Design Name: 
-- Module Name: top_level - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
  Port ( 
  TXD,clk: in std_logic;
  btn: in std_logic_vector(1 downto 0);
  RXD,CTS,RTS: out std_logic 
  );
end top_level;

architecture Behavioral of top_level is

signal dbnce1,dbnce2,div,send,ready,tx: std_logic;
signal char: std_logic_vector(7 downto 0);

component uart is
    Port (
    clk, en, send, rx, rst      : in std_logic;
    charSend                    : in std_logic_vector (7 downto 0);
    ready, tx, newChar          : out std_logic;
    charRec                     : out std_logic_vector (7 downto 0)

    );
end component;

component clock_div is
    Port ( 
    clk: in std_logic;
    div: out std_logic 
    );
end component;

component debounce is
    Port(
    btn,clk: in std_logic;
    dbnc: out std_logic 
    );
end component;

component sender is
    Port ( 
    clk,rst,clk_en,btn,ready: in std_logic;
    send: out std_logic;
    char: out std_logic_vector(7 downto 0)
    );
end component;

begin

u1: debounce port map(btn(0),clk,dbnce1);
u2: debounce port map(btn(1),clk,dbnce2);
u3: clock_div port map(clk,div);
u4: sender port map(
        btn => dbnce2,
        clk => clk,
        clk_en => div,
        rst => dbnce1,
        ready => ready,
        send => send,
        char => char);
                    
                    
u5: uart port map(  clk =>clk, 
                    en=>div, 
                    send =>send, 
                    rx=>TXD, 
                    rst=>dbnce1, 
                    charSend=>char, 
                    ready =>ready, 
                    tx=>tx);
                   RXD <= tx;
CTS <= '0';
RTS <= '0';

end Behavioral;

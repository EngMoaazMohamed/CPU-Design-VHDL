library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc is
Port (
clk : in STD_LOGIC;
reset : in STD_LOGIC;
halt : in STD_LOGIC;
pc_out : out STD_LOGIC_VECTOR(7 downto 0)
);
end pc;

architecture Behavioral of pc is

signal pc_reg : unsigned(7 downto 0) := (others => '0');

begin

process(clk, reset)
begin
if reset = '1' then
pc_reg <= (others => '0');

elsif rising_edge(clk) then
if halt = '0' then
pc_reg <= pc_reg + 1;
end if;
end if;
end process;

pc_out <= std_logic_vector(pc_reg);

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity accumulator is
Port (
clk : in STD_LOGIC;
reset : in STD_LOGIC;
load : in STD_LOGIC;
data_in : in STD_LOGIC_VECTOR(7 downto 0);
data_out : out STD_LOGIC_VECTOR(7 downto 0)
);
end accumulator;

architecture Behavioral of accumulator is

signal acc_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin

process(clk, reset)
begin

if reset = '1' then
acc_reg <= (others => '0');

elsif rising_edge(clk) then

if load = '1' then
acc_reg <= data_in;
end if;

end if;

end process;

data_out <= acc_reg;

end Behavioral;
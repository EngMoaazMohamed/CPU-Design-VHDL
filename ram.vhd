library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram is
Port (
clk : in STD_LOGIC;
we : in STD_LOGIC;
addr : in STD_LOGIC_VECTOR(4 downto 0);
data_in : in STD_LOGIC_VECTOR(7 downto 0);
data_out : out STD_LOGIC_VECTOR(7 downto 0)
);
end ram;

architecture Behavioral of ram is

type ram_type is array (0 to 31) of STD_LOGIC_VECTOR(7 downto 0);
signal memory : ram_type := (others => (others => '0'));

begin

process(clk)
begin
if rising_edge(clk) then
if we = '1' then
memory(to_integer(unsigned(addr))) <= data_in;
end if;
end if;
end process;

data_out <= memory(to_integer(unsigned(addr)));

end Behavioral;
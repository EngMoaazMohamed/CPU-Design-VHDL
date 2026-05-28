library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_cpu is
end tb_cpu;

architecture Behavioral of tb_cpu is

component cpu_top
Port (
clk : in STD_LOGIC;
reset : in STD_LOGIC
);
end component;

signal clk : STD_LOGIC := '0';
signal reset : STD_LOGIC := '1';

begin

UUT: cpu_top
port map (
clk => clk,
reset => reset
);

-- Clock: 10 ns period
clk_process: process
begin
while true loop
clk <= '0';
wait for 5 ns;
clk <= '1';
wait for 5 ns;
end loop;
end process;

-- Reset then run CPU
stim_process: process
begin
reset <= '1';
wait for 20 ns;

reset <= '0';
wait for 100 ns;

wait;
end process;

end Behavioral;
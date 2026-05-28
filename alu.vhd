library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
Port (
a : in STD_LOGIC_VECTOR(7 downto 0);
b : in STD_LOGIC_VECTOR(7 downto 0);
alu_op : in STD_LOGIC_VECTOR(2 downto 0);
result : out STD_LOGIC_VECTOR(7 downto 0)
);
end alu;

architecture Behavioral of alu is
begin

process(a, b, alu_op)
begin
case alu_op is
when "001" =>
result <= b; -- PASS, used for LOAD

when "010" =>
result <= std_logic_vector(unsigned(a) + unsigned(b)); -- ADD

when "011" =>
result <= std_logic_vector(unsigned(a) - unsigned(b)); -- SUB

when "100" =>
result <= a and b; -- AND

when "101" =>
result <= a or b; -- OR

when others =>
result <= "00000000";
end case;
end process;

end Behavioral;
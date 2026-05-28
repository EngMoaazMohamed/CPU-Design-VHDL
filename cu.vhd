library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cu is
Port (
opcode : in STD_LOGIC_VECTOR(2 downto 0);
alu_op : out STD_LOGIC_VECTOR(2 downto 0);
acc_load : out STD_LOGIC;
mem_we : out STD_LOGIC;
halt : out STD_LOGIC
);
end cu;

architecture Behavioral of cu is
begin

process(opcode)
begin
-- default values
alu_op <= "000";
acc_load <= '0';
mem_we <= '0';
halt <= '0';

case opcode is
when "000" => -- NOP
alu_op <= "000";
acc_load <= '0';
mem_we <= '0';
halt <= '0';

when "001" => -- LOAD
alu_op <= "001"; -- PASS operand
acc_load <= '1';

when "010" => -- ADD
alu_op <= "010";
acc_load <= '1';

when "011" => -- SUB
alu_op <= "011";
acc_load <= '1';

when "100" => -- AND
alu_op <= "100";
acc_load <= '1';

when "101" => -- OR
alu_op <= "101";
acc_load <= '1';

when "110" => -- STORE
mem_we <= '1';

when "111" => -- HLT
halt <= '1';

when others =>
alu_op <= "000";
acc_load <= '0';
mem_we <= '0';
halt <= '0';
end case;
end process;

end Behavioral;
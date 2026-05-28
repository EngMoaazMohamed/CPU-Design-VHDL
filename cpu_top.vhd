library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpu_top is
Port (
clk : in STD_LOGIC;
reset : in STD_LOGIC
);
end cpu_top;

architecture Behavioral of cpu_top is

component pc
Port (
clk : in STD_LOGIC;
reset : in STD_LOGIC;
halt : in STD_LOGIC;
pc_out : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component cu
Port (
opcode : in STD_LOGIC_VECTOR(2 downto 0);
alu_op : out STD_LOGIC_VECTOR(2 downto 0);
acc_load : out STD_LOGIC;
mem_we : out STD_LOGIC;
halt : out STD_LOGIC
);
end component;

component alu
Port (
a : in STD_LOGIC_VECTOR(7 downto 0);
b : in STD_LOGIC_VECTOR(7 downto 0);
alu_op : in STD_LOGIC_VECTOR(2 downto 0);
result : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component accumulator
Port (
clk : in STD_LOGIC;
reset : in STD_LOGIC;
load : in STD_LOGIC;
data_in : in STD_LOGIC_VECTOR(7 downto 0);
data_out : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component ram
Port (
clk : in STD_LOGIC;
we : in STD_LOGIC;
addr : in STD_LOGIC_VECTOR(4 downto 0);
data_in : in STD_LOGIC_VECTOR(7 downto 0);
data_out : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

type prog_mem is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);

constant program : prog_mem := (
0 => "00100101", -- LOAD 5
1 => "01000011", -- ADD 3
2 => "01100010", -- SUB 2
3 => "11000001", -- STORE 1
4 => "11100000", -- HLT
others => (others => '0')
);

signal pc_out : STD_LOGIC_VECTOR(7 downto 0);
signal instr : STD_LOGIC_VECTOR(7 downto 0);
signal opcode : STD_LOGIC_VECTOR(2 downto 0);
signal operand : STD_LOGIC_VECTOR(4 downto 0);
signal operand8 : STD_LOGIC_VECTOR(7 downto 0);

signal alu_op : STD_LOGIC_VECTOR(2 downto 0);
signal acc_load : STD_LOGIC;
signal mem_we : STD_LOGIC;
signal halt : STD_LOGIC;

signal alu_result : STD_LOGIC_VECTOR(7 downto 0);
signal acc_out : STD_LOGIC_VECTOR(7 downto 0);
signal ram_out : STD_LOGIC_VECTOR(7 downto 0);

begin

instr <= program(to_integer(unsigned(pc_out)));
opcode <= instr(7 downto 5);
operand <= instr(4 downto 0);
operand8 <= "000" & operand;

U_PC: pc
port map (
clk => clk,
reset => reset,
halt => halt,
pc_out => pc_out
);

U_CU: cu
port map (
opcode => opcode,
alu_op => alu_op,
acc_load => acc_load,
mem_we => mem_we,
halt => halt
);

U_ALU: alu
port map (
a => acc_out,
b => operand8,
alu_op => alu_op,
result => alu_result
);

U_ACC: accumulator
port map (
clk => clk,
reset => reset,
load => acc_load,
data_in => alu_result,
data_out => acc_out
);

U_RAM: ram
port map (
clk => clk,
we => mem_we,
addr => operand,
data_in => acc_out,
data_out => ram_out
);

end Behavioral;
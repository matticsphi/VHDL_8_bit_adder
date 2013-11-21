----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:36:34 01/03/2011 
-- Design Name: 
-- Module Name:    8bitAdder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EightBitAdder is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           Ci : in  STD_LOGIC; -- carry in
			  CLK : in STD_LOGIC; -- clock
           S : out  STD_LOGIC_VECTOR (7 downto 0); -- sum of A and B
           Co : out  STD_LOGIC; -- carry out
			  Y : out STD_LOGIC_VECTOR (8 downto 0)); -- latch output
end EightBitAdder;

architecture Behavioral of EightBitAdder is

-- 1 bit full adder component of the 8 bit adder
component FullAdder
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Ci : in  STD_LOGIC;
           S : out  STD_LOGIC;
           Co : out  STD_LOGIC);
end component;

-- internal signals
signal carry : STD_LOGIC_VECTOR (7 downto 0);
signal sum : STD_LOGIC_VECTOR (7 downto 0);


begin

-- Full Adder prt mapping least significant bit to most significant bit
U1: FullAdder port map(A(0), B(0), Ci, sum(0), carry(0));
U2: FullAdder port map(A(1), B(1), carry(0), sum(1), carry(1));
U3: FullAdder port map(A(2), B(2), carry(1), sum(2), carry(2));
U4: FullAdder port map(A(3), B(3), carry(2), sum(3), carry(3));
U5: FullAdder port map(A(4), B(4), carry(3), sum(4), carry(4));
U6: FullAdder port map(A(5), B(5), carry(4), sum(5), carry(5));
U7: FullAdder port map(A(6), B(6), carry(5), sum(6), carry(6));
U8: FullAdder port map(A(7), B(7), carry(6), sum(7), carry(7));

Co <= carry(7);
S <= sum;

-- latch output
process (CLK)
begin
	IF (rising_edge(CLK)) THEN
		   Y <= carry(7) & sum;
	END IF;
END PROCESS;

end Behavioral;


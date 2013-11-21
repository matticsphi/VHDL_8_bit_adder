
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:37:51 01/05/2011
-- Design Name:   EightBitAdder
-- Module Name:   C:/Documents and Settings/sturm121/Desktop/8bitadder/EightBitAdder_tb.vhd
-- Project Name:  8bitAdder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EightBitAdder
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY EightBitAdder_tb_vhd IS
END EightBitAdder_tb_vhd;

ARCHITECTURE behavior OF EightBitAdder_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT EightBitAdder
	PORT(
		A : IN std_logic_vector(7 downto 0);
		B : IN std_logic_vector(7 downto 0);
		Ci : IN std_logic;
		CLK : IN std_logic;          
		S : OUT std_logic_vector(7 downto 0);
		Co : OUT std_logic;
		Y : OUT std_logic_vector(8 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL Ci_tb :  std_logic := '0';
	SIGNAL CLK_tb :  std_logic := '0';
	SIGNAL A_tb :  std_logic_vector(7 downto 0) := "00000000";
	SIGNAL B_tb :  std_logic_vector(7 downto 0) := "00000000";

	--Outputs
	SIGNAL S_tb :  std_logic_vector(7 downto 0);
	SIGNAL Co_tb :  std_logic;
	SIGNAL Y_tb :  std_logic_vector(8 downto 0);
	
	--Expected Values
	signal Y_exp : std_logic_vector(8 downto 0) := "000000000";
	
	--Clock period definitions
	constant clk_period : time := 40ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: EightBitAdder PORT MAP(
		A => A_tb,
		B => B_tb,
		Ci => Ci_tb,
		CLK => CLK_tb,
		S => S_tb,
		Co => Co_tb,
		Y => Y_tb
	);

	-- Test cases
	A_tb <= "11111111" after 80ns, 
	        "00000000" after 120ns,
			  "11111111" after 160ns,
			  "10101010" after 200ns,
			  "11110000" after 240ns;
			  
	B_tb <= "00000001" after 80ns,
	        "00000000" after 120ns,
			  "11111111" after 160ns,
			  "01010101" after 200ns,
			  "00001111" after 240ns;
			  
	Ci_tb <= '0' after 80ns,
	         '1' after 120ns,
				'0' after 240ns;
	
	Y_exp <= "000000000" after 20ns,
	         "100000000" after 100ns,
				"000000001" after 140ns,
				"111111111" after 180ns,
				"100000000" after 220ns,
				"011111111" after 260ns;
	
	-- clock cycle 20ns up and 20ns down
	clk_process :process
	begin
		CLK_tb <= '0';
		wait for clk_period/2;
		CLK_tb <= '1';
		wait for clk_period/2;
	end process;

	tb : PROCESS
	BEGIN

		-- Wait 40 ns for global reset to finish
		wait for 40 ns;

		-- test for errors
		assert (Y_tb = Y_exp)
		 report "Mismatch at t=" & time'image(now) &
		  " Y_tb=" & integer'image(conv_integer(Y_tb)) &
		  " Y_exp=" & integer'image(conv_integer(Y_exp))
		  severity failure;
		  
		 -- no errors found 
		 assert false
		  report "No error found (t=" & time'image(now) & ")"
		  severity note;
		  
	END PROCESS;

END;

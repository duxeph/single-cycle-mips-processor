----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:23:54 04/25/2024 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit is
   port(
      -- control_out ~ opcode
      signal opcode: in std_logic_vector(5 downto 0);
      -- alu_out ~ funct -- only for jump register (=jr $smt) instruction
      signal funct: in std_logic_vector(5 downto 0);
      signal RegDst, ExtOp, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, BranchNE, Jump, JPLink, JPReg: out std_logic;
      signal ALUOp: out std_logic_vector(2 downto 0)
   );
end control_unit;

architecture Behavioral of control_unit is

begin
   process(opcode)
   begin
      RegDst <= '0';
      ALUSrc <= '0';
      MemtoReg <= '0';
      RegWrite <= '0';
      MemRead <= '0';
      MemWrite <= '0';
      Branch <= '0';
      BranchNE <= '0';
      Jump <= '0';
      JPLink <= '0';
      JPReg <= '0';
      ExtOp <= '0';
      ALUOp <= "000";
      case opcode is
         when "000000" =>  -- r-format
            if(funct="001000") then  -- jr (jump register)
               JPReg <= '1';
            else                       -- ordinary r-type instructions
               RegDst <= '1';
               RegWrite <= '1';
               ALUOp <= "111";
            end if;
         when "011100" =>  -- mul
            RegDst <= '1';
            RegWrite <= '1';
            ALUOp <= "011";
         when "100011" =>  -- load word
            ALUSrc <= '1';
            MemtoReg <= '1';
            RegWrite <= '1';
            MemRead <= '1';
         when "101011" =>  -- store word
            ALUSrc <= '1';
            MemWrite <= '1';
         when "001000" =>  -- add immediate
            ALUSrc <= '1';
            RegWrite <= '1';
         when "001101" =>  -- or immediate
            ALUSrc <= '1';
            RegWrite <= '1';
            ALUOp <= "100";
            ExtOp <= '1';
         when "001110" =>  -- xor immediate
            ALUSrc <= '1';
            RegWrite <= '1';
            ALUOp <= "101";
            ExtOp <= '1';
         when "001010" =>  -- set on less than immediate
            ALUSrc <= '1';
            RegWrite <= '1';
            ALUOp <= "010";
         when "000011" =>  -- jump and link
            RegWrite <= '1';
            Jump <= '1';
            JPLink <= '1';
         when "000100" =>  -- branch eq
            Branch <= '1';
            ALUOp <= "001";
         when "000101" =>  -- branch ne
            BranchNE <= '1';
            ALUOp <= "001";
         when "000010" =>  -- jump
            Jump <= '1';
         -- when 16#6# =>
         --    JumpRst <= '1';
         when others => null;
      end case;
   end process;

end Behavioral;


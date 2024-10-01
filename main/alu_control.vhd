----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:02:04 04/24/2024 
-- Design Name: 
-- Module Name:    alu_control - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_control is
   port(
      signal aluop: in std_logic_vector(2 downto 0);
      signal funct: in std_logic_vector(5 downto 0);
      signal opcode: out std_logic_vector(3 downto 0)
   );
end alu_control;

architecture Behavioral of alu_control is

begin
   process(aluop, funct)
   begin
      case aluop is
         when "000" => opcode <= "0001";        -- add
         when "001" => opcode <= "0010";        -- sub
         when "010" => opcode <= "1101";        -- slt
         when "011" => opcode <= "0011";        -- mul
         when "100" => opcode <= "0110";        -- or
         when "101" => opcode <= "1000";        -- xor
         when "111" =>
            case funct is  -- to_integer(unsigned(funct))
               when "100000" => opcode <= "0001"; -- add    -- 16#20#
               when "100010" => opcode <= "0010"; -- sub    -- 16#22#
            -- when "011000" => opcode <= "0011"; -- mult   -- 16#18#
               when "011010" => opcode <= "0100"; -- div    -- 16#1a#
               when "100100" => opcode <= "0101"; -- and    -- 16#24#
               when "100101" => opcode <= "0110"; -- or     -- 16#25#
               when "100111" => opcode <= "0111"; -- nor    -- 16#27#
               when "100110" => opcode <= "1000"; -- xor    -- 16#26#
               when "000000" => opcode <= "1001"; -- sll    -- 16#00#
               when "000010" => opcode <= "1010"; -- srl    -- 16#02#
               when "000100" => opcode <= "1011"; -- rol    -- 16#04#
               when "000110" => opcode <= "1100"; -- ror    -- 16#06#
               when "101010" => opcode <= "1101"; -- slt    -- 16#2a#
               when others => null;
            end case;
         when others => null;
      end case;
   end process;
   
end Behavioral;


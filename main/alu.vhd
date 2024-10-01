----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:53:02 04/24/2024 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

entity alu is
   port(
      -- opcode ~ alucontrol
      signal alucontrol: in std_logic_vector(3 downto 0);
      signal shamt: in std_logic_vector(4 downto 0);
      -- in1 ~ a, in2 ~ b
      signal a, b: in std_logic_vector(31 downto 0);
      signal zero: out std_logic;
      -- result ~ out1
      signal result: out std_logic_vector(31 downto 0);
      signal re, lo, hi: out std_logic_vector(31 downto 0)
   );
end alu;

architecture Behavioral of alu is
   signal temp: signed(31 downto 0);
   -- signal temp_mult: signed(63 downto 0);
   -- signal temp_quot, temp_rem: signed(31 downto 0);
begin
   process(alucontrol, shamt, a, b)
      variable temp_mult: signed(63 downto 0);
      variable temp_quot, temp_rem: signed(31 downto 0);
   begin
      case alucontrol is
         when "0001" => temp <= signed(a) + signed(b);
         when "0010" => temp <= signed(a) - signed(b);
         when "0011" =>
            temp_mult := signed(a) * signed(b);
            hi <= std_logic_vector(temp_mult(63 downto 32));   -- higher 32 bits
            lo <= std_logic_vector(temp_mult(31 downto 0));    -- lower 32 bits
            temp <= temp_mult(31 downto 0);
         when "0100" =>
            temp_quot := signed(a) / signed(b);
            temp_rem := signed(a) rem signed(b);
            hi <= std_logic_vector(temp_rem);   -- remainder
            lo <= std_logic_vector(temp_quot);  -- quotient
            temp <= temp_quot;
         when "0101" => temp <= signed(a and b);
         when "0110" => temp <= signed(a or b);
         when "0111" => temp <= signed(a nor b);
         when "1000" => temp <= signed(a xor b);
         when "1001" => temp <= signed(a) sll to_integer(signed(shamt));
         when "1010" => temp <= signed(a) srl to_integer(signed(shamt));
         when "1011" => temp <= signed(a) rol to_integer(signed(shamt));
         when "1100" => temp <= signed(a) ror to_integer(signed(shamt));
         when "1101" =>
            if(signed(a)<signed(b)) then
               temp <= (0=>'1', others=>'0');
            else
               temp <= (others=>'0');
            end if;
         when others => null;
      end case;
   end process;
   zero <= '1' when to_integer(temp)=0 else '0';
   result <= std_logic_vector(temp);

end Behavioral;


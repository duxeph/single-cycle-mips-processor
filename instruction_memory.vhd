----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:04:18 04/24/2024 
-- Design Name: 
-- Module Name:    instruction_memory - Behavioral 
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

entity instruction_memory is
   port(
      signal clk: in std_logic;
      -- write_en ~ we?
      signal we: in std_logic;
      -- address ~ a
      signal a: in std_logic_vector(31 downto 0); -- may also be changed to 6 bits
      -- instruction_in ~ wd?
      signal wd: in std_logic_vector(31 downto 0);
      -- instruction_out ~ rd
      signal rd: out std_logic_vector(31 downto 0)
   );
end instruction_memory;

architecture Behavioral of instruction_memory is
   -- 64 x 4B of mem ~ 256B of memory
   type ROM is array(0 to 255) of std_logic_vector(7 downto 0);
   signal instruction_memory: ROM;
   
   signal temp: std_logic_vector(31 downto 0);
begin
   process(clk, we, a, wd)
   begin
      -- NOTE
      -- either is "triggered with falling_edge - synchronous with falling edge"
      -- or works as "combinational - asynchronous"
      if(we='1') then
      -- NOTE
      -- a general data memory has a structure that address goes "higher"
      --                            as "newer variables saved in below levels"
      -- in little endian structure, lsb is saved into lower address values which means
      --                            lsb saved before the msb
      -- in big endian structure, msb is saved into lower address values which means
      --                            msb saved before the lsb
      -- in that manner of perspective, since MIPS has a structure of big endian,
      --           we save msb first, then lower significant bits into the rest, respectively :)
         instruction_memory(to_integer(unsigned(a))) <= wd(31 downto 24); -- MSB FIRST
         instruction_memory(to_integer(unsigned(a))+1) <= wd(23 downto 16);
         instruction_memory(to_integer(unsigned(a))+2) <= wd(15 downto 8);
         instruction_memory(to_integer(unsigned(a))+3) <= wd(7 downto 0); -- LSB LAST
         temp <= (others=>'U');
      else
      -- respectively,
      -- WE LOAD "MSB" FIRSTLY, THEN THE REST "TILL THE LSB" "AS THE ADDRESS WE LOOK INCREASES"
         temp(31 downto 24) <= instruction_memory(to_integer(unsigned(a))); -- MSB FIRST
         temp(23 downto 16) <= instruction_memory(to_integer(unsigned(a))+1);
         temp(15 downto 8) <= instruction_memory(to_integer(unsigned(a))+2);
         temp(7 downto 0) <= instruction_memory(to_integer(unsigned(a))+3); -- LSB LAST
      end if;
   end process;
   rd <= temp;

end Behavioral;


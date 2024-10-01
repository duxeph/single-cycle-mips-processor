----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:14:42 04/29/2024 
-- Design Name: 
-- Module Name:    extender - Behavioral 
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

entity extender is
   port(
      signal input: in std_logic_vector(15 downto 0);
      signal ExtOp: in std_logic;
      signal output: out std_logic_vector(31 downto 0)
   );
end extender;

architecture Behavioral of extender is
   signal temp: std_logic_vector(15 downto 0) := (others=>'0');

begin
   process(input)
   begin
--      if(input(15)='1') then
--         temp <= (others=>'1');
--         output <= temp&input;
--      else
--         temp <= (others=>'0');
--         output <= temp&input;
--      end if;
      if(ExtOp='0') then
         output <= std_logic_vector(resize(signed(input), 32));
      else
         output <= std_logic_vector(resize(unsigned(input), 32));
      end if;
   end process;

end Behavioral;

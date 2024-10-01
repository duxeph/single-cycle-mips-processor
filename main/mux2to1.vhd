----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:47:43 04/25/2024 
-- Design Name: 
-- Module Name:    mux2to1 - Behavioral 
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

entity mux2to1 is
   generic(n: integer);
   port(
      signal in1, in2: in std_logic_vector(n-1 downto 0);
      signal sel: in std_logic;
      signal out1: out std_logic_vector(n-1 downto 0)
   );
end mux2to1;

architecture Behavioral of mux2to1 is

begin
   process(in1, in2, sel)
   begin
      if(sel='0') then
         out1 <= in1;
      else
         out1 <= in2;
      end if;
   end process;

end Behavioral;


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:31:28 04/24/2024 
-- Design Name: 
-- Module Name:    program_counter - Behavioral 
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

entity program_counter is
   port(
      signal clk: in std_logic;
      signal reset: in std_logic;
      signal address_in: in std_logic_vector(31 downto 0);
      signal address_out: out std_logic_vector(31 downto 0)
   );
end program_counter;

architecture Behavioral of program_counter is
   -- signal next_address: std_logic_vector(31 downto 0);
   
begin
   process(clk, reset, address_in)
   begin
      if(reset='1') then
         address_out <= (others=>'0'); -- very simple
      elsif(rising_edge(clk)) then
         address_out <= address_in; -- very simple -> next address is calculated already outside
      end if;
   end process;
   
end Behavioral;


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:49:07 04/24/2024 
-- Design Name: 
-- Module Name:    data_memory - Behavioral 
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

entity data_memory is
   port(
      signal clk: in std_logic;                              -- clock
      -- signal chip_sel: in std_logic;                         -- chip select
      -- read_en ~ re
      signal re: in std_logic;                          -- read enable
      -- write_en ~ we
      signal we: in std_logic;                         -- write enable
      -- write_data ~ wd
      signal wd: in std_logic_vector(31 downto 0);   -- write data
      -- address ~ a
      signal a: in std_logic_vector(31 downto 0);      -- address
      -- read_data ~ rd
      signal rd: out std_logic_vector(31 downto 0)    -- read data
   );
end data_memory;

architecture Behavioral of data_memory is
   -- 256 x 4B of ram ~ 1024B of ram
   type RAM is array(0 to 255) of std_logic_vector(31 downto 0);
   -- more realistically, we could do the following, whichi is pretty unnecessary for our usecase
   -- type memory_type is array(0 to 536870911-1) of std_logic_vector(31 downto 0);
   signal data_memory: RAM;
begin
   process(clk, we, wd, a) -- process(clk, chip_sel, read_en, we, wd, a)
   begin
      if(rising_edge(clk)) then -- if(rising_edge(clk) and chip_sel='1') then
         if(we='1') then
         -- MSB FIRST
            data_memory(to_integer(unsigned(a))) <= wd(31 downto 0);
         -- LSB LAST
         end if;
      end if;
      -- since there is sometimes imm16s bigger than 1023,
      -- we should avoid calling memory indexes with those imm16s.
      -- for that cases, read_en (re) must be put.
      if(re='1' and we='0') then
      -- MSB FIRST
         rd(31 downto 0) <= data_memory(to_integer(unsigned(a)));
      -- LSB LAST
      else
         rd <= (others=>'U');
      end if;
   end process;
end Behavioral;


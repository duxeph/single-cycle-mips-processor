----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:39:55 04/24/2024 
-- Design Name: 
-- Module Name:    register_file - Behavioral 
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

entity register_file is
   port(
      signal clk: in std_logic;
      -- read1_reg ~ ra1, read2_reg ~ ra2, write_reg ~ wa3
      signal ra1, ra2, wa3: in std_logic_vector(4 downto 0);
      -- write_en ~ we3
      signal we3: in std_logic;
      -- write_data ~ wd3
      signal wd3: in std_logic_vector(31 downto 0);
      -- read1_out ~ rd1, read2_out ~ rd2
      signal rd1, rd2: out std_logic_vector(31 downto 0);
      
      -- investigation purposes <--there->
      signal zero_0, at_1, v0_2, v1_3, a0_4, a1_5, a2_6, a3_7,
             t0_8, t1_9, t2_10, t3_11, t4_12, t5_13, t6_14, t7_15,
             s0_16, s1_17, s2_18, s3_19, s4_20, s5_21, s6_22, s7_23,
             t8_24, t9_25, k0_26, k1_27, gp_28, sp_29, fp_30, ra_31: out std_logic_vector(31 downto 0)
      -- investigation purposes <to there>
   );
end register_file;

architecture Behavioral of register_file is
   type reg_type is array(0 to 31) of std_logic_vector(31 downto 0);
   signal reg: reg_type := (29=>std_logic_vector(to_unsigned(1023, 32)), others=>(others=>'0'));
begin
   process(clk, we3, ra1, ra2, wa3, wd3)
   begin
      reg(0) <= (others=>'0');
      if(rising_edge(clk) and wa3/="00000" and we3='1') then
         reg(to_integer(unsigned(wa3))) <= wd3;
      end if;
      -- reading operation is asynchronous - does not wait for clock transition
      rd1 <= reg(to_integer(unsigned(ra1)));
      rd2 <= reg(to_integer(unsigned(ra2)));
      
      -- investigation purposes <--there->
      zero_0 <= reg(0);
      at_1 <= reg(1);
      v0_2 <= reg(2);
      v1_3 <= reg(3);
      a0_4 <= reg(4);
      a1_5 <= reg(5);
      a2_6 <= reg(6);
      a3_7 <= reg(7);
      t0_8 <= reg(8);
      t1_9 <= reg(9);
      t2_10 <= reg(10);
      t3_11 <= reg(11);
      t4_12 <= reg(12);
      t5_13 <= reg(13);
      t6_14 <= reg(14);
      t7_15 <= reg(15);
      s0_16 <= reg(16);
      s1_17 <= reg(17);
      s2_18 <= reg(18);
      s3_19 <= reg(19);
      s4_20 <= reg(20);
      s5_21 <= reg(21);
      s6_22 <= reg(22);
      s7_23 <= reg(23);
      t8_24 <= reg(24);
      t9_25 <= reg(25);
      k0_26 <= reg(26);
      k1_27 <= reg(27);
      gp_28 <= reg(28);
      sp_29 <= reg(29);
      fp_30 <= reg(30);
      ra_31 <= reg(31);
      -- investigation purposes <to there>
      -- end if;
   end process;

end Behavioral;

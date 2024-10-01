--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:30:33 05/12/2024
-- Design Name:   
-- Module Name:   C:/Users/kagan/Documents/Xilinx/ISE/lab3 - according to manual/top_tb.vhd
-- Project Name:  lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         write_en : IN  std_logic;
         instruction_im : IN  std_logic_vector(31 downto 0);
         control_signal : OUT  std_logic;
         INV_is_jump_reg_active : OUT  std_logic;
         INV_current_instruction : OUT  std_logic_vector(31 downto 0);
         INV_next_address : OUT  std_logic_vector(31 downto 0);
         INV_current_address : OUT  std_logic_vector(31 downto 0);
         INV_opcode : OUT  std_logic_vector(5 downto 0);
         INV_rs : OUT  std_logic_vector(4 downto 0);
         INV_rt : OUT  std_logic_vector(4 downto 0);
         INV_rd : OUT  std_logic_vector(4 downto 0);
         INV_shamt : OUT  std_logic_vector(4 downto 0);
         INV_funct : OUT  std_logic_vector(5 downto 0);
         INV_register_file_read1_out : OUT  std_logic_vector(31 downto 0);
         INV_register_file_read2_out : OUT  std_logic_vector(31 downto 0);
         INV_jump_address : OUT  std_logic_vector(31 downto 0);
         INV_extended_immediate : OUT  std_logic_vector(31 downto 0);
         INV_memory_read_out : OUT  std_logic_vector(31 downto 0);
         INV_general_alu_output : OUT  std_logic_vector(31 downto 0);
         zero_0 : OUT  std_logic_vector(31 downto 0);
         at_1 : OUT  std_logic_vector(31 downto 0);
         v0_2 : OUT  std_logic_vector(31 downto 0);
         v1_3 : OUT  std_logic_vector(31 downto 0);
         a0_4 : OUT  std_logic_vector(31 downto 0);
         a1_5 : OUT  std_logic_vector(31 downto 0);
         a2_6 : OUT  std_logic_vector(31 downto 0);
         a3_7 : OUT  std_logic_vector(31 downto 0);
         t0_8 : OUT  std_logic_vector(31 downto 0);
         t1_9 : OUT  std_logic_vector(31 downto 0);
         t2_10 : OUT  std_logic_vector(31 downto 0);
         t3_11 : OUT  std_logic_vector(31 downto 0);
         t4_12 : OUT  std_logic_vector(31 downto 0);
         t5_13 : OUT  std_logic_vector(31 downto 0);
         t6_14 : OUT  std_logic_vector(31 downto 0);
         t7_15 : OUT  std_logic_vector(31 downto 0);
         s0_16 : OUT  std_logic_vector(31 downto 0);
         s1_17 : OUT  std_logic_vector(31 downto 0);
         s2_18 : OUT  std_logic_vector(31 downto 0);
         s3_19 : OUT  std_logic_vector(31 downto 0);
         s4_20 : OUT  std_logic_vector(31 downto 0);
         s5_21 : OUT  std_logic_vector(31 downto 0);
         s6_22 : OUT  std_logic_vector(31 downto 0);
         s7_23 : OUT  std_logic_vector(31 downto 0);
         t8_24 : OUT  std_logic_vector(31 downto 0);
         t9_25 : OUT  std_logic_vector(31 downto 0);
         k0_26 : OUT  std_logic_vector(31 downto 0);
         k1_27 : OUT  std_logic_vector(31 downto 0);
         gp_28 : OUT  std_logic_vector(31 downto 0);
         sp_29 : OUT  std_logic_vector(31 downto 0);
         fp_30 : OUT  std_logic_vector(31 downto 0);
         ra_31 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal write_en : std_logic := '0';
   signal instruction_im : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal control_signal : std_logic;
   signal INV_is_jump_reg_active : std_logic;
   signal INV_current_instruction : std_logic_vector(31 downto 0);
   signal INV_next_address : std_logic_vector(31 downto 0);
   signal INV_current_address : std_logic_vector(31 downto 0);
   signal INV_opcode : std_logic_vector(5 downto 0);
   signal INV_rs : std_logic_vector(4 downto 0);
   signal INV_rt : std_logic_vector(4 downto 0);
   signal INV_rd : std_logic_vector(4 downto 0);
   signal INV_shamt : std_logic_vector(4 downto 0);
   signal INV_funct : std_logic_vector(5 downto 0);
   signal INV_register_file_read1_out : std_logic_vector(31 downto 0);
   signal INV_register_file_read2_out : std_logic_vector(31 downto 0);
   signal INV_jump_address : std_logic_vector(31 downto 0);
   signal INV_extended_immediate : std_logic_vector(31 downto 0);
   signal INV_memory_read_out : std_logic_vector(31 downto 0);
   signal INV_general_alu_output : std_logic_vector(31 downto 0);
   signal zero_0 : std_logic_vector(31 downto 0);
   signal at_1 : std_logic_vector(31 downto 0);
   signal v0_2 : std_logic_vector(31 downto 0);
   signal v1_3 : std_logic_vector(31 downto 0);
   signal a0_4 : std_logic_vector(31 downto 0);
   signal a1_5 : std_logic_vector(31 downto 0);
   signal a2_6 : std_logic_vector(31 downto 0);
   signal a3_7 : std_logic_vector(31 downto 0);
   signal t0_8 : std_logic_vector(31 downto 0);
   signal t1_9 : std_logic_vector(31 downto 0);
   signal t2_10 : std_logic_vector(31 downto 0);
   signal t3_11 : std_logic_vector(31 downto 0);
   signal t4_12 : std_logic_vector(31 downto 0);
   signal t5_13 : std_logic_vector(31 downto 0);
   signal t6_14 : std_logic_vector(31 downto 0);
   signal t7_15 : std_logic_vector(31 downto 0);
   signal s0_16 : std_logic_vector(31 downto 0);
   signal s1_17 : std_logic_vector(31 downto 0);
   signal s2_18 : std_logic_vector(31 downto 0);
   signal s3_19 : std_logic_vector(31 downto 0);
   signal s4_20 : std_logic_vector(31 downto 0);
   signal s5_21 : std_logic_vector(31 downto 0);
   signal s6_22 : std_logic_vector(31 downto 0);
   signal s7_23 : std_logic_vector(31 downto 0);
   signal t8_24 : std_logic_vector(31 downto 0);
   signal t9_25 : std_logic_vector(31 downto 0);
   signal k0_26 : std_logic_vector(31 downto 0);
   signal k1_27 : std_logic_vector(31 downto 0);
   signal gp_28 : std_logic_vector(31 downto 0);
   signal sp_29 : std_logic_vector(31 downto 0);
   signal fp_30 : std_logic_vector(31 downto 0);
   signal ra_31 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk => clk,
          reset => reset,
          write_en => write_en,
          instruction_im => instruction_im,
          control_signal => control_signal,
          INV_is_jump_reg_active => INV_is_jump_reg_active,
          INV_current_instruction => INV_current_instruction,
          INV_next_address => INV_next_address,
          INV_current_address => INV_current_address,
          INV_opcode => INV_opcode,
          INV_rs => INV_rs,
          INV_rt => INV_rt,
          INV_rd => INV_rd,
          INV_shamt => INV_shamt,
          INV_funct => INV_funct,
          INV_register_file_read1_out => INV_register_file_read1_out,
          INV_register_file_read2_out => INV_register_file_read2_out,
          INV_jump_address => INV_jump_address,
          INV_extended_immediate => INV_extended_immediate,
          INV_memory_read_out => INV_memory_read_out,
          INV_general_alu_output => INV_general_alu_output,
          zero_0 => zero_0,
          at_1 => at_1,
          v0_2 => v0_2,
          v1_3 => v1_3,
          a0_4 => a0_4,
          a1_5 => a1_5,
          a2_6 => a2_6,
          a3_7 => a3_7,
          t0_8 => t0_8,
          t1_9 => t1_9,
          t2_10 => t2_10,
          t3_11 => t3_11,
          t4_12 => t4_12,
          t5_13 => t5_13,
          t6_14 => t6_14,
          t7_15 => t7_15,
          s0_16 => s0_16,
          s1_17 => s1_17,
          s2_18 => s2_18,
          s3_19 => s3_19,
          s4_20 => s4_20,
          s5_21 => s5_21,
          s6_22 => s6_22,
          s7_23 => s7_23,
          t8_24 => t8_24,
          t9_25 => t9_25,
          k0_26 => k0_26,
          k1_27 => k1_27,
          gp_28 => gp_28,
          sp_29 => sp_29,
          fp_30 => fp_30,
          ra_31 => ra_31
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
      reset <= '1';
      wait for clk_period;
      
      reset <= '0';
      write_en <= '1';
      
      -- counts 2 by 2 in a loop up to 20 ($1)
--      instruction_im <= "00100000000000010000000000000001";    -- addi $1, $0, 0
--      wait for clk_period;
--      instruction_im <= "00100000000000100000000000010100";    -- addi $2, $0, 20
--      wait for clk_period;
--      instruction_im <= "00100000001000010000000000000001";    -- addi $1, $1, 1
--      wait for clk_period;
--      instruction_im <= "00100000001000010000000000000001";    -- addi $1, $1, 1
--      wait for clk_period;
--      instruction_im <= "00000000001000100001100000101010";    -- slt $3, $1, $2
--      wait for clk_period;
--      instruction_im <= "00010000011000000000000000000010";    -- beq $3, $0, 2
--      wait for clk_period;
--      instruction_im <= "00001100000100000000000000000010";    -- jal address of 2
--      wait for clk_period;
--      instruction_im <= x"08100007"; -- j 7
--      wait for clk_period;
--      instruction_im <= "00000011111000000000000000001000";    -- jr $ra
--      wait for clk_period;
         
      -- trying different instruction types separately
      instruction_im <= X"20010001"; -- w:0   b:0     addi $1,$0,1
      wait for clk_period;
      instruction_im <= X"ac010000"; -- w:1   b:4     sw $1,0($0)
      wait for clk_period;
      instruction_im <= X"20020002"; -- w:2   b:8     addi $2,$0,2
      wait for clk_period;
      instruction_im <= X"ac020004"; -- w:3   b:12    sw $2,4($0)
      wait for clk_period;
      instruction_im <= X"8c030004"; -- w:4   b:16    lw $3,4($0)
      wait for clk_period;
      instruction_im <= X"08100005"; -- w:5   b:20    j 0x00400014
      wait for clk_period;     
      
      -- fibonacci
      -- arguments:
      --    $a1: find fibonacci value of $a1-1
      -- outputs:
      --    $a0: result
--      instruction_im <= X"20040000"; -- w:0   b:0     addi $4,$0,0
--      wait for clk_period;
--      instruction_im <= X"2005000a"; -- w:1   b:4     addi $5,$0,10
--      wait for clk_period;
--      instruction_im <= X"0c100004"; -- w:2   b:8     jal 0x00400010
--      wait for clk_period;
--      instruction_im <= X"08100003"; -- w:3   b:12    j 0x0040000c
--      wait for clk_period;
--      instruction_im <= X"23bdfff4"; -- w:4   b:16    addi $29,$29,-12
--      wait for clk_period;
--      instruction_im <= X"afbf0008"; -- w:5   b:20    sw $31,8($29)
--      wait for clk_period;
--      instruction_im <= X"afa50004"; -- w:6   b:24    sw $5,4($29)
--      wait for clk_period;
--      instruction_im <= X"afa40000"; -- w:7   b:28    sw $4,0($29)
--      wait for clk_period;
--      instruction_im <= X"20a5ffff"; -- w:8   b:32    addi $5,$5,-1
--      wait for clk_period;
--      instruction_im <= X"0005402a"; -- w:9   b:36    slt $8,$0,$5
--      wait for clk_period;
--      instruction_im <= X"11000005"; -- w:10  b:40    beq $8,$0,5
--      wait for clk_period;
--      instruction_im <= X"0004482a"; -- w:11  b:44    slt $9,$0,$4
--      wait for clk_period;
--      instruction_im <= X"11200006"; -- w:12  b:48    beq $9,$0,6
--      wait for clk_period;
--      instruction_im <= X"8faa000c"; -- w:13  b:52    lw $10,12($29)
--      wait for clk_period;
--      instruction_im <= X"008a2020"; -- w:14  b:56    add $4,$4,$10
--      wait for clk_period;
--      instruction_im <= X"0c100004"; -- w:15  b:60    jal 0x00400010
--      wait for clk_period;
--      instruction_im <= X"8fbf0008"; -- w:16  b:64    lw $31,8($29)
--      wait for clk_period;
--      instruction_im <= X"23bd000c"; -- w:17  b:68    addi $29,$29,12
--      wait for clk_period;
--      instruction_im <= X"03e00008"; -- w:18  b:72    jr $31
--      wait for clk_period;
--      instruction_im <= X"20040001"; -- w:19  b:76    addi $4,$0,1
--      wait for clk_period;
--      instruction_im <= X"0c100004"; -- w:20  b:80    jal 0x00400010
--      wait for clk_period;
--      instruction_im <= X"08100010"; -- w:21  b:84    j 0x00400040
--      wait for clk_period;


      -- recursive factorial
      -- arguments:
      --    $4: calculate $4!
      -- outputs:
      --    $2: output
--      instruction_im <= X"20040006"; -- w:0	b:0	addi $4,$0,6
--      wait for clk_period;
--      instruction_im <= X"0c100004"; -- w:1	b:4	jal 0x00400010
--      wait for clk_period;
--      instruction_im <= X"20420000"; -- w:2	b:8	addi $2,$2,0
--      wait for clk_period;
--      instruction_im <= X"08100003"; -- w:3	b:12	j 3
--      wait for clk_period;
--      instruction_im <= X"23bdfff8"; -- w:4	b:16	addi $29,$29,-8
--      wait for clk_period;
--      instruction_im <= X"afbf0004"; -- w:5	b:20	sw $31,4($29)
--      wait for clk_period;
--      instruction_im <= X"afa40000"; -- w:6	b:24	sw $4,0($29)
--      wait for clk_period;
--      instruction_im <= X"28880002"; -- w:7	b:28	slti $8,$4,2
--      wait for clk_period;
--      instruction_im <= X"11000003"; -- w:8	b:32	beq $8,$0,3
--      wait for clk_period;
--      instruction_im <= X"20020001"; -- w:9	b:36	addi $2,$0,1
--      wait for clk_period;
--      instruction_im <= X"23bd0008"; -- w:10	b:40	addi $29,$29,8
--      wait for clk_period;
--      instruction_im <= X"03e00008"; -- w:11	b:44	jr $31
--      wait for clk_period;
--      instruction_im <= X"2084ffff"; -- w:12	b:48	addi $4,$4,-1
--      wait for clk_period;
--      instruction_im <= X"0c100004"; -- w:13	b:52	jal 0x00400010
--      wait for clk_period;
--      instruction_im <= X"8fa40000"; -- w:14	b:56	lw $4,0($29)
--      wait for clk_period;
--      instruction_im <= X"8fbf0004"; -- w:15	b:60	lw $31,4($29)
--      wait for clk_period;
--      instruction_im <= X"23bd0008"; -- w:16	b:64	addi $29,$29,8
--      wait for clk_period;
--      instruction_im <= X"70821002"; -- w:17	b:68	mul $2,$4,$2
--      wait for clk_period;
--      instruction_im <= X"03e00008"; -- w:18	b:72	jr $31
--      wait for clk_period;


      -- loop factorial
      -- arguments:
      --    $4: calculate $4!
      -- outputs:
      --    $2: output
--      instruction_im <= X"20040005"; -- w:0   b:0     addi $4,$0,5
--      wait for clk_period;
--      instruction_im <= X"0c100004"; -- w:1   b:4     jal 0x00400010
--      wait for clk_period;
--      instruction_im <= X"20420000"; -- w:2   b:8     addi $2,$2,0
--      wait for clk_period;
--      instruction_im <= X"08100003"; -- w:3   b:12    j 0x0040000c
--      wait for clk_period;
--      instruction_im <= X"23bdfff8"; -- w:4   b:16    addi $29,$29,-8
--      wait for clk_period;
--      instruction_im <= X"afbf0004"; -- w:5   b:20    sw $31,4($29)
--      wait for clk_period;
--      instruction_im <= X"afa40000"; -- w:6   b:24    sw $4,0($29)
--      wait for clk_period;
--      instruction_im <= X"20020001"; -- w:7   b:28    addi $2,$0,1
--      wait for clk_period;
--      instruction_im <= X"28880002"; -- w:8   b:32    slti $8,$4,2
--      wait for clk_period;
--      instruction_im <= X"1500000a"; -- w:9   b:36    bne $8,$0,10
--      wait for clk_period;
--      instruction_im <= X"0c10000e"; -- w:10  b:40    jal 0x00400038
--      wait for clk_period;
--      instruction_im <= X"8fbf0004"; -- w:11  b:44    lw $31,4($29)
--      wait for clk_period;
--      instruction_im <= X"23bd0008"; -- w:12  b:48    addi $29,$29,8
--      wait for clk_period;
--      instruction_im <= X"03e00008"; -- w:13  b:52    jr $31
--      wait for clk_period;
--      instruction_im <= X"8fa40000"; -- w:14  b:56    lw $4,0($29)
--      wait for clk_period;
--      instruction_im <= X"70441002"; -- w:15  b:60    mul $2,$2,$4
--      wait for clk_period;
--      instruction_im <= X"2084ffff"; -- w:16  b:64    addi $4,$4,-1
--      wait for clk_period;
--      instruction_im <= X"afa40000"; -- w:17  b:68    sw $4,0($29)
--      wait for clk_period;
--      instruction_im <= X"28880002"; -- w:18  b:72    slti $8,$4,2
--      wait for clk_period;
--      instruction_im <= X"1100fffa"; -- w:19  b:76    beq $8,$0,-6
--      wait for clk_period;
--      instruction_im <= X"03e00008"; -- w:20  b:80    jr $31
--      wait for clk_period;


--      instruction_im <= X"20090005"; -- w:0   b:0     addi $9,$0,5
--      wait for clk_period;
--      instruction_im <= X"01205020"; -- w:1   b:4     add $10,$9,$0
--      wait for clk_period;
--      instruction_im <= X"012a5820"; -- w:2   b:8     add $11,$9,$10
--      wait for clk_period;
--      instruction_im <= X"216c000a"; -- w:3   b:12    addi $12,$11,10
--      wait for clk_period;
--      instruction_im <= X"08100004"; -- w:4   b:16    j 0x00400010
--      wait for clk_period;
            
      
      -- testing r-type & i-type instructions
--      instruction_im <= X"20010008"; -- w:0   b:0     addi $1,$0,8
--      wait for clk_period;
--      instruction_im <= X"20020005"; -- w:1   b:4     addi $2,$0,5
--      wait for clk_period;
--      instruction_im <= X"00221825"; -- w:2   b:8     or $3,$1,$2
--      wait for clk_period;
--      instruction_im <= X"00422025"; -- w:3   b:12    or $4,$2,$2
--      wait for clk_period;
--      instruction_im <= X"3425000c"; -- w:4   b:16    ori $5,$1,12
--      wait for clk_period;
--      instruction_im <= X"3446000d"; -- w:5   b:20    ori $6,$2,13
--      wait for clk_period;
--      instruction_im <= X"08100006"; -- w:6   b:24    j 0x00400006
--      wait for clk_period;
      
      reset <= '1';
      write_en <= '0';
      wait for clk_period;
      reset <= '0';

      wait;
   end process;

END;

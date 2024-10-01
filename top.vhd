----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:36:01 04/24/2024 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
   port(
      signal clk: in std_logic;
      signal reset: in std_logic;
      signal write_en: in std_logic;
      signal instruction_im: in std_logic_vector(31 downto 0);
      
      signal control_signal: out std_logic;
      signal INV_is_jump_reg_active: out std_logic;
      signal INV_current_instruction, INV_next_address, INV_current_address: out std_logic_vector(31 downto 0);
      signal INV_opcode: out std_logic_vector(5 downto 0);
      signal INV_rs, INV_rt, INV_rd, INV_shamt: out std_logic_vector(4 downto 0);
      signal INV_funct: out std_logic_vector(5 downto 0);
      signal INV_register_file_read1_out, INV_register_file_read2_out, INV_jump_address, INV_extended_immediate, INV_memory_read_out, INV_general_alu_output: out std_logic_vector(31 downto 0);
      signal zero_0, at_1, v0_2, v1_3, a0_4, a1_5, a2_6, a3_7,
             t0_8, t1_9, t2_10, t3_11, t4_12, t5_13, t6_14, t7_15,
             s0_16, s1_17, s2_18, s3_19, s4_20, s5_21, s6_22, s7_23,
             t8_24, t9_25, k0_26, k1_27, gp_28, sp_29, fp_30, ra_31: out std_logic_vector(31 downto 0)
   );
end top;

architecture Behavioral of top is
   component register_file is
      port(
         clk: in std_logic;
         ra1, ra2, wa3: in std_logic_vector(4 downto 0);
         we3: in std_logic;
         wd3: in std_logic_vector(31 downto 0);
         rd1, rd2: out std_logic_vector(31 downto 0);
         zero_0, at_1, v0_2, v1_3, a0_4, a1_5, a2_6, a3_7,
         t0_8, t1_9, t2_10, t3_11, t4_12, t5_13, t6_14, t7_15,
         s0_16, s1_17, s2_18, s3_19, s4_20, s5_21, s6_22, s7_23,
         t8_24, t9_25, k0_26, k1_27, gp_28, sp_29, fp_30, ra_31: out std_logic_vector(31 downto 0)
      );
   end component;
   component extender is
      port(
         input: in std_logic_vector(15 downto 0);
         ExtOp: in std_logic;
         output: out std_logic_vector(31 downto 0)
      );
   end component;
   component data_memory is
      port(
         clk: in std_logic;                        -- clock
         -- chip_sel: in std_logic;                -- chip select
         re: in std_logic;                         -- read enable
         we: in std_logic;                         -- write enable
         wd: in std_logic_vector(31 downto 0);     -- write data
         a: in std_logic_vector(31 downto 0);      -- address
         rd: out std_logic_vector(31 downto 0)     -- read data
      );
   end component;
   component alu_control is
      port(
         aluop: in std_logic_vector(2 downto 0);
         funct: in std_logic_vector(5 downto 0);
         opcode: out std_logic_vector(3 downto 0)
      );
   end component;
   component alu is
      port(
         alucontrol: in std_logic_vector(3 downto 0);
         shamt: in std_logic_vector(4 downto 0);
         a, b: in std_logic_vector(31 downto 0);
         zero: out std_logic;
         result: out std_logic_vector(31 downto 0);
         re, lo, hi: out std_logic_vector(31 downto 0)
      );
   end component;
   component instruction_memory is
      port(
         clk: in std_logic;
         we: in std_logic;                      -- ?
         a: in std_logic_vector(31 downto 0);
         wd: in std_logic_vector(31 downto 0);  -- ?
         rd: out std_logic_vector(31 downto 0)
      );
   end component;
   component program_counter is
      port(
         clk: in std_logic;
         reset: in std_logic;
         address_in: in std_logic_vector(31 downto 0);
         address_out: out std_logic_vector(31 downto 0)
      );
   end component;
   component control_unit is
      port(
         opcode: in std_logic_vector(5 downto 0);
         funct: in std_logic_vector(5 downto 0);
         RegDst, ExtOp, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, BranchNE, Jump, JPLink, JPReg: out std_logic;
         ALUOp: out std_logic_vector(2 downto 0)
      );
   end component;
   component mux2to1 is
      generic(n: integer);
      port(
         signal in1, in2: in std_logic_vector(n-1 downto 0);
         signal sel: in std_logic;
         signal out1: out std_logic_vector(n-1 downto 0)
      );
   end component;

   signal RegDst, ExtOp, Jump, JPLink, JPReg, Branch, BranchNE, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite: std_logic;
   signal ALUOp: std_logic_vector(2 downto 0);
   
   signal address_in_pc, address_out_pc: std_logic_vector(31 downto 0) := (others=>'0');
   signal address_pfour: std_logic_vector(31 downto 0);
   
   signal jump_out_im32: std_logic_vector(31 downto 0);
   signal current_instruction: std_logic_vector(31 downto 0);
   
   signal write_out_temp, write_out_rf: std_logic_vector(4 downto 0);
   signal write_data_temp, write_data_rf: std_logic_vector(31 downto 0);
   signal read1_out_rf, read2_out_rf: std_logic_vector(31 downto 0);
   
   signal output_se: std_logic_vector(31 downto 0);      -- sign extender output
   signal read_data_dm: std_logic_vector(31 downto 0);   -- data memory read data
   signal opcode_ac: std_logic_vector(3 downto 0);       -- alu contr/decoder opcode output
   
   signal in2_a, out1_a: std_logic_vector(31 downto 0);  -- main alu input (extended immed32), main alu output
   signal zero_a: std_logic;                             -- main alu zero flag
   signal re_a, lo_a, hi_a: std_logic_vector(31 downto 0); -- main alu mul & div parameters

   signal branch_address, branch_output, branch_temp: std_logic_vector(31 downto 0);
   signal jump_address, jump_output28, jump_output32, jump_temp: std_logic_vector(31 downto 0);
   signal BranchSel: std_logic;
   
begin
   -- program counter <start>
   pc_0: program_counter port map(
      clk=>clk,
      reset=>reset,
      address_in=>address_in_pc,
      address_out=>address_out_pc
   );
   -- program counter alu: current address + 4
   a_j0: alu port map(
      alucontrol=>"0001",   -- output: current pc + 4
      shamt=>"00000",
      a=>address_out_pc,         -- current pc
      b=>(2=>'1', others=>'0'),  -- +4
      zero=>open,
      result=>address_pfour,
      re=>open, lo=>open, hi=>open
   );
   -- program counter alu: branch address sll 2
   a_j1: alu port map(
      alucontrol=>"1001",   -- output: SignExt(imm16) << 2
      shamt=>"00010",      -- shift amount
      a=>output_se,        -- sign extended immediate
      b=>(others=>'0'),    -- <none>
      zero=>open,
      result=>branch_address,
      re=>open, lo=>open, hi=>open
   );
   -- program counter alu: (branch address sll 2) + (current address + 4)
   a_j2: alu port map(
      alucontrol=>"0001",   -- output: current pc + SignExt(imm16) << 2
      shamt=>"00000",
      a=>address_pfour,    -- current pc
      b=>branch_address,   -- SignExt(imm16) << 2
      zero=>open,
      result=>branch_output,
      re=>open, lo=>open, hi=>open
   );
   -- program counter alu: "jump address - 0x100000"
   --    *since there is no .text and .main in our codes, we start from address 0x0
   a_j31: alu port map(
      alucontrol=>"0010",  -- output: imm26 - 2^20
      shamt=>"00000",
      a=>jump_out_im32,          -- 26-bits immediate (j-type instr.)
      b=>(20=>'1', others=>'0'), -- 2^20
      zero=>open,
      result=>jump_address,
      re=>open, lo=>open, hi=>open
   );
   -- program counter alu: jump address sll 2
   jump_out_im32 <= "000000"&current_instruction(25 downto 0);
   a_j32: alu port map(
      alucontrol=>"1001",   -- output: (jump address - 2^20) << 2
      shamt=>"00010",
      a=>jump_address,     -- jump address - 2^20
      b=>(others=>'0'),    -- <none>
      zero=>open,
      result=>jump_output28,
      re=>open, lo=>open, hi=>open
   );
   -- program counter mux: next address = branch address if BranchSel
   m_j0: mux2to1 generic map(n=>32) port map(
      in1=>address_pfour,  -- pc + 4
      in2=>branch_output,  -- (pc + 4) + SignExt(imm16)<<2
      sel=>BranchSel,      -- if branch is taken
      out1=>branch_temp
   );
   -- program counter mux: next address = jump address if Jump
   BranchSel <= (Branch and zero_a) or (BranchNE and not zero_a);
   m_j1: mux2to1 generic map(n=>32) port map(
      in1=>branch_temp,
      in2=>jump_output32,  -- 32-bits jump address
      sel=>Jump,           -- if instr. is J
      out1=>jump_temp
   );
   -- program counter mux: next address = $31=$ra address if JPReg
   jump_output32 <= address_pfour(31 downto 28)&jump_output28(27 downto 0);
   m_j2: mux2to1 generic map(n=>32) port map(
      in1=>jump_temp,
      in2=>read1_out_rf,   -- $31=$ra is read from read1_out_rf
      sel=>JPReg,          -- if instr. is JR
      out1=>address_in_pc
   );
   -- program counter <-end->
   
   -- instruction memory <start>
   im_0: instruction_memory port map(
      clk=>clk,
      we=>write_en,
      a=>address_out_pc,
      wd=>instruction_im,
      rd=>current_instruction
   );
   INV_current_instruction <= current_instruction;
   -- instruction memory <-end->
   
   -- register file <start>
   rf_0: register_file port map(
      clk=>clk,
      ra1=>current_instruction(25 downto 21),
      ra2=>current_instruction(20 downto 16),
      wa3=>write_out_rf,
      we3=>RegWrite,
      wd3=>write_data_rf,
      rd1=>read1_out_rf,
      rd2=>read2_out_rf,
      zero_0=>zero_0,
      -- for debugging purposes
      at_1=>at_1, v0_2=>v0_2, v1_3=>v1_3, a0_4=>a0_4, a1_5=>a1_5, a2_6=>a2_6, a3_7=>a3_7,
      t0_8=>t0_8, t1_9=>t1_9, t2_10=>t2_10, t3_11=>t3_11, t4_12=>t4_12, t5_13=>t5_13, t6_14=>t6_14, t7_15=>t7_15,
      s0_16=>s0_16, s1_17=>s1_17, s2_18=>s2_18, s3_19=>s3_19, s4_20=>s4_20, s5_21=>s5_21, s6_22=>s6_22, s7_23=>s7_23,
      t8_24=>t8_24, t9_25=>t9_25, k0_26=>k0_26, k1_27=>k1_27,
      gp_28=>gp_28, sp_29=>sp_29, fp_30=>fp_30, ra_31=>ra_31
   );
   -- register file mux: write data = read data from memory if MemtoReg
   m_0: mux2to1 generic map(n=>32) port map(
      in1=>out1_a,
      in2=>read_data_dm,
      sel=>MemtoReg,
      out1=>write_data_temp
   );
   -- register file mux: write data = (curr. addr. + 4) if JPLink
   m_1: mux2to1 generic map(n=>32) port map(
      in1=>write_data_temp,   -- else: ordinary wd is kept same
      in2=>address_pfour,     -- if so: pc + 4 is written
      sel=>JPLink,      -- if instr. is JAL
      out1=>write_data_rf
   );
   -- register file mux: write reg. = rd if RegDst
   m_2: mux2to1 generic map(n=>5) port map(
      in1=>current_instruction(20 downto 16),
      in2=>current_instruction(15 downto 11),
      sel=>RegDst,
      out1=>write_out_temp
   );
   -- register file mux: write reg. = ("11111"=$31=$ra) if JPLink
   m_3: mux2to1 generic map(n=>5) port map(
      in1=>write_out_temp, -- else: ordinary register is kept same
      in2=>"11111",  -- if so: $ra is being written
      sel=>JPLink,   -- if instr. is JAL
      out1=>write_out_rf
   );
   -- register file <-end->
   
   -- data memory <start>
   dm_0: data_memory port map(
      clk=>clk,
      -- chip_sel=>'1',
      re=>MemRead,      -- MemRead decides whether Data Mem. is being reached
      we=>MemWrite,
      wd=>read2_out_rf, -- R[rt] is always wd
      a=>out1_a,
      rd=>read_data_dm
   );
   -- data memory <-end->
   
   -- extender <start>
   e_0: extender port map(
      input=>current_instruction(15 downto 0),
      ExtOp=>ExtOp,     -- SignExt or ZeroExt
      output=>output_se
   );
   -- extender <-end->
   
   -- alu control <start>
   ac_0: alu_control port map(
      aluop=>ALUOp,
      funct=>current_instruction(5 downto 0),
      opcode=>opcode_ac
   );
   -- alu control <-end->
   
   -- main alu <start>
   a_0: alu port map(
      alucontrol=>opcode_ac,
      shamt=>current_instruction(10 downto 6),
      a=>read1_out_rf,
      b=>in2_a,
      zero=>zero_a,
      result=>out1_a,
      re=>re_a,
      lo=>lo_a,
      hi=>hi_a
   );
   -- main alu mux: alu_in1 = sign ext. output if ALUSrc
   m_4: mux2to1 generic map(n=>32) port map(
      in1=>read2_out_rf,
      in2=>output_se,
      sel=>ALUSrc,
      out1=>in2_a
   );
   -- main alu <-end->
   
   -- control unit <start>
   c_0: control_unit port map(
      opcode=>current_instruction(31 downto 26),
      funct=>current_instruction(5 downto 0),
      RegDst=>RegDst,
      ALUSrc=>ALUSrc,
      MemtoReg=>MemtoReg,
      RegWrite=>RegWrite,
      MemRead=>MemRead,
      MemWrite=>MemWrite,
      Branch=>Branch,
      BranchNE=>BranchNE,
      Jump=>Jump,
      JPLink=>JPLink,
      JPReg=>JPReg,
      ExtOp=>ExtOp,
      ALUOp=>ALUOp
   );
   -- control unit <-end->
   
   -- investigation purposes
   control_signal <= ExtOp;
   
   INV_is_jump_reg_active <= JPReg;
   
   INV_next_address      <= address_in_pc;    -- current address
   INV_current_address   <= address_out_pc;   -- next address
   
   INV_opcode <= current_instruction(31 downto 26);
   INV_rs <= current_instruction(25 downto 21);
   INV_rt <= current_instruction(20 downto 16);
   INV_rd <= current_instruction(15 downto 11);
   INV_shamt <= current_instruction(10 downto 6);
   INV_funct <= current_instruction(5 downto 0);
   
   INV_register_file_read1_out <= read1_out_rf;   -- 1st read register
   INV_register_file_read2_out <= read2_out_rf;   -- 2nd read register
   INV_jump_address <= jump_temp;             -- calculated jump address
   INV_extended_immediate <= output_se;       -- extended immediate
   INV_memory_read_out <= read_data_dm;       -- current memory data
   
   INV_general_alu_output <= out1_a;          -- alu output
   
end Behavioral;


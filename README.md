# Single Cycle MIPS Processor
This project contains the necessary files to build a single cycle processor built according to MIPS architecture. Using any environment that can run VHDL (.vhd) sources, you can simulate that project.

Each component written in its own file so you can change any part specifically and it should lead to any error by doing so.

top_tb.vhd file is also shared with some very basic and general algorithms. They are including;
- A program that "counts up to 20 by increasing 2 in each step.
- A fibonacci program with an argument and an output, it is explained in the top_tb.vhd file.
- A program that calculates the factorial recursively which means in each iteration it calls the function again and again without completing the function it was already in. Then it calculates the factorial as it completes the functions one by one. Has an argument and two outputs, it is explained in the top_tb.vhd file.
- A program that calculates the factorial using classical loop approach, which means in each iteration it gets back to the beginning of the loop using jump instruction. This program has an input and an output, they are explained in the top_tb.vhd file.

If you are familiar with processors' concept, you should know that the input must be provided in binary/hex format. To convert your MIPS code to binary/hex, you can use script named "bin to vhdl_tb.py". You must provide a mips_out.txt file to that script, which must also be in the format as follows,
```
Address     Code        Basic                      Source

0x00400000  0x20010001  addi $1,$0,1          1    addi $1, $0, 1
0x00400004  0xac010000  sw $1,0($0)           2    sw $1, 0($0)
0x00400008  0x20020002  addi $2,$0,2          3    addi $2, $0, 2
0x0040000c  0xac020004  sw $2,4($0)           4    sw $2, 4($0)
0x00400010  0x8c030004  lw $3,4($0)           5    lw $3, 4($0)
0x00400014  0x08100005  j 0x00400014          6    end: j end
```
Note that this kind of a file can be obtained easily using MARS Mips Simulator.

Supported instructions are as follows,
```
- jr $x              # jump register
- add $z, $x, $y     # add
- sub $z, $x, $y     # subtract
- div $z, $x, $y     # divide
- and $z, $x, $y     # logical and
- or $z, $x, $y      # logical or
- nor $z, $x, $y     # logical Nor
- xor $z, $x, $y     # logical Xor
- sll $z, $x, $y     # shift left logically
- srl $z, $x, $y     # shift right logically
- rol $z, $x, $y     # rotate left
- ror $z, $x, $y     # rotate right
- slt $z, $x, $y     # set on less than
- mul $z, $x, $y     # multiply
- lw $x, imm($y)     # load word
- sw $y, imm($x)     # store word
- addi $y, $x, imm   # add immediate
- ori $y, $x, imm    # logical or immediate
- xori $y, $x, imm   # logical Xor immediate
- slti $y, $x, imm   # set on less than immediate
- jal label          # jump and link
- beq $x, $y, label  # branch equal
- bne $x, $y, label  # branch not equal
- j label            # jump unconditionally
```
If you need further details:
- All the instructions are written according to the MIPS architecture, so the units "control unit" & "alu control" are all related with the real architecture of a MIPS proccesor.
- **Please note that the addresses provided to the program are updated in a way that differs from the real architecture. If you delete the part that the program updates the addresses you are very likely to encounter with memory issues. The reason why the program updates your addresses is because the user level data stored at very high levels of memory in the MIPS architecture (see MIPS Memory Map provided below that paragraph). In case of mine, it was already enough to have a ~1024 bytes of memory. So I decided to divide all the addresses provided to the program by 1,048,577 (in decimal). To demonstrate, if you have a line like ```j 0x00400014``` in your instructions, program assumes the address you provided is 0x00000014. Please do not hesitate from correcting that manually if you really need to.**
- Lastly, **RTL schematic** and an example to **testbench results** are provided to you. Please check them if before going deeper into the architecture and before testing your code.

**MIPS Memory Map**

![alt text](https://www2.it.uu.se/education/course/homepage/os/vt18/images/mips/MIPS_detailed_memory_layout.png)

---
Click [a link](https://courses.missouristate.edu/KenVollmar/MARS/) to get the MARS MIPS Simulator.

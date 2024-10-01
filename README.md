# Single Cycle MIPS Processor
This project contains the necessary files to build a single cycle processor built according to MIPS architecture. Using any environment that can run VHDL (.vhd) sources, you can simulate that project.
Each component written in its own file so you can change any part specifically and it should lead to any error by doing so.
top_tb.vhd file is also shared with some very basic and general algorithms. They are including;
- A program that "counts up to 20 by increasing 2 in each step.
- A fibonacci program with an argument and an output, it is explained in the top_tb.vhd file.
- A program that calculates the factorial recursively which means in each iteration it calls the function again and again without completing the function it was already in. Then it calculates the factorial as it completes the functions one by one. Has an argument and two outputs, it is explained in the top_tb.vhd file.
- A program that calculates the factorial using classical loop approach, which means in each iteration it gets back to the beginning of the loop using jump instruction. This program has an input and an output, they are explained in the top_tb.vhd file.
If you are familiar with processors' concept, you must have known that you must provide the input in binary format. To convert your MIPS code to binary, you can use script named "bin to vhdl_tb.py". You must provide a mips_out.txt file to that script, which must also be in the format as follows,
 Address    Code        Basic                     Source

0x00400000  0x20010001  addi $1,$0,1          1    addi $1, $0, 1
0x00400004  0xac010000  sw $1,0($0)           2    sw $1, 0($0)
0x00400008  0x20020002  addi $2,$0,2          3    addi $2, $0, 2
0x0040000c  0xac020004  sw $2,4($0)           4    sw $2, 4($0)
0x00400010  0x8c030004  lw $3,4($0)           5    lw $3, 4($0)
0x00400014  0x08100005  j 0x00400014          6    end: j end
Note that this kind of a file can be obtained easily using MARS Mips Simulator.

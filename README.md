# Single Cycle MIPS Processor
This project contains the necessary files to build a single cycle processor built according to MIPS architecture. Using any environment that can run VHDL (.vhd) sources, you can simulate that project.
Each component written in its own file so you can change any part specifically and it should lead to any error by doing so.
top_tb.vhd file is also shared with some very basic and general algorithms. They are including;
- a program that "counts up to 20 by increasing 2 in each step.
- a fibonacci program with an argument and an output, it is explained in the top_tb.vhd file.
- a program that calculates the factorial recursively which means in each iteration it calls the function again and again without completing the function it was already in. Then it calculates the factorial as it completes the functions one by one. Has an argument and two outputs, it is explained in the top_tb.vhd file.
- a program that calculates the factorial using classical loop approach, which means in each iteration it gets back to the beginning of the loop using jump instruction. This program has an input and an output, they are explained in the top_tb.vhd file.

with open(r"C:\Users\kagan\Desktop\mips_out.txt", "r") as file:
    x = file.read()

x = x.split("\n")[2:-1]
a = ""
j = 0
for i in x:
    i = i.split("  ")
    a += f"instruction_im <= X\"{i[1][2:]}\"; -- w:{j}\tb:{j*4}\t{i[2]}\n"+\
         "wait for clk_period;\n"
    j += 1
print(a)
input("Press enter to close the program.")
restart -f   -- to reset values

add wave *

force instr_addr 00000
run 5

force instr_addr 00001
run 5

force instr_addr 00010
run 5

force instr_addr 00011
run 5

force instr_addr 11010
run 5

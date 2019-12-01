restart -f   -- to reset values

add wave *

# Set PC to 0
force pc 16#00000000

# no branch, no jump
# PC = PC + 1
force pc_sel 00
force branch_type 00
run 1

# jump = 01, target address 5
force pc_sel 01
force target_address 16#00000005
run 1

# jump = 10, rs = x0A
force pc_sel 10
force rs 16#0000000A
run 1

# test branch = true
force pc_sel 00
force branch_type 01
force rs 16#00000001
force rt 16#00000001
run 1

# test branch = false
force rt 16#00000002
run 1

# test branch /= true
force branch_type 10
run 1

# test branch /= false
force rt 16#00000001
run 1

force branch_type 11

# test branch < 0
force rs 16#80000000
run 1

# test branch > 0
force rs 16#00000001
run 1

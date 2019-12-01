restart -f   -- to reset values

#restart -f   -- to reset values

add wave *



# test initial reset

force clock 0
force reset 1
force data_write 0
force addr 00001
force d_in 16#00000011
run 5

#test clock

force clock 0
force reset 0
force data_write 1
force addr 00001
force d_in 16#00000011
run 5


force clock 0
run 1

force clock 1
force reset 0
force data_write 1
force addr 00001
force d_in 16#00000011
run 5


# test data write

force clock 0
run 1

force clock 1
force reset 0
force data_write 0
force addr 00001
force d_in 16#11111111
run 5

force clock 0
run 1

force clock 1
force reset 0
force data_write 1
force addr 00001
force d_in 16#11111111
run 5


#test sudden reset again

force clock 0
run 1

force clock 1
force reset 1
force data_write 1
force addr 00001
force d_in 16#00000011
run 5

# test address

force clock 0
run 1

force clock 1
force reset 0
force data_write 1
force addr 00011
force d_in 16#11111111
run 5


force clock 0
run 1

force clock 1
force reset 0
force data_write 1
force addr 00100
force d_in 16#11111111
run 5

# test all resets again

force clock 0
run 1

force clock 1
force reset 1
force data_write 1
force addr 00100
force d_in 16#11111111
run 5

restart -f   -- to reset values

add wave *



force clock 0
force reset 1
force d 16#00000011
run 5

force clock 1
force reset 0
force d 16#00000011
run 5

force clock 0
force reset 1
force d 16#00000011
run 5

force clock 1
force reset 0
force d 16#00000111
run 5

force clock 0
force reset 0
force d 16#11111111
run 5

force clock 1
force reset 0
force d 16#11111111
run 5
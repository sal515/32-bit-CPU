#do file comment
#do file to repeat rather than brute force

restart -f   -- to reset values

add wave *

#add wave clk
#add wave x
#add wave y
#add wave arithmatic_out

#force clk 0 0, 1 10 -r 20
force x 16#00000000
force y 16#FFFFFFFF
run 1
force add_sub 0
run 4
force logic_func 00
run 4
force logic_func 01
run 4
force logic_func 10
run 4
force logic_func 11
run 4
force logic_func UU
run 4

force x 16#FFFFFFFF
force y 16#FFFFFFFF
run 4
force add_sub 0
run 4
force logic_func 00
run 4
force logic_func 01
run 4
force logic_func 10
run 4
force logic_func 11
run 4
force logic_func UU
run 4


force x 16#00000000
force y 16#FFFFFFFF
force add_sub 1
run 4

force x 16#00000000
force y 16#FFFFFFFF
force add_sub U
run 4







#force din 0000
#run 2
#force din(0) 1 2, 0 4 -r 4
#force din(1) 1 4, 0 8 -r 8
#force din(2) 2#1 8, 2#0 16 -r 16
#force din(3) 2#1 16, 2#0 32 -r 32

#run 34

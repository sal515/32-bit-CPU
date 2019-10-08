#do file comment
#do file to repeat rather than brute force

#restart -f   -- to reset values

#add wave *

add wave clk
add wave x
add wave y
add wave F

#force clk 0 0, 1 10 -r 20
force x 0
force y 0
run 5

force reset 0
force x 0
force y 1
run 5


force x 1
force y 0
run 5


force x 1
force y 1
run 5

#force din 0000
#run 2
#force din(0) 1 2, 0 4 -r 4
#force din(1) 1 4, 0 8 -r 8
#force din(2) 2#1 8, 2#0 16 -r 16
#force din(3) 2#1 16, 2#0 32 -r 32

#run 34

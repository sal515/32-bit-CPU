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
force y 16#00000000

#Add test
force add_sub 0
run 2


force func 00
run 2
force func 01
run 2
force func 10
run 2
force func 11
run 2

force logic_func 00
run 2
force logic_func 01
run 2
force logic_func 10
run 2
force logic_func 11
run 2


#Sub test
force add_sub 1
run 2

force func 00
run 2
force func 01
run 2
force func 10
run 2
force func 11
run 2

force logic_func 00
run 2
force logic_func 01
run 2
force logic_func 10
run 2
force logic_func 11
run 2


force x 16#00000000
force y 16#FFFFFFFF

#Add test
force add_sub 0
run 2


force func 00
run 2
force func 01
run 2
force func 10
run 2
force func 11
run 2

force logic_func 00
run 2
force logic_func 01
run 2
force logic_func 10
run 2
force logic_func 11
run 2


#Sub test
force add_sub 1
run 2

force func 00
run 2
force func 01
run 2
force func 10
run 2
force func 11
run 2

force logic_func 00
run 2
force logic_func 01
run 2
force logic_func 10
run 2
force logic_func 11
run 2


force x 16#FFFFFFFF
force y 16#FFFFFFFF

#Add test
force add_sub 0
run 2


force func 00
run 2
force func 01
run 2
force func 10
run 2
force func 11
run 2

force logic_func 00
run 2
force logic_func 01
run 2
force logic_func 10
run 2
force logic_func 11
run 2


#Sub test
force add_sub 1
run 2

force func 00
run 2
force func 01
run 2
force func 10
run 2
force func 11
run 2

force logic_func 00
run 2
force logic_func 01
run 2
force logic_func 10
run 2
force logic_func 11
run 2



#overflow test

force func 10


force x 16#7FFFFFFF
force y 16#7FFFFFFF
force add_sub 0
run 2
force add_sub 1
run 2

force x 16#80000000
force y 16#FFFFFFFF
force add_sub 0
run 2
force add_sub 1
run 2

force x 16#FFFFFFFF
force y 16#FFFFFFFF
force add_sub 0
run 2
force add_sub 1
run 2

force x 16#7FFFFFFF
force y 16#AAAAAAAA
force add_sub 0
run 2
force add_sub 1
run 2

force x 16#AAAAAAAA
force y 16#7FFFFFFF
force add_sub 0
run 2
force add_sub 1
run 2





#force din 0000
#run 2
#force din(0) 1 2, 0 4 -r 4
#force din(1) 1 4, 0 8 -r 8
#force din(2) 2#1 8, 2#0 16 -r 16
#force din(3) 2#1 16, 2#0 32 -r 32
restart -f   -- to reset values

add wave *

force s 0
force in0 16#00000011
force in1 16#00001100
run 2

force s 1
force in0 16#00000011
force in1 16#00001100
run 2
restart -f   -- to reset values

add wave *



force sign_extend_in 16#0000
force func 00
run 5

force sign_extend_in 16#0000
force func 01
run 5

force sign_extend_in 16#0000
force func 10
run 5

force sign_extend_in 16#0000
force func 11
run 5


force sign_extend_in 16#FFFF
force func 00
run 5

force sign_extend_in 16#FFFF
force func 01
run 5

force sign_extend_in 16#FFFF
force func 10
run 5

force sign_extend_in 16#FFFF
force func 11
run 5


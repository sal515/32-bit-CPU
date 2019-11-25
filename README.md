----------------------------------------
Source modelsim: 
source /CMC/ENVIRONMENT/modelsim.env
Run modelsim:
& vsim
----------------------------------------
Source RTL:
source /CMC/ENVIRONMENT/fpga_advantage.env
Run RTL:
precision &
----------------------------------------
Source ISE generator:
source /CMC/ENVIRONMENT/xilinx.env
Run ISE Generator:
ise &

----------------------------------------
32-bit-CPU

===ALU===
vcom alu.vhd
- Must add the -novopt for disable optimization of simulation
vsim -novopt -do ./alu_tester.do alu

===REGISTER===

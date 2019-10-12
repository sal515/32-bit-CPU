----------------------------------------
Source modelsim: 
source /CMC/ENVIRONMENT/modelsim.env
Run modelsim:
& vsim
----------------------------------------
Source RTL:
source /CMC/ENVIRONMENT/fpga_advantage.env
Run RTL:
source /CMC/ENVIRONMENT/fpga_advantage.env
----------------------------------------
Source ISE generator:

Run ISE Generator:

----------------------------------------
32-bit-CPU

===ALU===
vcom alu_architecture.vhd
- Must add the -novopt for disable optimization of simulation
vsim -novopt -do ./alu_tester.do alu

===REGISTER===

all: Main.v
	iverilog Main.v -o Processor

run: Processor
	./Processor

gtk: MIPS.vcd
	gtkwave MIPS.vcd

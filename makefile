all: Main.v
	iverilog Main.v -o Compilado

teste: Main.v teste MIPS.vcd
	iverilog Main.v -o teste
	./teste
	gtkwave MIPS.vcd

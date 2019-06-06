`include "Modulos/ALU.v"
`include "Modulos/AND.v"
`include "Modulos/ControleALU.v"
`include "Modulos/Controller.v"
`include "Modulos/Data_Memory.v"
`include "Modulos/Ext_Sinal.v"
`include "Modulos/LeftShift2.v"
`include "Modulos/Memoria_instrucoes.v"
`include "Modulos/MUX.v"
`include "Modulos/PC.v"
`include "Modulos/Registradores.v"
`include "Modulos/Somador.v"
`include "Modulos/Somador4.v"

module main();
  reg clk;
  reg [31:0] PCIn = 0;
  wire [31:0] PCOut;
  wire [31:0] Saida_Somador4;
  wire [31:0] Instrucao;
  wire [1:0] branch;
  wire MemRead;
  wire RegDst;
  wire memToReg;
  wire [1:0] ALUOp;
  wire regWrite;
  wire memWrite;
  wire ALUSrc;
  wire [4:0] writeRegister;
  wire [31:0] Read_Data1_Regs_Out;
  wire [31:0] Read_Data2_Regs_Out;
  wire [31:0] writeData;
  wire [31:0] Signal_Extented;
  wire [31:0] ALUIn;
  wire [3:0] OP_ALU_IN;
  wire [31:0] ALUResult;
  wire FlagZero;
  wire [31:0] Read_DataMemory_Out;
  wire [31:0] Left_Shifted2;
  wire [31:0] Somador2_Out;
  wire Door_Out;
  wire [31:0] NextPC;

  PC pc(.clk(clk),.entrada(PCIn),.saida(PCOut));

  Somador4 Soma4(.a(PCOut),.saida(Saida_Somador4));

  Memoria_instrucoes Inst_Mem(.endereco(PCOut),.instrucao(Instrucao));

  Controller controll(.Opcode(Instrucao[31:26]),.RegDst(RegDst),.Branch(branch),.MemRead(MemRead),.MemtoReg(memToReg),.ALUOp(ALUOp),.MemWrite(memWrite),.ALUSrc(ALUSrc),.RegWrite(regWrite));

  MUX_5b mux5b_1(.controle(RegDst),.entrada1(Instrucao[20:16]),.entrada2(Instrucao[15:11]),.saida(writeRegister));

  Registradores Regs(.clk(clk),.RegWrite(regWrite),.ReadReg1(Instrucao[25:21]),.ReadReg2(Instrucao[20:16]),.WriteReg(writeRegister),.WriteData(writeData),.ReadData1(Read_Data1_Regs_Out),.ReadData2(Read_Data2_Regs_Out));

  Ext_Sinal Signal_Extenteder(.entrada(Instrucao[15:0]),.saida(Signal_Extented));

  MUX_32b mux32b_2(.controle(ALUSrc),.entrada1(Read_Data2_Regs_Out),.entrada2(Signal_Extented),.saida(ALUIn));

  ControleALU Control_ALU(.OpCode_ALU(ALUOp),.Func_Code(Instrucao[5:0]),.Controle_ALU(OP_ALU_IN));

  ALU ALU_1(.controle(OP_ALU_IN),.a(Read_Data1_Regs_Out),.b(ALUIn),.zero(FlagZero),.saida(ALUResult));

  Data_Memory Data_Mem(.Clk(clk),.MemWrite(memWrite),.MemRead(MemRead),.Address(ALUResult),.WriteData(Read_Data2_Regs_Out),.ReadData(Read_DataMemory_Out));

  MUX_32b mux32b_3 (.controle(memToReg),.entrada1(ALUResult),.entrada2(Read_DataMemory_Out),.saida(writeData));

  LeftShift2 Left_shift(.entrada(Signal_Extented),.saida(Left_Shifted2));

  Somador ADD_1(.a(Saida_Somador4),.b(Left_Shifted2),.saida(Somador2_Out));

  Door_BNE_BEQ Door1(.branch(branch),.flag(FlagZero),.out(Door_Out));

  MUX_32b mux32b_4(.controle(Door_Out),.entrada1(Saida_Somador4),.entrada2(Somador2_Out),.saida(NextPC));

initial begin
  $dumpfile("MIPS.vcd");
  $dumpvars;
end

initial begin
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
  #1	clk = 1;
  #1	clk = 0;
end

initial begin
  $monitor("\nInstrucao: %b\nSaida PC:  %b\nSaida ALU: %b\n",Instrucao,PCOut,ALUResult);
end

always @ (negedge clk) begin
	#2 PCIn <= NextPC;
end
endmodule //

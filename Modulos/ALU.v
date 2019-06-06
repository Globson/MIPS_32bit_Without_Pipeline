`define ALU_ADD 4'b0000
`define ALU_SUB 4'b0010
`define ALU_AND 4'b0100
`define ALU_OR  4'b0101
`define ALU_NOR 4'b0110
`define ALU_XOR 4'b0111
`define ALU_SLT 4'b1000

module ALU (controle,a,b,zero,saida);
  input wire [3:0]controle;
  input wire [31:0]a;
  input wire [31:0]b;
  output reg [31:0]saida;
  output zero;
  always @ (a or b or controle) begin
    case (controle)
      `ALU_ADD: saida <= a + b;
      `ALU_SUB: saida <= a - b;
      `ALU_AND: saida <= a & b;
      `ALU_OR:  saida <= a | b;
      `ALU_NOR: saida <= ~(a | b);
      `ALU_XOR: saida <= a ^ b;
      `ALU_SLT: saida <= a < b ? 1 : 0; // seta 1 caso a < b, caso contrario 0.//
      default: saida <= 0;
    endcase
  end
  assign zero = (saida == 0);
endmodule //ALU

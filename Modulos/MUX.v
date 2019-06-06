//Mux de 2 entradas de 32bits
module MUX_32b (controle,entrada1,entrada2,saida);
  input controle;
  input [31:0]entrada1;
  input [31:0]entrada2;
  output [31:0]saida;
  assign saida = (controle == 0) ? entrada1 : entrada2;
endmodule //MUX_32b

//Mux de 2 entradas de 5bits
module MUX_5b (controle,entrada1,entrada2,saida);
  input controle;
  input [4:0]entrada1;
  input [4:0]entrada2;
  output [4:0]saida;
  assign saida = (controle == 0) ? entrada1 : entrada2;
endmodule //MUX_5b

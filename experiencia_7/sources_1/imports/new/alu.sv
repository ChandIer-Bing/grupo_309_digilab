`timescale 1ns / 1ps


module alu
#(parameter
bits = 8)
(
    input logic [bits-1:0] A, B,
    input logic [1:0] op,
    output logic [bits:0] res,      // el resultado es de un bit más de lo "necesario", para determinar
                                    // si hubo overflow o underflow con aquel bit extra.
                                    
    output logic invalido            // si es distinto de 0, es inválido.
);
  
always_comb begin
    invalido = res[bits];
    case(op)
        2'b00: res = A+B;
        2'b01: res = A-B;
        2'b10: res = A&B;
        2'b11: res = A|B;
        default : begin
            res = 0;
            invalido = 1;
            end
    endcase
end
    
endmodule

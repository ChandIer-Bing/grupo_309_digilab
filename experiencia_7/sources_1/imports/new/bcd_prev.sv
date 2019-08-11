`timescale 1ns / 1ps



module bcd_prev(
    input logic [3:0] op,
    input logic [7:0] res, A, B,
    output logic [7:0] anodo,
    output logic [3:0] d1, d2, d3, d4
    );
    
    always_comb begin
        case(op)
            4'b1000: begin
                anodo = ~8'b0000_0011;
                d3 = res[7:4];
                d4 = res[3:0];
                d1 = 'b0;
                d2 = 'b0;
                end
            4'b0100: begin
                anodo = ~8'b0000_0011;
                d3 = res[7:4];
                d4 = res[3:0];
                d1 = 'b0;
                d2 = 'b0;
                end
            4'b0010: begin
                anodo = ~'b0;
                d1 = 'b0;
                d2 = 'b0;
                d3 = 'b0;
                d4 = 'b0;
                end
            4'b0001: begin
                anodo = ~'b0;
                d1 = 'b0;
                d2 = 'b0;
                d3 = 'b0;
                d4 = 'b0;
                end
            default: begin
                anodo = ~8'b0011_0011;
                d1 = B[7:4];
                d2 = B[3:0];
                d3 = A[7:4];
                d4 = A[3:0];
                end
        endcase
    end
endmodule
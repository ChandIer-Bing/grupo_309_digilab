`timescale 1ns / 1ps

// Module header:-----------------------------
module FSM
#(parameter
bits = 8)
(
	input logic clk, rst, next, undo, invalido,
	input logic [bits-1:0] SW, resultado,
	output logic [7:0] anodoIn,
	output logic [2:0] activar, op_number,
	output logic [bits-1:0] num_salida,
	output logic [1:0] LED_RG
	);

// next : Botón central
// undo : Botón abajo

//FSM states type:
enum logic [1:0] {Wait_OP1, Wait_OP2, Wait_OP3, Show_Result} state, next_state;

//Statements:--------------------------------

//FSM state register:
always_ff @(posedge clk, posedge rst)
if (rst) state <= Wait_OP1;
else state <= next_state;

//FSM combinational logic:
always_comb begin
    if (bits == 8)
        anodoIn = ~8'b1000_0111;
    else
        anodoIn = ~8'b1001_1111;
    next_state = state;
    activar = 3'b000;
    num_salida = 32'd0;
    LED_RG = 0;
    
    case (state)
        Wait_OP1: begin
            num_salida = SW;
            activar = 3'b001;
            op_number = 4'd1;
            if (next)
                next_state = Wait_OP2;
            else if (undo)
                next_state = Wait_OP1;
        end
    
        Wait_OP2: begin
            num_salida = SW;
            activar = 3'b010;
            op_number = 4'd2;
            if (next)
                next_state = Wait_OP3;
            else if (undo)
                next_state = Wait_OP1;
        end
    
        Wait_OP3: begin
            activar = 3'b100;
            anodoIn = ~8'b1000_0000;
            op_number = 4'd3;
            if (next)
                next_state = Show_Result;
            else if (undo)
                next_state = Wait_OP2;
        end
        
        Show_Result: begin
            num_salida = resultado;
            op_number = 4'd4;
            if (invalido) LED_RG = 2'b10;   // color rojo
            else LED_RG = 2'b01;            // color verde
            if (next)
                next_state = Wait_OP1;
            else if (undo)
                next_state = Wait_OP3;
        end
    endcase
end

endmodule
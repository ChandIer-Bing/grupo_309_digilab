`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2019 11:26:07 AM
// Design Name: 
// Module Name: dithering
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dithering	#(parameter vA = 69, vB=128, vC=192, vD=0, on=255, off=0)
					(	input logic [10:0] hc,vc,
						input logic [7:0]pixel_value,
						input logic clk, reset,
						output logic [7:0] d_pixval
						);

	logic 		[0:0] hpos,vpos;
	logic 		[10:0] old_hc,old_vc;
	enum logic  [1:0] {A,B,C,D} state;

	always_ff @(posedge clk) begin
		if (reset) {hpos,vpos} <= {1'b0,1'b0};
		
		old_hc <= hc;
		old_vc <= vc;

		if (old_hc != hc) hpos <= hpos + 1 ;
		if (old_vc != vc) vpos <= vpos + 1 ;
	end

	always_comb begin 
		state[0] = vpos;
		state[1] = hpos;
		case (state)

			A : begin
					if (pixel_value >= vA) d_pixval = on;
					else d_pixval = off;
				end 
			B : begin
					if (pixel_value >= vB) d_pixval = on;
					else d_pixval = off;
				end 
			C : begin
					if (pixel_value >= vC) d_pixval = on;
					else d_pixval = off;
				end 
			D : begin
					if (pixel_value >= vD) d_pixval = on;
					else d_pixval = off;
				end 

			default : d_pixval = pixel_value;
		endcase
	end
endmodule

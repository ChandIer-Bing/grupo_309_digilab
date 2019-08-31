`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2019 11:46:04 PM
// Design Name: 
// Module Name: RGB_dithering
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

module RGB_dithering (
						input  logic [10:0] hc,vc,
						input  logic [23:0] pixel,
						input  logic clk,reset,
						output logic dit_pixel
						);
	logic [7:0] R,G,B;
	logic  dR,dG,dB;
	assign R 		 = pixel[23:16];
    assign G 		 = pixel[15: 8];
    assign B 		 = pixel[ 7: 0];
    assign dit_pixel = {dR,dG,dB};


	dithering RED   (.hc(hc),.vc(vc),.pixel_value(R),.clk(clk),.reset(reset),.d_pixval(dR));
	dithering GREEN (.hc(hc),.vc(vc),.pixel_value(G),.clk(clk),.reset(reset),.d_pixval(dG));
	dithering BLUE  (.hc(hc),.vc(vc),.pixel_value(B),.clk(clk),.reset(reset),.d_pixval(dB));

endmodule
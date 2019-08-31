`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2019 02:19:06 AM
// Design Name: 
// Module Name: sobel
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

module sobel_kernel(
				input  logic [10:0] hc,vc, 					 //contadores horizontales y verticales
				input  logic [23:0] p0,p1,p2,p3,p4,p5,p6,p7,  //pixeles
                input  logic clk,reset,
                output logic [23:0] new_pix
				);
	logic [7:0] g0,g1,g2,g3,g4,g5,g6,g7;//valores en 'grayscale' para cada pixel
	real Gx,Gy,GG,MG; // si le pongo logic en ves de real me tira warning el $sqrt()
	
	grayscale (.pixel(p0),.gray_pix(),.gray(g0));
	grayscale (.pixel(p1),.gray_pix(),.gray(g1));
	grayscale (.pixel(p2),.gray_pix(),.gray(g2));
	grayscale (.pixel(p3),.gray_pix(),.gray(g3));
	grayscale (.pixel(p4),.gray_pix(),.gray(g4));
	grayscale (.pixel(p5),.gray_pix(),.gray(g5));
	grayscale (.pixel(p6),.gray_pix(),.gray(g6));
	grayscale (.pixel(p7),.gray_pix(),.gray(g7));

	always_comb begin
		Gx = g2-g0+2*(g4-g3)+g7-g5;
		Gy = g5-g0+2*(g6-g1)+g7-g2;
		GG = (Gx*Gx)+(Gy*Gy);
		MG = $sqrt(GG);
	end
endmodule
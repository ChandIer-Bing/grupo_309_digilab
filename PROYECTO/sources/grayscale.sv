`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2019 10:48:20 AM
// Design Name: 
// Module Name: grayscale
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
//mode AVERAGE = 0
//mode luminance = 1

module grayscale #(parameter mode = 0)(
                    input  logic [23:0]  pixel,
                    output logic [23:0]  gray_pix,
                    output logic [ 7:0]  gray
                    );

    logic [7:0] R,G,B;
    assign R = pixel[23:16];
    assign G = pixel[15: 8];
    assign B = pixel[ 7: 0];
    always_comb begin
        
        case(mode)
        
            0: gray = (R+G+B)*0.3333;
            1: gray = (R*0.2126 + G*0.7152 + B*0.0722);
        
        endcase
        gray_pix = {gray,gray,gray};
    end
endmodule

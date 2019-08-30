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
                    input logic R,G,B,
                    output logic GR,GG,GB
                    );
    logic gray;
    always_comb begin
        case(mode)
            0: begin
                gray = (R+G+B)*0.3333;
                GR = gray;
                 GG = gray;
                  GB = gray;
                end
            1: begin
                gray = (R*0.2126 + G*0.7152 + B*0.0722);
                GR = gray; 
                GG = gray;
                GB = gray;
               end
        endcase     
    end
endmodule

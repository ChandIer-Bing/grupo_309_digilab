`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2019 11:13:46 AM
// Design Name: 
// Module Name: color_scrambler
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



module color_scrambler( input  logic [23:0] pixel,
                        input  logic [3:0] swR,swG,swB,
                        output logic [23:0] sc_pixel
                        );

    logic  [7:0] R,G,B;
    logic  [7:0] csR,csG,csB;
    
    assign R 		= pixel[23:16];
    assign G 		= pixel[15: 8];
    assign B 		= pixel[ 7: 0];
    assign sc_pixel = {csR,csG,csB};

    scrambler RED  (.R(R),.G(G),.B(B),.SW(swR),.sout(csR));
    scrambler GREEN(.R(R),.G(G),.B(B),.SW(swG),.sout(csG));
    scrambler BLUE (.R(R),.G(G),.B(B),.SW(swB),.sout(csB));

endmodule

module scrambler (  input logic [7:0] R,G,B,
                    input logic [3:0] SW,
                    output logic [7:0] sout
                    );
    always_comb  begin
        case(SW)
            0 : sout = R;
            1 : sout = G;
            2 : sout = B;
            3 : sout = 0;
        endcase
    end
endmodule
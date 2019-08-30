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



module color_scrambler( input logic R,G,B,
                        input logic [3:0] swR,swG,swB,
                        output logic csR,csG,csB
                        );

    scrambler RED  (.R(R),.G(G),.B(B),.SW(swR),.sout(csR));
    scrambler GREEN(.R(R),.G(G),.B(B),.SW(swG),.sout(csG));
    scrambler BLUE (.R(R),.G(G),.B(B),.SW(swB),.sout(csB));

endmodule

module scrambler (  input logic R,G,B,
                    input logic [3:0] SW,
                    output logic sout
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
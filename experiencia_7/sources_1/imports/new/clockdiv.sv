`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Description: divisor del reloj
// 
//////////////////////////////////////////////////////////////////////////////////

module clockdiv
#(parameter COUNT_MAX = 20000)
(input logic clk_in,
input logic reset, 
output logic clk_out);

localparam delay_width = $clog2(COUNT_MAX);
logic [delay_width-1:0] counter = 'd0;

always_ff@(posedge clk_in) begin
    if (counter == COUNT_MAX-1) begin
        counter <= 'd0;
        clk_out <= ~clk_out;
    end else begin
        counter <= counter + 'd1;
        clk_out <= clk_out;
    end
end
endmodule

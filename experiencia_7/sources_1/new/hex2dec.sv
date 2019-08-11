`timescale 1ns / 1ps

module hex2dec
#(parameter
bits = 16)
(
    input logic clk, convert,
    input logic [bits-1:0] hex,
    output logic [31:0] out
);
    
    logic [31:0] dec;
    logic trigger = 1'b1;
    
	unsigned_to_bcd u32_to_bcd_inst (
		.clk(clk),
		.trigger(trigger),
		.in(hex),
		.idle(),
		.bcd(dec)
	);
	
	always_comb begin
	   out = hex;
	   if (convert) out = dec;
	   else out = hex;
	end
endmodule

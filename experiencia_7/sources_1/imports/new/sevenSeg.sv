`timescale 1ns / 1ps

module sevenSeg(
    input logic [3:0] bcd,
    output logic [6:0] seg
    );
    
    always_comb begin
        case(bcd)
            4'd0:       seg = ~7'b111_1110;
            4'd1:       seg = ~7'b011_0000;
            4'd2:       seg = ~7'b110_1101;
            4'd3:       seg = ~7'b111_1001;
            4'd4:       seg = ~7'b011_0011;
            4'd5:       seg = ~7'b101_1011;
            4'd6:       seg = ~7'b101_1111;
            4'd7:       seg = ~7'b111_0000;
            4'd8:       seg = ~7'b111_1111;
            4'd9:       seg = ~7'b111_0011;
            4'd10:       seg = ~7'b111_0111;
            4'd11:       seg = ~7'b001_1111;
            4'd12:       seg = ~7'b100_1110;
            4'd13:       seg = ~7'b011_1101;
            4'd14:       seg = ~7'b100_1111;
            4'd15:       seg = ~7'b100_0111;
            default:    seg = ~7'b000_0000;
        endcase
    end
endmodule

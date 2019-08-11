`timescale 1ns / 1ps

module bcd(
    input logic clk, reset,
    input logic [7:0] anodoIn,                              // Usados
    input logic [3:0] d1, d2, d3, d4, d5, d6, d7, d8,       // Dígitos
    output logic [7:0] anodoOut,                            // Ánodos que se prenden
    output logic [3:0] bcd                                  // 
    );
    
    logic [2:0] cont;
    
    always_ff @(posedge clk) begin
        if(reset)
            cont <= 3'b0;
        else
            cont <= cont+1;
    end
    
    always_comb begin
        case(cont)
            3'd0: begin
                if (anodoIn[0] == ~1'b1)
                    anodoOut = ~8'b0000_0001;
                else anodoOut = ~8'b0000_0000;
                bcd = d8;
                end
            3'd1: begin
                if (anodoIn[1] == ~1'b1)
                    anodoOut = ~8'b0000_0010;
                else anodoOut = ~8'b0000_0000;
                bcd = d7;
                end
            3'd2: begin
                if (anodoIn[2] == ~1'b1)
                    anodoOut = ~8'b0000_0100;
                else anodoOut = ~8'b0000_0000;
                bcd = d6;
                end
            3'd3: begin
                if (anodoIn[3] == ~1'b1)
                    anodoOut = ~8'b0000_1000;
                else anodoOut = ~8'b0000_0000;
                bcd = d5;
                end
            3'd4: begin
                if (anodoIn[4] == ~1'b1)
                    anodoOut = ~8'b0001_0000;
                else anodoOut = ~8'b0000_0000;
                bcd = d4;
                end
            3'd5: begin
                if (anodoIn[5] == ~1'b1)
                    anodoOut = ~8'b0010_0000;
                else anodoOut = ~8'b0000_0000;
                bcd = d3;
                end
            3'd6: begin
                if (anodoIn[6] == ~1'b1)
                    anodoOut = ~8'b0100_0000;
                else anodoOut = ~8'b0000_0000;
                bcd = d2;
                end
            3'd7: begin
                if (anodoIn[7] == ~1'b1)
                    anodoOut = ~8'b1000_0000;
                else anodoOut = ~8'b0000_0000;
                bcd = d1;
                end
        endcase
    end
endmodule

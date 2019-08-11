`timescale 1ns / 1ps

module reg_bank
#(parameter
 bits = 8 )
(
    input logic guardar, clk, rst, activar,
    input logic [bits-1:0] entrada, // SW
    output logic [bits-1:0] salida
    );
    
    logic [bits-1:0] temp;
    
   always_comb begin
   
            if(guardar & activar) 
                temp = entrada;
             else
                temp = salida;
            
   end
        
    always@(posedge clk or posedge rst)
    	if(rst)
    		salida <= 'b0;
    	else
    	   salida <= temp; 
    
endmodule
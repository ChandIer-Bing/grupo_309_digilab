`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	Mauricio Solis
// 
// Create Date: 05/21/2017 05:35:53 PM
// Design Name: 
// Module Name: templates
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


module templates(

    );
endmodule


module template_9x16_364x647( 	// horizontal x vertical
	input clk,
	input [11:0] hc,
	input [11:0] vc,
	output logic[2:0]matrix_x = 3'd0,	//coordenada X del cursor (en la matriz de la calculadora) ---> desde 0 hasta 5 ---> son 6 COLUMNAS
	output logic[1:0]matrix_y = 2'd0,	//coordenada Y del cursor (en la matriz de la calculadora) ---> desde 0 hasta 3 ---> y 4 FILAS
	output logic lineas					//dibuja las lineas en la grilla
	);

	localparam d_col = 8'b1_1001;		//25 ....agregar 2 ceros //25 * 6 = 150    // distancia entre lineas  
	localparam d_row = 7'b1_1001;		//25 ....agregar 2 ceros //25 * 4 = 100    // distancia entre filas
	localparam zeros_col = 2'd0;		// los 00 que se agregan alfinal de d_col para que sea 100
	localparam zeros_row = 2'd0;		// los 00 que se agregan alfinal de d_row para que sea 100
	
	logic [7:0]col = d_col;	
	logic [6:0]row = d_row;		
	logic [7:0]col_next;

	logic [6:0]row_next;
	
	logic [2:0]matrix_x_next; // : indica cual es el siguiente n° de columna 
	logic [1:0]matrix_y_next; // : indica cual es el siguiente n° de FILA

	logic [10:0]hc_template, vc_template; // contadores HORizontales , VERticales LOCALES del modulo
	
	
	parameter GRID_XI = 		330; // estos parametros no es necesario cambiarlos ya que se pueden modificar al instanciar el modulo
	parameter GRID_XF = 		694; // estos parametros no es necesario cambiarlos ya que se pueden modificar al instanciar el modulo
	
	parameter GRID_YI = 		61; // estos parametros no es necesario cambiarlos ya que se pueden modificar al instanciar el modulo
	parameter GRID_YF = 		708; // estos parametros no es necesario cambiarlos ya que se pueden modificar al instanciar el modulo

	// V--- si el hc GLOBAL esta 'dentro de la calculadora' entonces el hc_temp sige al hc pero retrasado en GRID_XF   ---V
					assign hc_template = ( (hc > GRID_XI) && (hc <= GRID_XF) )?hc - GRID_XI: 11'd0; //						hc : contador horizontal GLobal(del top module) | 
	// ^------------------------------------------------------------------------------------------------------------------^	

	// V--- si el vc GLOBAL esta 'dentro de la calculadora' entonces el hc_temp sige al hc pero retrasado en GRID_XF  ---v
	               assign vc_template = ( (vc > GRID_YI) && (vc <= GRID_YF) )?vc - GRID_YI: 11'd0; // 						vc : contador vertical GLobal(del top module)	|
	// ^-----------------------------------------------------------------------------------------------------------------^
	
	
	//                   Vv<----- para X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X X ------>vV
	always_comb															
		if(hc_template == 'd0) 											//fuera del rango visible ---> si el contador HORIZONTAL local esta en el punto INICIAL
			{col_next, matrix_x_next} = {d_col, 3'd0};  				//entonces la siguiente columna es la PRIMERA (1)

		else if(hc_template > {col, zeros_col})   						//Si el hc_temp esta dentro de la calculadora 
			{col_next, matrix_x_next} = {col + d_col, matrix_x + 3'd1}; // la next column es la sig (+100), y se actualiza el contador HORIZONTAL de la matriz(+1)
		
		else
			{col_next,matrix_x_next} = {col, matrix_x}; 				// si el hc_template esta en el rango visible pero fuera de la calculadora, la next_column es la primera, y la posicion de la matriz se va a 0 
	
	//					Vv>------ para Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y  -------<vV
	always_comb
		if(vc_template == 'd0)											// si el contador VERTICAL local esta en el punto INICIAL
			{row_next,matrix_y_next} = {d_row, 2'd0};					// entonces la siguiente FILA es la PRIMERA (1)

		else if(vc_template > {row, zeros_row})   						//Si el vc_template esta dentro de la calculadora
			{row_next, matrix_y_next} = {row + d_row, matrix_y + 2'd1}; // la next row es la sig (+100), y se actualiza el contador vertical de la matriz(+1)

		else
			{row_next, matrix_y_next} = {row, matrix_y};				// si el vc_template esta en el rango visible pero fuera de la calculadora, la next_row es la primera, y la posicion en la matriz se va a 0 
	
	
	//para generar las lineas divisorias.
	logic lin_v, lin_v_next;
	logic lin_h, lin_h_next;
	
	always_comb
	begin
		if(hc_template > {col, zeros_col})  //si hc_temp esta dentro de la calculadora
			lin_v_next = 1'b1;				// la sigiente columna 
		else
			lin_v_next = 1'b0;
			
		if(vc_template > {row, zeros_row})
			lin_h_next = 1'b1;
		else if(hc == GRID_XF)
			lin_h_next = 1'b0;
		else
			lin_h_next = lin_h;
	end
	
	
	always_ff@(posedge clk)
		{col, row, matrix_x, matrix_y} <= {col_next, row_next, matrix_x_next, matrix_y_next}; // en cada canto del CLK las segnales 'next' se convierten en lo que se esta mostrando en el momento
	
	always_ff@(posedge clk)
		{lin_v, lin_h} <= {lin_v_next, lin_h_next};// en cada canto del CLK las segnales 'next' se convierten en lo que se esta mostrando en el momento
		
	
	always_comb
		if( (hc == (GRID_XI + 11'd1)) || (hc == GRID_XF) ||(vc == (GRID_YI + 11'd1)) || (vc == GRID_YF) ) 

			lines = 1'b1;

		else if( (lin_v == 1'b1) || (lin_h == 1'b1))
			lines = 1'b1;
		else
			lines = 1'b0;

endmodule
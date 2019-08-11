`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2019 23:32:49
// Design Name: 
// Module Name: top_mod
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


module top_mod
#(parameter
bits = 16)
(
    input logic [bits-1:0] SW, // puede ser cambiado a 16 bits
    input logic CLK100MHZ, CPU_RESETN, BTNC, BTND, BTNU,
    output logic [7:0] AN,
    output logic [bits-1:0] LED, // puede ser cambiado a 16 bits
    output logic [6:0] seg,
    output logic LED17_R, LED17_G
    );
    
    logic clock, centro, abajo, arriba, invalido;
    
    logic [1:0] op, LED_RG;
    logic [7:0] anodoIn;
    logic [bits-1:0] num_salida, res, A, B; // pueden ser cambiados a 16 bits
    logic [31:0] num_salida2;
    logic [3:0] bcd, op_number;
    logic [2:0] activar;
    
    assign LED = SW;
    assign LED_RG = {LED17_R,LED17_G};
    
    
//    GLOBAL : divisor de reloj y debouncer de botones
    
    clockdiv #(102100) CKD(
        .clk_in(CLK100MHZ),
        .reset(~CPU_RESETN),
        .clk_out(clock)
    );
    
    pb_debouncer_counter DB_C(
        .clk(CLK100MHZ),.rst(~CPU_RESETN),
        .PB(BTNC),.PB_pressed_pulse(centro),
        .PB_pressed_status(),
        .PB_released_pulse()
    );
    pb_debouncer_counter DB_D(
        .clk(CLK100MHZ),.rst(~CPU_RESETN),
        .PB(BTND),.PB_pressed_pulse(abajo),
        .PB_pressed_status(),
        .PB_released_pulse()
    );
    pb_debouncer_counter DB_U(
        .clk(CLK100MHZ),.rst(~CPU_RESETN),
        .PB(BTNU),.PB_pressed_status(arriba),
        .PB_pressed_pulse(),
        .PB_released_pulse()
    );
    
    
//    FSM: Máquina de estado (parametrizado)
    
    FSM #(bits) FSM(
        .clk(CLK100MHZ), .rst(~CPU_RESETN),
        .SW(SW), .resultado(res),
        .next(centro), .undo(abajo), .invalido(invalido),
        .anodoIn(anodoIn),
        .activar(activar),
        .num_salida(num_salida), .op_number(op_number), .LED_RG(LED_RG)
    );
    
    
//    ALU : operaciones realizables (parametrizado)
    
    alu #(bits) ALU(
        .A(A),
        .B(B),
        .op(op),
        .res(res), .invalido(invalido)
    );
    
    
//    BANCOS: registros almacenados en la "memoria" (parametrizado)
    
    reg_bank #(bits) BNK_A(
        .clk(CLK100MHZ), .rst(~CPU_RESETN),
        .guardar(centro), .entrada(SW),
        .activar(activar[0]),
        .salida(A)
    );
    
    reg_bank #(bits) BNK_B(
        .clk(CLK100MHZ), .rst(~CPU_RESETN),
        .guardar(centro), .entrada(SW),
        .activar(activar[1]),
        .salida(B)
    );
    
    reg_bank #(2) BNK_OP(
        .clk(CLK100MHZ), .rst(~CPU_RESETN),
        .guardar(centro), .entrada(SW),
        .activar(activar[2]),
        .salida(op)
    );
    
//    HEX A DEC: conversor de hexadecimal a decimal mientras se pulse BTNU
    
    hex2dec #(bits) H2D(
        .clk(CLK100MHZ), .convert(arriba),
        .hex(num_salida), .out(num_salida2)
    );
    
    
//    DISPLAY: todo lo que tenga que ver con lo que se termina mostrando en los displays
    
    bcd TDM(
        .clk(clock), .reset(~CPU_RESETN),
        .anodoIn(anodoIn),
        .d1(op_number),
        .d2(),
        .d3(),
        .d4(num_salida2[19:16]),
        .d5(num_salida2[15:12]),
        .d6(num_salida2[11:8]),
        .d7(num_salida2[7:4]),
        .d8(num_salida2[3:0]),
        .anodoOut(AN),
        .bcd(bcd)
    );
    
    sevenSeg SEG(
        .bcd(bcd),
        .seg(seg)
    );
endmodule

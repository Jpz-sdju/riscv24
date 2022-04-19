`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/19 22:35:12
// Design Name: 
// Module Name: EXE
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

`include "para.vh"
module EXE(
        input [`DATA_WIDTH] a,
        input [`DATA_WIDTH] b,
        input [3:0] control,
        output [`DATA_WIDTH] res
    );
    Alu u_Alu(
    	.control (control ),
        .a       (a       ),
        .b       (b       ),
        .res     (res     )
    );
    
endmodule

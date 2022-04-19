`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/21 21:06:53
// Design Name: 
// Module Name: mux_RS1_OR_PC
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
module mux_RS1_OR_PC(
        input is_pc_rs1,
        input [`DATA_WIDTH] now_addr,
        input [`DATA_WIDTH] rs1,
        output reg [`DATA_WIDTH] a
    );
    always @(*) begin
        if(is_pc_rs1)begin
            a<=now_addr;

        end else begin
            a<=rs1;
        end
    end
endmodule

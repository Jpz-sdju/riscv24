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
        input [`width-1:0] rs1,
        input [`width-1:0] now_addr,
        output reg [`width-1:0] res_rs1
    );
    always @(*) begin
        if(is_pc_rs1)begin
            res_rs1<=now_addr;

        end else begin
            res_rs1<=rs1;
        end
    end
endmodule

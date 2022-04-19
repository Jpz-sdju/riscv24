`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/10 15:23:07
// Design Name:
// Module Name: Pc_Adder
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
module Pc_Adder (input [`DATA_WIDTH] now_addr,
                 output reg [`DATA_WIDTH] pc_plus_4);
    always @(*) begin
        pc_plus_4 <= now_addr +4;
    end
endmodule

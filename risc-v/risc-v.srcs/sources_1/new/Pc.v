`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/10 15:09:53
// Design Name:
// Module Name: Pc
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
module Pc (input clk,
           input rst,
           input [`DATA_WIDTH] next_addr,
           output reg [`DATA_WIDTH] now_addr,
           output reg clear);
    
    always @(posedge clk or negedge rst) begin
        if (~rst)
            clear <= 1'b0;
        else
            clear <= 1'b1;
    end
    
    
    always @(posedge clk) begin
        if (~clear)
            now_addr <= 32'b0;
        else
            now_addr <= next_addr;
    end
    
    
    
endmodule

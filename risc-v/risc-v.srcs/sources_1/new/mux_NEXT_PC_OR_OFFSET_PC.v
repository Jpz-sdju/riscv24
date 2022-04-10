`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/21 02:17:42
// Design Name:
// Module Name: mux_NEXT_PC_OR_OFFSET_PC
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
module mux_NEXT_PC_OR_OFFSET_PC(input pc_sel,
                                input [`DATA_WIDTH] next_addr,
                                input [`DATA_WIDTH] alu_res,
                                output reg [`DATA_WIDTH] res_addr);
    always @(*) begin
        if (pc_sel) begin
            res_addr <= alu_res;
        end else begin
            res_addr <= next_addr;
        end
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/21 12:54:24
// Design Name:
// Module Name: mux_RS2_OR_IMM
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
module mux_RS2_OR_IMM(input is_imm_rs2,
                      input [`DATA_WIDTH] extended_imm,
                      input [`DATA_WIDTH] rs2,
                      output reg [`DATA_WIDTH] res_rs2);
    always @(*) begin
        if (is_imm_rs2)begin
            res_rs2 <= extended_imm;
        end
        else begin
            res_rs2 <= rs2;
        end
        
    end
endmodule

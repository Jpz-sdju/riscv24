`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/21 17:45:26
// Design Name:
// Module Name: Imm_Extend
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
module Imm_Extend(input [`DATA_WIDTH] instruction,
                  input [2:0] extend_op,
                  output reg[`DATA_WIDTH] imm);
    always @(*) begin
        case (extend_op)
            3'b000: begin // ori lw immI
                imm <= {{20{instruction[31]}} , instruction[31:20]};
            end
            3'b001: begin // lui immU
                imm <= {instruction[31:12], 12'b0};
            end
            3'b010: begin // sw immS
                imm <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            3'b011: begin // beq immB
                imm <= {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            end
            3'b100: begin // jal immJ
                imm <= {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            end
            3'b101: begin // slli
                imm <= {{27{instruction[31]}}, instruction[24:20]};
            end
            3'b110: begin // no signed 
                imm <= {20'b0 , instruction[31:20]};
            end
            
        endcase
    end
    
endmodule

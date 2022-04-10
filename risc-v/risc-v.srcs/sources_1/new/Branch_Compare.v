`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/22 14:22:58
// Design Name:
// Module Name: Branch_Compare
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
module Branch_Compare(input [`DATA_WIDTH] rs1,
                      input [`DATA_WIDTH] rs2,
                      input is_unsigned,
                      output reg less_than,
                      output reg equal
                      );
    
    always @(*) begin
        less_than <= 0;
        equal     <= 0;
        if (~is_unsigned) begin
            if (rs1<rs2) begin
                less_than <= 1;
                end else if (rs1 == rs2)begin
                equal <= 1;
            end
        end
        
    end
endmodule

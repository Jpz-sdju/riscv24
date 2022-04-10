`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/10 17:03:51
// Design Name:
// Module Name: Alu
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
module Alu(input [3:0] control,
           input [`DATA_WIDTH] a,
           input [`DATA_WIDTH] b,
           output reg [`DATA_WIDTH] res);
always @(*) begin
    case (control)
        4'b0000: begin //add
            res <= a+b;
        end
        4'b0001: begin
            res <= a-b;
        end
        4'b0010:begin
            res <= (a*b) >>32;
        end
        4'b0011:begin
            res <= a/b;
        end
        4'b0100:begin
            res <= a<<b;
        end
        4'b0101:begin
            res <= a>>b;
        end
        4'b0110:begin
            res <= a | b;
        end
        4'b0111:begin
            res <=a & b;
        end
        4'b1000:begin
            res <= a ^ b;
        end
        4'b1001:begin
            if(a<b) res <=32'b0000_0000_0000_0000_0000_0000_0000_0001;
            else res <=0;
        end
        4'b1010:begin
            res <= (a>=b);
        end
        4'b1011:begin   //+0
            res<=a;
        end
        4'b1100:begin   //+0
            res<=b;
        end
    endcase
end
endmodule

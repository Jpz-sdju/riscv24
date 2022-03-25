`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/22 14:09:03
// Design Name:
// Module Name: mux_RD_3_1
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
module mux_RD_3_1(input [1:0] rd_select,
                  input [`width-1:0] alu_res,
                  input [`width-1:0] dmem,
                  input [`width-1:0] next_addr,
                  output reg [`width-1:0] res_rd);
always @(*) begin
    case (rd_select)
        2'b00: begin    //alu
            res_rd <= alu_res;
        end
        2'b01:begin
            res_rd <= next_addr;
        end
        2'b10:begin 
            res_rd <= dmem;
        end
        2'b11:begin //low 8
            res_rd <= {{24{dmem[7]}},dmem[7:0]};
        end
    endcase
end

endmodule

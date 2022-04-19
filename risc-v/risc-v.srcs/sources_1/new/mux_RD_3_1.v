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
                  input [`DATA_WIDTH] alu_res,
                  input [`DATA_WIDTH] dmem_data,
                  input [`DATA_WIDTH] pc_plus_4,
                  output reg [`DATA_WIDTH] write_back_data);
always @(*) begin
    case (rd_select)
        2'b00: begin    //alu
            write_back_data <= alu_res;
        end
        2'b01:begin
            write_back_data <= pc_plus_4;
        end
        2'b10:begin 
            write_back_data <= dmem_data;
        end
        2'b11:begin //low 8
            write_back_data <= {{24{dmem_data[7]}},dmem_data[7:0]};
        end
    endcase
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/19 18:51:55
// Design Name:
// Module Name: Register_File
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
module Register_File(input sys_rst,                   //dismiss
                     input [4:0] read_addr1,          //
                     input [4:0] read_addr2,          //同上2
                     input write_enable,              //
                     input [4:0] write_addr,          //
                     input [`DATA_WIDTH] write_data,  //
                     output reg [`DATA_WIDTH] rdata1,  //输出1
                     output reg [`DATA_WIDTH] rdata2); //同上2
    reg [`DATA_WIDTH] regs[0:31];
    integer i;
    
    always @(*) begin
        if (~sys_rst)begin
            
            rdata1 <= 0;   //bug1:not initialized
            rdata2 <= 0;
        end
        else if (write_enable &&(write_addr != 5'b00000))  begin
            regs[write_addr] <= write_data;
        end
        else begin
            rdata1 <= regs[read_addr1];
            rdata2 <= regs[read_addr2];
        end
    end
endmodule

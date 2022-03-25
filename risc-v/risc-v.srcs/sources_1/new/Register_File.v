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
module Register_File(input rst,                      //dismiss 
                     input [4:0] read_addr1,         //读端口地�???1
                     input [4:0] read_addr2,         //同上2
                     input write_enable,             //写使�???
                     input [4:0] write_addr,         //写地�???
                     input [`width-1:0] write_data,  //写数�???
                     output reg [`width-1:0] data1,  //输出1
                     output reg [`width-1:0] data2); //同上2
    reg [`width -1:0] regs[0:31];
    integer i;
    always @(*) begin
        if (rst && write_enable &&(write_addr != 5'b00000))  begin
            regs[write_addr] <= write_data;
        end
        
    end
    always @(*) begin
        if (~rst)begin
            for (i = 0 ;i<32 ;i = i+1)
                regs[i] <= 0;
                data1   <= 0;   //bug1:not initialized
                data2   <= 0;
        end
        else begin
            data1 <= regs[read_addr1];
            data2 <= regs[read_addr2];
        end
    end
endmodule

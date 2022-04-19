`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/04/19 23:04:07
// Design Name:
// Module Name: MEM_WB
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
module MEM_WB(input sys_rst,
              input [`DATA_WIDTH] alu_res,
              input [`DATA_WIDTH] pc_plus_4,
              input write_enable,
              input [1:0] rd_select,
              input [`DATA_WIDTH] rs2,
              output [`DATA_WIDTH] write_back_data,
              input [2:0] vmem_addr,
              output [`DATA_WIDTH] vmem_data
              );
    wire [`DATA_WIDTH] dmem_data;

    Data_Memory u_Data_Memory(
    .sys_rst      (sys_rst),
    .data_addr    (alu_res),
    .write_enable (write_enable),
    .write_data   (rs2),
    .out_data     (dmem_data),
    .vmem_data    (vmem_data),
    .vmem_addr    (vmem_addr)
    );
    
    mux_RD_3_1 u_mux_RD_3_1(
    .rd_select (rd_select),
    .alu_res   (alu_res),
    .dmem_data      (dmem_data),
    .pc_plus_4 (pc_plus_4),
    .write_back_data    (write_back_data)
    );
    
endmodule

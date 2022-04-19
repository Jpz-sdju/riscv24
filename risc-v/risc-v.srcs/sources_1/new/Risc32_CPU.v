`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/22 16:02:22
// Design Name:
// Module Name: Risc32_CPU
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
module Risc32_CPU(input sys_clk,
                  input sys_rst,
                  output [`DATA_WIDTH] vmem_data,
                  input [2:0] vmem_addr);
    wire [`DATA_WIDTH] alu_res;
    wire pc_sel;
    wire [`DATA_WIDTH] now_addr;
    wire [`DATA_WIDTH] pc_plus_4;
    wire [`DATA_WIDTH] instruction;

    wire [`DATA_WIDTH] write_back_data;
    wire [1:0] rd_select;
    wire [`DATA_WIDTH] a;
    wire [`DATA_WIDTH] b;
    wire [3:0] alu_control;
    wire is_write_mem;


    wire [`DATA_WIDTH] write_data;
    IF u_IF(
    .sys_clk     (sys_clk),
    .sys_rst     (sys_rst),
    .alu_res     (alu_res),
    .pc_sel      (pc_sel),
    .now_addr    (now_addr),
    .pc_plus_4   (pc_plus_4),
    .instruction (instruction)
    );
    
    ID u_ID(
    .sys_rst         (sys_rst),
    .instruction     (instruction),
    .now_addr        (now_addr),
    .write_back_data (write_back_data),
    .pc_sel          (pc_sel),
    .is_write_mem     (is_write_mem),
    .rd_select       (rd_select),
    .a               (a),
    .b               (b),
    .alu_control     (alu_control),
    .write_data(write_data)
    );
    EXE u_EXE(
    .a       (a),
    .b       (b),
    .control (alu_control),
    .res     (alu_res)
    );
    MEM_WB u_MEM_WB(
    .sys_rst         (sys_rst),
    .alu_res         (alu_res),
    .pc_plus_4       (pc_plus_4),
    .write_enable    (is_write_mem),
    .rd_select       (rd_select),
    .rs2             (write_data),
    .write_back_data (write_back_data),
    .vmem_addr       (vmem_addr),
    .vmem_data       (vmem_data)
    );
    
endmodule

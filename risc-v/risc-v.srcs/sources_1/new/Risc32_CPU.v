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
module Risc32_CPU(input clk,
                  input rst,
                  output [31:0] vmem_data,
                  input [1:0] vmem_addr);
    wire [`DATA_WIDTH] now_addr;
    wire [`DATA_WIDTH] next_addr;
    wire pc_sel;
    wire [`DATA_WIDTH] alu_res;
    wire [`DATA_WIDTH] res_addr;
    Pc pc0(
    .clk(clk),
    .rst(rst),
    .next_addr(res_addr),   //bug2:next_addr pluged pcadder not mux!
    .now_addr(now_addr)
    );
    Pc_Adder pc_adder(
    .now_addr(now_addr),
    .next_addr(next_addr)
    );
    mux_NEXT_PC_OR_OFFSET_PC mux_next_pc_or_offset(
    .pc_sel(pc_sel),
    .next_addr(next_addr),
    .alu_res(alu_res),
    .res_addr(res_addr)
    );
    // wire [`DATA_WIDTH] instruction_addr;
    wire [`DATA_WIDTH] instruction;
    Instruction_Memory u_Instruction_Memory(
    .rst              (rst),
    .instruction_addr (now_addr),
    .instruction      (instruction)
    );
    
    wire less_than;
    wire equal;
    wire jump;
    wire [3:0] alu_control;
    wire is_unsigned;
    wire is_pc_rs1;
    wire is_imm_rs2;
    wire is_write_mem;
    wire is_write_reg;
    wire [2:0] extend_op;
    wire [1:0] rd_select;
    Instruction_Decode u_Instruction_Decode(
    .rst          (rst),
    .instruction  (instruction),
    .less_than    (less_than),
    .equal        (equal),
    .pc_sel       (pc_sel),
    .jump         (jump),
    .is_unsigned  (is_unsigned),
    .is_pc_rs1    (is_pc_rs1),
    .is_imm_rs2   (is_imm_rs2),
    .is_write_reg (is_write_reg),
    .is_write_mem (is_write_mem),
    .alu_control  (alu_control),
    .extend_op    (extend_op),
    .rd_select    (rd_select)
    );
    
    wire [4:0] read_addr1 = instruction[19:15];
    wire [4:0] read_addr2 = instruction[24:20];
    wire [4:0] write_addr = instruction[11:7];
    
    
    
    //vmem signals
    
    
    wire [`DATA_WIDTH] rs1;
    wire [`DATA_WIDTH] rs2;
    wire [`DATA_WIDTH] res_rd;
    Register_File u_Register_File(
    .rst          (rst),
    .read_addr1   (read_addr1),
    .read_addr2   (read_addr2),
    .write_enable (is_write_reg),
    .write_addr   (write_addr),
    .write_data   (res_rd),
    .data1        (rs1),
    .data2        (rs2)
    );
    Branch_Compare u_Branch_Compare(
    .rs1         (rs1),
    .rs2         (rs2),
    .is_unsigned (is_unsigned),
    .less_than   (less_than),
    .equal       (equal)
    );
    wire [`DATA_WIDTH] dmem;
    mux_RD_3_1 u_mux_RD_3_1(
    .rd_select (rd_select),
    .alu_res   (alu_res),
    .dmem      (dmem),
    .next_addr (next_addr),
    .res_rd    (res_rd)
    );
    wire [`DATA_WIDTH] res_rs1;
    mux_RS1_OR_PC u_mux_RS1_OR_PC(
    .is_pc_rs1 (is_pc_rs1),
    .rs1       (rs1),
    .now_addr  (now_addr),
    .res_rs1   (res_rs1)
    );
    wire [`DATA_WIDTH] res_rs2;
    wire [`DATA_WIDTH] extended_imm;
    mux_RS2_OR_IMM u_mux_RS2_OR_IMM(
    .is_imm_rs2   (is_imm_rs2),
    .extended_imm (extended_imm),
    .rs2          (rs2),
    .res_rs2      (res_rs2)
    );
    Alu u_Alu(
    .control (alu_control),
    .a       (res_rs1),
    .b       (res_rs2),
    .res     (alu_res)
    );
    
    Imm_Extend u_Imm_Extend(
    .instruction  (instruction),
    .extend_op (extend_op),
    .imm       (extended_imm)
    );
    
    Data_Memory u_Data_Memory(
    .rst          (rst),
    .data_addr    (alu_res),
    .write_enable (is_write_mem),
    .write_data   (rs2),
    .out_data     (dmem),
    .vmem_data(vmem_data),
    .vmem_addr(vmem_addr)
    );
    
    
    
    
    
    
    
    
endmodule

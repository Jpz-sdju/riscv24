`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/04/19 22:34:56
// Design Name:
// Module Name: ID
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
module ID(input sys_rst,
          input [`DATA_WIDTH] instruction,
          input [`DATA_WIDTH] now_addr,
          input [`DATA_WIDTH] write_back_data,
          output pc_sel,
          output is_write_mem,
          output [1:0] rd_select,
          output [`DATA_WIDTH] a,
          output [`DATA_WIDTH] b,
          output [3:0] alu_control,
          output [`DATA_WIDTH]write_data
          );
    wire is_pc_rs1;
    wire is_imm_rs2;
    wire is_write_reg;

    
    
    //singals for mux
    wire [`DATA_WIDTH] extended_imm;
    
    //signals for regfile
    wire [4:0] read_addr1 = instruction[19:15];
    wire [4:0] read_addr2 = instruction[24:20];
    wire [4:0] write_addr = instruction[11:7];
    wire [`DATA_WIDTH] rdata1;
    wire [`DATA_WIDTH] rdata2;

    //signals for branch compare
    wire is_unsigned;
    wire less_than;
    wire equal;

    //signals for alu and extendop
    wire [2:0] extend_op;


    //signals for mem_WB
    assign write_data = rdata2;
    Instruction_Decode u_Instruction_Decode(
    .sys_rst      (sys_rst),
    .instruction  (instruction),
    .less_than    (less_than),
    .equal        (equal),
    .pc_sel       (pc_sel),
    .is_unsigned  (is_unsigned),
    .is_pc_rs1    (is_pc_rs1),
    .is_imm_rs2   (is_imm_rs2),
    .is_write_reg (is_write_reg),
    .is_write_mem (is_write_mem),
    .alu_control  (alu_control),
    .extend_op    (extend_op),
    .rd_select    (rd_select)
    );
    Register_File u_Register_File(
    .sys_rst      (sys_rst),
    .read_addr1   (read_addr1),
    .read_addr2   (read_addr2),
    .write_enable (is_write_reg),
    .write_addr   (write_addr),
    .write_data   (write_back_data),
    .rdata1        (rdata1),
    .rdata2        (rdata2)
    );
    mux_RS1_OR_PC u_mux_RS1_OR_PC(
    .is_pc_rs1 (is_pc_rs1),
    .now_addr  (now_addr),
    .rs1       (rdata1),
    .a   (a)
    );
    
    mux_RS2_OR_IMM u_mux_RS2_OR_IMM(
    .is_imm_rs2   (is_imm_rs2),
    .extended_imm (extended_imm),
    .rs2          (rdata2),
    .b      (b)
    );
    Imm_Extend u_Imm_Extend(
    .instruction (instruction),
    .extend_op   (extend_op),
    .imm         (extended_imm)
    );
    
    Branch_Compare u_Branch_Compare(
    .rs1         (a),
    .rs2         (b),
    .is_unsigned (is_unsigned),
    .less_than   (less_than),
    .equal       (equal)
    );
    
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/19 22:34:43
// Design Name: 
// Module Name: IF
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
module IF(
    input sys_clk,
    input sys_rst,
    input [`DATA_WIDTH] alu_res,
    input pc_sel,
    output [`DATA_WIDTH] now_addr,
    output [`DATA_WIDTH] instruction
    );
    wire [`DATA_WIDTH] next_addr;
    wire [`DATA_WIDTH] res_addr;
    Pc u_Pc(
    	.sys_clk   (sys_clk   ),
        .sys_rst   (sys_rst   ),
        .next_addr (res_addr ),
        .now_addr  (now_addr  )
    );
    Pc_Adder u_Pc_Adder(
    	.now_addr  (now_addr  ),
        .next_addr (next_addr )
    );
    mux_NEXT_PC_OR_OFFSET_PC u_mux_NEXT_PC_OR_OFFSET_PC(
    	.pc_sel    (pc_sel    ),
        .next_addr (next_addr ),
        .alu_res   (alu_res   ),
        .res_addr  (res_addr  )
    );
    Instruction_Memory u_Instruction_Memory(
    	.sys_rst          (sys_rst          ),
        .instruction_addr (now_addr ),
        .instruction      (instruction      )
    );
    
endmodule

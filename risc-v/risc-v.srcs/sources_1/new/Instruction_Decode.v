`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/10 16:30:35
// Design Name:
// Module Name: Instruction_Decode
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
module Instruction_Decode(input rst,
                          input [`DATA_WIDTH] instruction,
                          input less_than,
                          input equal,
                          output reg pc_sel,
                          output  jump,
                          output reg is_unsigned,         //判断无符号数比较
                          output reg is_pc_rs1,           //rs1可为pc
                          output reg is_imm_rs2,          //判断rs2是否为imm
                          output reg is_write_reg,        //是否为写寄存器堆
                          output reg is_write_mem,        //是否为写data mem
                          output reg [3:0] alu_control,
                          output reg [2:0] extend_op,     //立即数扩展method
                          output reg [1:0] rd_select);    //选择进入regfile写端的是alu or pcadder or dmem
    wire [6:0] opcode = instruction[6:0];            //opcode
    wire [2:0] funct3 = instruction[14:12];        //func3
    wire [6:0] funct7 = instruction[31:25];        //funct7
    reg [1:0] branch_type;            //00->beq 01->bge 10->blt 11 ->bne
    assign jump=(opcode[6] && opcode[5] && ~opcode[4] && opcode[3] && opcode[2] && opcode[1] && opcode[0])|(opcode[6] && opcode[5] && ~opcode[4] && ~opcode[3] && opcode[2] && opcode[1] && opcode[0]);
    always @(*) begin
        if (jump)begin
            pc_sel <= 1;
            end else if (branch_type == 2'b00 && equal) begin
            pc_sel <= 1;
            end else if (branch_type == 2'b01 && ~less_than) begin    //greater_equal is equal to ~less_than,excellent!
            pc_sel <= 1;
        end
    end
    
    always @(*) begin
        if (~rst)begin
            is_unsigned <= 0;
            pc_sel <=0;
            // is_write_reg <= 0;
            // is_write_mem <= 0;
        end
        else begin
            
            is_write_mem <= 0;
            is_write_reg <= 0;
            is_pc_rs1    <= 0;
            is_imm_rs2   <= ~(~opcode[6] && opcode[5] && opcode[4] && ~opcode[3] && ~opcode[2] && opcode[1] && opcode[0]); //判断是否为带有立即数的指令，决定rs2为rs2还是extended imm
            is_unsigned  <= 0;
            rd_select    <= 2'b00;
            extend_op    <= 3'b111;
            case (opcode)
                7'b0110011:begin    //R type
                    is_write_reg <= 1;
                    case(funct7)
                        7'b0000000:begin    //r common
                            case(funct3)
                                3'b000:begin    //add
                                    alu_control <= 4'b0000;
                                end
                                3'b001:begin    //sll
                                    alu_control <= 4'b0100;
                                end
                                3'b010:begin    //slt
                                    alu_control <= 4'b1001;
                                end
                                3'b011:begin    //sltu
                                    alu_control <= 4'b1001;
                                end
                                3'b100:begin    //xor
                                    alu_control <= 4'b1000;
                                end
                                3'b101:begin    //srl
                                    alu_control <= 4'b0101;
                                end
                                3'b110:begin    //or
                                    alu_control <= 4'b0110;
                                end
                                3'b111:begin    //and
                                    alu_control <= 4'b0111;
                                end
                            endcase
                        end
                        7'b0100000:begin //sub
                            alu_control <= 4'b0001;
                        end
                    endcase
                end
                7'b0010011:begin    //I type common
                    is_write_mem <= 0;
                    is_write_reg <= 1;
                    is_pc_rs1    <= 0;
                    is_imm_rs2   <= 1;
                    is_unsigned  <= 0;
                    rd_select    <= 2'b00;
                    extend_op    <= 3'b000;
                    case (funct3)
                        3'b000:begin    //addi
                            alu_control <= 4'b0000;
                        end
                        3'b111:begin    //andi
                            alu_control <= 4'b0111;
                        end
                        3'b110:begin    //ori
                            alu_control <= 4'b0110;
                        end
                        3'b100:begin    //xori  not implemented
                            alu_control <= 4'b1000;
                        end
                    endcase
                end
                7'b0000011:begin    //I type load
                    is_write_reg <= 1;
                    is_imm_rs2   <= 1;
                    extend_op    <= 3'b000;
                    case (funct3)
                        3'b000:begin    //load byte
                            alu_control <= 4'b0;
                            rd_select   <= 2'b11;
                        end
                        3'b010:begin    //load word
                            alu_control <= 4'b0;
                            rd_select   <= 2'b10;
                        end
                        3'b001:begin    //load half word   not implemented
                        end
                    endcase
                end
                7'b1101111:begin    //jal   jump signal is initalted
                    is_write_reg <= 1;
                    rd_select    <= 2'b01; //next addr->rd
                    is_pc_rs1    <= 1;
                    is_imm_rs2   <= 1;
                    extend_op    <= 3'b100;
                    alu_control  <= 4'b0;
                end
                7'b1100111:begin    //jalr
                    is_write_reg <= 1;
                    rd_select    <= 2'b01;
                    is_imm_rs2   <= 1;
                    extend_op    <= 3'b000;
                    alu_control  <= 4'b0;
                end
                7'b1100011:begin    //branch_type
                    is_imm_rs2<=1;
                    is_pc_rs1 <=1;
                    extend_op <= 3'b011;
                    case (funct3)
                        3'b000:begin //beq
                            alu_control <= 4'b0001;
                            branch_type      <= 2'b00;
                        end
                        3'b101:begin //bge
                            alu_control <= 4'b0000;
                            branch_type      <= 2'b01;
                        end
                    endcase
                end
                7'b0100011:begin    //S type  rs2作为数据 alures作为地址
                    is_write_mem <= 1;
                    is_imm_rs2 <=1;
                    extend_op    <= 3'b010;
                    case (funct3)
                        3'b000: begin    //sb
                            alu_control <= 4'b0000;
                        end
                        3'b010:begin    //sw
                            alu_control <= 4'b0000;
                        end
                    endcase
                end
                7'b0010111:begin    //auipc
                    is_write_reg <= 1;
                    extend_op    <= 3'b001;
                    rd_select    <= 2'b00;
                    is_pc_rs1    <= 1;
                    is_imm_rs2   <= 1;
                end
                7'b0110111:begin    //lui
                    is_write_reg <= 1;
                    extend_op    <= 3'b001;
                    alu_control <=4'b1100;
                    rd_select    <= 2'b00;
                    is_imm_rs2   <= 1;
                end
            endcase
        end
    end
endmodule

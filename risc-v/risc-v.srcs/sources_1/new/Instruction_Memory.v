`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/10 16:27:46
// Design Name:
// Module Name: Instruction_Memory
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
module Instruction_Memory(input sys_rst,
                          input [`DATA_WIDTH] instruction_addr,
                          output reg [`DATA_WIDTH] instruction);
    
    
    reg [`DATA_WIDTH] instruction_mem [0:31] ;
    // always @(posedge clk) begin
    //     if (sys_rst&&write_enable)
    //         instruction_mem[instruction_addr[6:2]] <= write_data ;
    
    // end

    // initial begin
    //     $readmemh();
    // end
    always @(*) begin
        if (~sys_rst) begin
            instruction <= 0;
            instruction_mem[0]     <= 32'h00500093;
            instruction_mem[1]     <= 32'h00600113;
            instruction_mem[2]     <= 32'h002081b3;
            instruction_mem[3]     <= 32'h00700213;
            instruction_mem[4]     <= 32'h00300293;
            instruction_mem[5]     <= 32'h00527333;
            instruction_mem[6]     <= 32'h0022a383;
            instruction_mem[7]     <= 32'h0072a123;
            instruction_mem[8]     <= 32'h00525463;
            instruction_mem[9]     <= 32'h004100b3;
            instruction_mem[10]    <= 32'h0080046f;
            instruction_mem[11]    <= 32'h004100b3;
            instruction_mem[12]    <= 32'h00008497;
            // instruction_mem[13] <= 32'h001102B3;
            // instruction_mem[14] <= 32'h0242C1B3;
            // instruction_mem[15] <= 32'h02B181B3;
            // instruction_mem[16] <= 32'h0001A303;
            // instruction_mem[17] <= 32'h02730263;
            // instruction_mem[18] <= 32'h00735463;
            // instruction_mem[19] <= 32'h00734863;
            // instruction_mem[20] <= 32'h00300133;
            // instruction_mem[21] <= 32'h02B14133;
            // instruction_mem[22] <= 32'hFDDFF46F;
            // instruction_mem[23] <= 32'h003000B3;
            // instruction_mem[24] <= 32'h02B0C0B3;
            // instruction_mem[25] <= 32'hFD1FF46F;
            // instruction_mem[26] <= 32'h003004B3;
            // instruction_mem[27] <= 32'h02B4C4B3;
            // instruction_mem[28] <= 32'h11111111;
            // instruction_mem[29] <= 32'h22222222;
            // instruction_mem[30] <= 32'h33333333;
            // instruction_mem[31] <= 32'h44444444;
            // instruction         <= 0;
        end
        else begin
            instruction <= instruction_mem[instruction_addr[6:2]];
        end
        
    end
endmodule

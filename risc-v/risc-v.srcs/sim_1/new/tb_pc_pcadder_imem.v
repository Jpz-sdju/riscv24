`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/19 19:35:52
// Design Name: 
// Module Name: tb_pc_pcadder_imem
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
module tb_pc_pcadder_imem(

    );
    reg clk;
    reg rst;
    
    wire [`width-1:0] next_addr;
    wire [`width-1:0] now_addr;
    wire [`width-1:0] ins;
    Pc pc1(
    .clk(clk),
    .rst(rst),
    .next_addr(next_addr),
    .now_addr(now_addr)
    );
    
    Pc_Adder pc_adder(
    .now_addr(now_addr),
    .next_addr(next_addr)
    );
    
    Instruction_Memory im(
    .clk(clk),
    .rst(rst),
    .instruction_addr(now_addr),
    .instruction(ins)
    );
    
    always #10 clk = ~clk;
    initial begin
        clk = 0;
        rst = 0;
        
        #30

        rst=1;
        
    end
endmodule

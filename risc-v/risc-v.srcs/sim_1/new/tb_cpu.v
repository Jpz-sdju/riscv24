`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/22 17:03:25
// Design Name: 
// Module Name: tb_cpu
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


module tb_cpu( );
    reg clk;
    reg rst;
    Risc32_CPU u_Risc32_CPU(
    	.clk (clk ),
        .rst (rst )
    );
    
    initial begin
        clk =0;
        rst=0;
        #10
        rst=1;
    end
    always #10 clk=~clk;
endmodule

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
    reg sys_clk;
    reg sys_rst;
    Risc32_CPU u_Risc32_CPU(
    	.sys_clk (sys_clk ),
        .sys_rst (sys_rst )
    );
    
    initial begin
        sys_clk =0;
        sys_rst=0;
        #11
        sys_rst=1;
    end
    always #10 sys_clk=~sys_clk;
endmodule

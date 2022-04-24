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
    // cpu u_cpu(
    // 	.sys_clk   (sys_clk   ),
    //     .sys_rst   (sys_rst   ),
    //     .vmem_data (vmem_data ),
    //     .ebreak    (ebreak    )
    // );
    SOC u_SOC(
    	.sys_clk (sys_clk ),
        .sys_rst (sys_rst ),
        .de      (de      ),
        .hsync   (hsync   ),
        .vsync   (vsync   ),
        .lcd_clk (lcd_clk ),
        .data    (data    ),
        .lcd_rst (lcd_rst ),
        .lcd_bl  (lcd_bl  )
    );
    
    
    initial begin
        sys_clk =0;
        sys_rst=0;
        #11
        sys_rst=1;
    end
    always #10 sys_clk=~sys_clk;
endmodule

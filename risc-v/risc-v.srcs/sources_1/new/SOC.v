`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/04/18 01:10:24
// Design Name:
// Module Name: SOC
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


module SOC(input sys_clk,
           input sys_rst,
           output de,
           output hsync,
           output vsync,
           output lcd_clk,
           inout [23:0] data,
           output lcd_rst,
           output lcd_bl);
    wire [31:0]vmem_data;
    cpu u_cpu(
    	.sys_clk (sys_clk ),
        .sys_rst (sys_rst ),
        .ebreak  (ebreak  )
    );
    
    
    lcd_top u_lcd_top(
    .sys_clk (sys_clk),
    .sys_rst (sys_rst),
    .de      (de),
    .vmem_data    (vmem_data),
    .hsync   (hsync),
    .vsync   (vsync),
    .lcd_clk (lcd_clk),
    .data    (data),
    .lcd_rst (lcd_rst),
    .lcd_bl  (lcd_bl)
    );
    
endmodule

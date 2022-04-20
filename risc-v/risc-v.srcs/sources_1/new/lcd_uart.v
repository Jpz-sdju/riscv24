`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/04/20 03:29:52
// Design Name:
// Module Name: lcd_uart
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


module lcd_uart(input sys_clk,
                input sys_rst,
                output de,
                output hsync,
                output vsync,
                output lcd_clk,
                inout [23:0] data,
                output lcd_rst,
                output lcd_bl,
                input uart_rxd);
    wire [7:0] uart_data;
    lcd_top u_lcd_top(
    .sys_clk   (sys_clk),
    .sys_rst   (sys_rst),
    .de        (de),
    .vmem_data ({{24'b0},uart_data}),
    .vmem_addr (vmem_addr),
    .hsync     (hsync),
    .vsync     (vsync),
    .lcd_clk   (lcd_clk),
    .data      (data),
    .lcd_rst   (lcd_rst),
    .lcd_bl    (lcd_bl)
    );
    uart_rec u_uart_rec(
    .sys_clk   (sys_clk),
    .sys_rst (sys_rst),
    .uart_rxd  (uart_rxd),
    .uart_done (uart_done),
    .uart_data (uart_data)
    );
    
endmodule

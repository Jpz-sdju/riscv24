`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/20 18:15:13
// Design Name: 
// Module Name: tb_lcd_uart
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


module tb_lcd_uart(

    );
    reg sys_clk;
    reg sys_rst;
    reg uart_rxd;
    always #10 sys_clk=~sys_clk;
    lcd_uart u_lcd_uart(
    	.sys_clk  (sys_clk  ),
        .sys_rst  (sys_rst  ),
        .de       (de       ),
        .hsync    (hsync    ),
        .vsync    (vsync    ),
        .lcd_clk  (lcd_clk  ),
        .data     (data     ),
        .lcd_rst  (lcd_rst  ),
        .lcd_bl   (lcd_bl   ),
        .uart_rxd (uart_rxd )
    );
    
    initial begin
        sys_clk=0;
        sys_rst=0;
        uart_rxd=1;
        #20
    end
    reg 

endmodule

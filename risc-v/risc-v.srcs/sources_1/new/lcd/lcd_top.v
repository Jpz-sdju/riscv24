`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/03/27 01:12:09
// Design Name:
// Module Name: lcd_top
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


module lcd_top(input sys_clk,
               input sys_rst,
               output de,
               output hsync,
               output vsync,
               output lcd_clk,
            //    input ena,
               inout [23:0] data,
               output lcd_rst,
               output lcd_bl);
    
    

    wire clk_inner;
    
    wire [10:0] x_pos;
    wire [10:0] y_pos;
    wire [15:0] lcd_model;
    wire [23:0] data_from_driver;
    
    wire [23:0] data_from_display;
    
    wire [23:0] data_from_lcd;
    assign data          = de?data_from_driver:{24{1'bz}};
    assign data_from_lcd = data;
    
    
    lcd_id_receive u_lcd_id_receive(
    .sys_clk     (sys_clk),
    .sys_rst     (sys_rst),
    .in_rgb_data (data_from_lcd),
    .lcd_model   (lcd_model)
    );
    
    clk_generator u_clk_generator(
    .sys_clk   (sys_clk),
    .sys_rst   (sys_rst),
    .lcd_clk   (clk_inner)
    );
    // lcd_display u_lcd_display(
    // .lcd_clk             (clk_inner),
    // .sys_rst             (sys_rst),
    // .x_pos               (x_pos),
    // .y_pos               (y_pos),
    // .colorbar_data       (data_from_display)
    // );
    wire [11:0] lrom_offset;

    wire ve;



    reg [7:0] test_data[0:7];
    wire [2:0] vmem_addr;
    wire [7:0]vmem_data;
    assign vmem_data = test_data[vmem_addr];
    initial begin
        test_data[0]=8'd3;
        test_data[1]=8'd4;//+1-2
        test_data[2]=8'd4;
        test_data[3]=8'd5;
        test_data[4]=8'd6;
        test_data[5]=8'd7;
        test_data[6]=8'd8;
        test_data[7]=8'd9;
    end
    font_display u_font_display(
    	.lcd_clk       (clk_inner       ),
        .sys_rst       (sys_rst       ),
        .x_pos         (x_pos         ),
        .y_pos         (y_pos         ),
        .colorbar_data (data_from_display ),
        .lrom_offset(lrom_offset),
        .vmem_enable(ve)
    );
    
    lcd_vmem_accesser u_lcd_vmem_accesser(
    	.sys_clk     (clk_inner   ),
        .sys_rst     (sys_rst     ),
        .vmem_data   (vmem_data   ),
        .vmem_addr   (vmem_addr   ),
        .lrom_offset (lrom_offset ),
        .vmem_enable(ve)
    );
    


    lcd_driver u_lcd_driver(
    .clk_from_display    (clk_inner),
    .sys_rst             (sys_rst),
    .de                  (de),
    .hsync               (hsync),
    .vsync               (vsync),
    .x_pos               (x_pos),
    .y_pos               (y_pos),
    .data_from_display   (data_from_display),
    .rgb_data            (data_from_driver),
    .lcd_clk             (lcd_clk),
    .lcd_bl              (lcd_bl),
    .lcd_rst         (lcd_rst)
    );
    
    
endmodule

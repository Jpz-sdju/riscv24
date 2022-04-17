`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/04/14 01:14:17
// Design Name:
// Module Name: lcd_vmem_accesser
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


module lcd_vmem_accesser(input sys_clk,
                         input sys_rst,
                         input [7:0] vmem_data,
                         output reg [2:0] vmem_addr,
                         output [11:0] lrom_offset,
                         input vmem_enable);
    
    
    reg [4:0] row_cnt;
    
    always @(posedge sys_clk) begin //when row_cnt == 32,addr change to next
        if (!sys_rst) begin
            row_cnt <= 0;
        end
        else if (vmem_enable) begin
            if (row_cnt <= 5'b11111) begin
                row_cnt <= row_cnt+1;
            end
            else
                row_cnt <= 0;
        end
        else
            row_cnt <= 0;
    end
    
    
    
    
    always @(posedge sys_clk) begin
        if (!sys_rst)
            vmem_addr <= 0;
        else if (vmem_enable) begin
            if (row_cnt == 5'b11111 && vmem_addr <= 3'b111)
                vmem_addr <= vmem_addr +1;
            else if (vmem_addr > 3'b111) begin
                vmem_addr <= 0;
            end
        end 
        else
            vmem_addr<=0;
    end
                
                assign lrom_offset = vmem_data[5:0]*64;
                
                // always @(*) begin
                //     case (vmem_data[5:0])
                //         6'b000000:lrom_offset <= 0;
                //         6'b000001:lrom_offset <= 1;
                //         6'b000010:lrom_offset <= 2;
                //         6'b000011:lrom_offset <= 3;
                //         6'b000100:lrom_offset <= 4;
                //         6'b000101:lrom_offset <= 5;
                //         6'b000110:lrom_offset <= 6;
                //         6'b000111:lrom_offset <= 7;
                //         6'b001000:lrom_offset <= 8;
                //         6'b001001:lrom_offset <= 9;
                //         6'b001010:lrom_offset <= 10;
                //         6'b001011:lrom_offset <= 11;
                //         6'b001100:lrom_offset <= 12;
                //         6'b001101:lrom_offset <= 13;
                //         6'b001110:lrom_offset <= 14;
                //         6'b001111:lrom_offset <= 15;
                //         6'b010000:lrom_offset <= 16;
                //         6'b010001:lrom_offset <= 17;
                //         6'b010010:lrom_offset <= 18;
                //         6'b010011:lrom_offset <= ;
                //         6'b010100:lrom_offset <= 0;
                //         6'b010101:lrom_offset <= 0;
                //         6'b010110:lrom_offset <= 0;
                //         6'b010111:lrom_offset <= 0;
                //     endcase
                // end
                
                endmodule

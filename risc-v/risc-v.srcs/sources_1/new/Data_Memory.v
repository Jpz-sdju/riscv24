`include "para.vh"
module Data_Memory(input rst,
                   input [`width -1:0] data_addr,
                   input write_enable,
                   input [`width -1:0] write_data,
                   output reg [`width -1:0] out_data);
    reg [31:0] dmem[0:255];
    always @(*) begin
        if (rst && write_enable) begin
            dmem[data_addr[6:0]] <= write_data;
        end
        
    end
    always @(*) begin
        if (~rst) begin
            dmem[0]  <= 32'd1;
            dmem[1]  <= 32'd2;
            dmem[2]  <= 32'd3;
            dmem[3]  <= 32'd4;
            dmem[4]  <= 32'd5;
            dmem[5]  <= 32'd6;
            dmem[6]  <= 32'd7;
            dmem[7]  <= 32'd8;
            dmem[8]  <= 32'd9;
            dmem[9]  <= 32'd10;
            dmem[10] <= 32'd0;
            out_data <= 32'b0;
            end else begin
            out_data <= dmem[data_addr[4:0]];
        end
    end
endmodule

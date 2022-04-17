`include "para.vh"
module Data_Memory(input sys_rst,
                   input [`DATA_WIDTH] data_addr,
                   input write_enable,
                   input [`DATA_WIDTH] write_data,
                   output reg [`DATA_WIDTH] out_data,
                   output reg [`DATA_WIDTH] vmem_data,
                   input [2:0] vmem_addr);
    reg [31:0] dmem[0:127];
    reg [31:0] vmem[0:7];
    
    always @(*) begin
        vmem[0] = dmem[120];
        vmem[1] = dmem[121];
        vmem[2] = dmem[122];
        vmem[3] = dmem[123];
        vmem[4] = dmem[124];
        vmem[5] = dmem[125];
        vmem[6] = dmem[126];
        vmem[7] = dmem[127];
    end
    always @(*) begin
        vmem_data = vmem[vmem_addr];
    end
    always @(*) begin
        if (~sys_rst) begin
            dmem[0]   <= 32'd1;
            dmem[1]   <= 32'd2;
            dmem[2]   <= 32'd3;
            dmem[3]   <= 32'd4;
            dmem[4]   <= 32'd5;
            dmem[5]   <= 32'd6;
            dmem[6]   <= 32'd7;
            dmem[7]   <= 32'd8;
            dmem[8]   <= 32'd9;
            dmem[9]   <= 32'd10;
            dmem[10]  <= 32'd0;
            dmem[120] <= 32'd1;
            dmem[121] <= 32'd2;
            dmem[122] <= 32'd3;
            out_data  <= 32'b0;
        end
        else if (write_enable)
            dmem[data_addr[6:0]] = write_data;
        else
            out_data = dmem[data_addr[4:0]];
        
        
    end
    
endmodule

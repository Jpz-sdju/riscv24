`include "para.v"
module mem_wb (
    input sys_rst,
    input [1:0] wb_select,
               input [`width] pc_plus_4,
               input [`width] alu_res,
               input [`width] rs2,
               input [7:0] write_width,
               input write_enable,
               output [`width] write_back_data);
    
    reg [7:0] dmem[0:127];
    reg [7:0] vmem[0:7];
    initial begin
        $readmemh("N:/vmshare/riscv-relevant/data.txt",dmem);
    end
    always @(*) begin
        vmem[0]= dmem[120];
        vmem[1]= dmem[121];
        vmem[2]= dmem[122];
        vmem[3]= dmem[123];
        vmem[4]= dmem[124];
        vmem[5]= dmem[125];
        vmem[6]= dmem[126];
        vmem[7]= dmem[127];
    end
    assign write_back_data = {dmem[alu_res+7],dmem[alu_res+6],dmem[alu_res+5],dmem[alu_res+4],dmem[alu_res+3],dmem[alu_res+2],dmem[alu_res+1],dmem[alu_res]};
    
    always @(*) begin
        if (write_enable&&(alu_res[6:0]<7'd120)) begin
            case (write_width)
                8'b1:dmem[alu_res] = rs2[7:0];
                8'b11:begin
                    dmem[alu_res] = rs2[7:0];
                    dmem[alu_res+1] = rs2[15:8];
                end
                8'b1111:begin
                    dmem[alu_res] = rs2[7:0];
                    dmem[alu_res+1] = rs2[15:8];
                    dmem[alu_res+2] = rs2[24:16];
                    dmem[alu_res+3] = rs2[31:25];
                end 
                default: 
                    dmem[alu_res] = rs2[7:0];
            endcase
        end
    end
    
    
    
    
    MuxKey #(4,2,64) plus_4_or_more(
    write_back_data,
    wb_select,
    {
    2'b00, alu_res,
    2'b01, dmem_read_data,
    2'b10, pc_plus_4,
    2'b11, alu_res  //not used
    }
    );
    // import "DPI-C" function void pmem_read(
    //   input longint raddr, output longint rdata);
    // import "DPI-C" function void pmem_write(
    //   input longint waddr, input longint wdata, input byte wmask);
    // always @(*) begin
    //     if (write_enable)
    //         pmem_write(alu_res, rs2, write_width);
    // end
    // always @(*) begin
    //       pmem_read(alu_res, dmem_data);
    //       dmem_data = dmem_data >>(alu_res%8)*8;
    // end
    
endmodule

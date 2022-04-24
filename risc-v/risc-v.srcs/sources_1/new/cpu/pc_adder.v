`include "para.v"
module pc_adder (
    input sys_clk,
    input sys_rst,
    input [`width] now_pc,
    output reg [`width] pc_plus_4
);
    always @(*) begin
        if (~sys_rst) begin
            pc_plus_4=0;
        end else
        pc_plus_4 = now_pc+4;
    end
endmodule
    

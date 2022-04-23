module regfile #(ADDR_WIDTH = 1,
                 DATA_WIDTH = 1)
                (input sys_clk,
                 input sys_rst,
                 input [ADDR_WIDTH-1:0] raddr1,
                 input [ADDR_WIDTH-1:0] raddr2,
                 input [ADDR_WIDTH-1:0] waddr,
                 input [DATA_WIDTH-1:0] wdata,
                 output reg [DATA_WIDTH-1:0] rdata1,
                 output reg [DATA_WIDTH-1:0] rdata2,
                 input wen);
    // import "DPI-C" function void set_gpr_ptr(input logic [63:0] a []);
    // initial set_gpr_ptr(rf);  // rf为�?�用寄存器的二维数组变量
    integer i;
    reg [DATA_WIDTH-1:0] rf [0:31];
    
    initial begin
        for (i = 0;i<32 ;i = i+1) begin
            rf[i] = 0;
        end
    end
    always @(posedge sys_clk ) begin       //this set to be*
        if (wen&&(waddr!= 0))
          rf[waddr] <= wdata;
    end
    
    always @(*) begin
      if((raddr1 == waddr) && wen)
          rdata1 <=wdata;
    end
    always @(*) begin
      if((raddr2 ==waddr) &&wen)
        rdata2<=wdata;
    end
    // always @(*) begin
    //     rdata1 = rf[raddr1];
    //     rdata2 = rf[raddr2];
    // end
    // assign rdata1 = rf[raddr1];
    // assign rdata2 = rf[raddr2];
endmodule

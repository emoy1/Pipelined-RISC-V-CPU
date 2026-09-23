// regfile.v — 8x16-bit register file, 2 read ports (combinational), 1 write port (synchronous). r0 is hardwired to zero


module Register(
    input         clk,
    input  [2:0]  rs1_addr,
    input  [2:0]  rs2_addr,
    input  [2:0]  rd_addr,
    input  [15:0] rd_data,
    input         reg_write,
    output [15:0] rs1_data,
    output [15:0] rs2_data
);
    reg [15:0] registers [0:7];
    integer i;

   
    initial begin // for sim
        for (i = 0; i < 8; i = i + 1)
            registers[i] = 16'b0;
    end

    assign rs1_data = (rs1_addr == 3'b0) ? 16'b0 : registers[rs1_addr];
    assign rs2_data = (rs2_addr == 3'b0) ? 16'b0 : registers[rs2_addr];

    always @(posedge clk) begin
        if (reg_write && rd_addr != 3'b0) 
            registers[rd_addr] <= rd_data;
    end
endmodule

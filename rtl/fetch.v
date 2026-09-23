// fetch.v — program counter and instruction memory


module fetch (
    input         clk,
    input         reset,
    input         stall,          
    input         branch_taken,   
    input  [15:0] branch_target,  
    output [15:0] pc_out,
    output [15:0] instruction
);
    reg [15:0] pc;

    // instruction memory 
    reg [15:0] imem [0:255];
    initial $readmemh("tb/programs/fib.mem", imem);

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 16'b0;
        else if (branch_taken)
            pc <= branch_target;
        else if (!stall)
            pc <= pc + 1;
       
    end

    assign pc_out = pc;
    assign instruction = imem[pc[7:0]]; 
endmodule



/*

Testbench for Control Section of Multicycle Datapath

Following is the Control Signal Configuration
+---------------+------------+
| Signal Name   | Bit Indices|
+---------------+------------+
| PCSrc         |   20:19    |
| RegDst        |   18:17    |
| RegInSrc      |   16:15    |
| ALUSrcY       |   14:13    |
| LogicFn       |   12:11    |
| FnType        |   10:9     |
| jumpAddr      |    8       |
| PCWrite       |    7       |
| Inst_data     |    6       |
| MemRead       |    5       |
| MemWrite      |    4       |
| IRWrite       |    3       |
| RegWrite      |    2       |
| ALUSrcX       |    1       |
| Add_Sub       |    0       |
+---------------+------------+
*/


module controlSection_tb;

reg [5:0] op_code;
reg [5:0] func;
reg clk;
reg reset;
wire [19:0] controlSignal;

// Instantiate the controlSection module
controlSection DUT (
    .op_code(op_code),
    .func(func),
    .clk(clk),
    .reset(reset),
    .controlSignal(controlSignal)
);

initial begin
    clk = 0;
    # 8 reset = 1;
end

// Clock generation
always begin
    #10 clk = ~clk;
end

// Initialize signals
initial begin
    op_code = 6'b100011; // Set your desired opcode
    func = 6'b000000;   // Set your desired function
    
    @(posedge clk);
    $display("Current : %d, Next: %d", DUT.p_state, DUT.n_state);
    $display("Packed Control Signal = %b", controlSignal);
        $display("PCSrc: %b", controlSignal[19:18]);
        $display("RegDst: %b", controlSignal[17:16]);
        $display("ALUSrcY: %b", controlSignal[15:14]);
        $display("LogicFn: %b", controlSignal[13:12]);
        $display("FnType: %b", controlSignal[11:10]);
        $display("RegInSrc: %b", controlSignal[9]);
        $display("jumpAddr: %b", controlSignal[8]);
            $display("PCWrite: %b", controlSignal[7]);
            $display("Inst_data: %b", controlSignal[6]);
            $display("MemRead: %b", controlSignal[5]);
            $display("MemWrite: %b", controlSignal[4]);
            $display("IRWrite: %b", controlSignal[3]);
            $display("RegWrite: %b", controlSignal[2]);
            $display("ALUSrcX: %b", controlSignal[1]);
            $display("Add_Sub: %b", controlSignal[0]);
            $display("---------------------------------");
                    

    #12 reset = 0;
    forever begin
        @(posedge clk);
        if(DUT.n_state == 0) begin
            $finish(0);
        end
        
        #1;
        $display("Current : %d, Next: %d", DUT.p_state, DUT.n_state);
        $display("Packed Control Signal = %b", controlSignal);
        $display("PCSrc: %b", controlSignal[19:18]);
        $display("RegDst: %b", controlSignal[17:16]);
        $display("ALUSrcY: %b", controlSignal[15:14]);
        $display("LogicFn: %b", controlSignal[13:12]);
        $display("FnType: %b", controlSignal[11:10]);
        $display("RegInSrc: %b", controlSignal[9]);
        $display("jumpAddr: %b", controlSignal[8]);
        $display("PCWrite: %b", controlSignal[7]);
        $display("Inst_data: %b", controlSignal[6]);
        $display("MemRead: %b", controlSignal[5]);
        $display("MemWrite: %b", controlSignal[4]);
        $display("IRWrite: %b", controlSignal[3]);
        $display("RegWrite: %b", controlSignal[2]);
        $display("ALUSrcX: %b", controlSignal[1]);
        $display("Add_Sub: %b", controlSignal[0]);
        $display("---------------------------------");
    end

end

endmodule

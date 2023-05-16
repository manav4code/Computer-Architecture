// Parallel In -  Serial Out
module piso #(
    parameter N = 4
) (
    input [N-1:0]d,
    input clk,load,
    output sOut
);

wire [N-1:0] tempOut;
wire [N-2:0] tempIn[N-1];

d_ff in0(.d(d[0]),.q(tempOut[0]),.clk(clk));

genvar i;
generate
    for (i = 1; i < N; i = i+1) begin : loadShift
        assign tempIn[i-1] = (load & d[i]) | (~load & tempOut[i-1]);
        d_ff d0(.d(tempIn[i-1]),.q(tempOut[i]),.clk(clk));
    end
endgenerate

assign sOut = tempOut[N-1];


endmodule


// D - Flip Flop
module d_ff (
    output reg q,
    input d,clk,rst,pre
);

always @(posedge clk, posedge rst, posedge pre) begin
	if(rst) q <= 1'b0;
	if(pre) q <= 1'b1;
	else q <= d;
end
    
endmodule

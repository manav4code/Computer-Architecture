module ringCounter #(parameter N = 4)(
	input clk, reset,
	output [N-1:0]out
);

d_ff d0(.clk(clk), .d(out[N-1]), .pre(reset), .q(out[0]));

genvar i;
generate
	for(i = 1; i < N; i=i+1)begin:jCounter
		d_ff d1(.clk(clk), .d(out[i-1]), .rst(reset), .q(out[i]));
	end
endgenerate

endmodule

// D Flip Flop
module d_ff (
    output reg q,
    input d,clk,rst,pre
);

always @(posedge clk, posedge rst, posedge pre) begin
	if(rst) q <= 1'b0;
	else if(pre) q <= 1'b1;
	else q <= d;
end
    
endmodule

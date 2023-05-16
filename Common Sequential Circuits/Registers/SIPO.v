// Serial In Parallel Out

module sipo #(parameter N = 4)(
	input in,
	input clk,
	output [N-1:0] out
);

d_ff d0(.d(in),.clk(clk),.q(out[0]));

genvar i;
generate
	for(i = 1; i < N; i= i+1)begin: makeSipo
		d_ff dTemp(.d(out[i-1]),.clk(clk),.q(out[i]));
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
	if(pre) q <= 1'b1;
	else q <= d;
end
    
endmodule
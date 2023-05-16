module pipo #(parameter N = 4)(
	input [N-1:0] in,
	input clk,rst,
	output [N-1:0]out
);

genvar i;

generate
	for(i = 0; i < N; i = i+1)begin : pipoReg
		d_ff d0(.d(in[i]),.q(out[i]),.clk(clk),.rst(clk));
	end
endgenerate

endmodule

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

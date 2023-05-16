// Universal Shift Register

module universalShiftRegister #(parameter N = 4)(
	input [N-1:0] in,
	input [1:0] fn,
	input sli,sri,clear,clk,
	output [N-1:0]out
);

wire [N-1:0] muxOut;

genvar i;
generate
	for(i = 0; i < N; i=i+1)begin:latch
		d_ff d0(.d(muxOut[i]), .clk(clk), .rst(clear), .q(out[i]));
	end
endgenerate

/*
fn:
00 -> Latch
01 -> LS
10 -> RS
11 -> Parallel In
*/

mux4x1 lsb(.s(fn), .in({out[0],sli,out[0+1],in[0]}), .y(muxOut[0]));
mux4x1 msb(.s(fn), .in({out[N-1],out[N-1-1],sri,in[N-1]}), .y(muxOut[N-1]));

genvar j;
generate
	for(j = 1; j < (N-1); j=j+1)begin:usrCore
		mux4x1 int(.s(fn), .in({out[j],out[j-1],out[j+1],in[j]}), .y(muxOut[j]));
	end
endgenerate

endmodule


module mux4x1(
	input [1:0]s,
	input [3:0]in,
	output y
);

assign y = (s[1] & s[0]) ? in[3] :
			  (s[1] & ~s[0]) ? in[2] :
			  (~s[1] & s[0]) ? in[1] :
			  in[0];

endmodule

module d_ff(
	input d,rst,clk,
	output reg q
);

always@(posedge clk, posedge rst)begin
	if(rst) q <= 1'b0;
	else q <= d;
end
endmodule


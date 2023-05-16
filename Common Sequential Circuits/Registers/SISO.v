// Serial In Serial Out

module siso #(parameter N = 4) (
    input d,
    input clk,rst,
    output sout
);

wire [N-2:0]tempOut;


d_ff d0(.d(d),.q(tempOut[0]),.clk(clk),.rst(rst));

genvar i;

generate
    for (i = 1; i < N-1 ; i = i+1) begin :sisoReg
		d_ff d1(.d(tempOut[i-1]),.q(tempOut[i]),.clk(clk),.rst(rst));
    end
endgenerate

d_ff out0(.d(tempOut[N-2]),.q(sout),.clk(clk),.rst(rst));

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

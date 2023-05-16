// Booth - Multiplier

module boothMultiplier #(parameter N = 4)(
	input [N-1:0]B,Q,
	output [2*N-1:0]out
);

reg [2*N:0]temp;
integer i;

always@(B or Q)begin	
	temp = {{N{1'b0}},Q,1'b0};
	
	for(i = 0; i < N; i=i+1)begin
		case(temp[1:0])
			2'b10:begin
				temp[2*N:N+1] = temp[2*N:N+1] - B;
			end
			
			2'b01:begin
				temp[2*N:N+1] = temp[2*N:N+1] + B;
			end
		endcase
		
		temp = temp >> 1;
		temp[2*N] = temp[2*N-1];
	end
end
assign out = temp[2*N:1];
endmodule


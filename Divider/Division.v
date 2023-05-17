// Division Booth Algorithm

module Division #(parameter N = 4)(
		input [N-1:0] B,D,
		output reg [0:N-1] Q,R
);

/*
	D-> Dividend
	B-> Divisor
*/

reg [2*N-1:0]temp;
integer i;

always@(B,D)begin
	temp = {{N{1'b0}},D};
	for(i = 0; i < N; i=i+1)begin
		temp = temp << 1;
		temp[2*N-1:N] = temp[2*N-1:N] - B;
		
		if(temp[2*N-1])begin
			Q[i] = 1'b0;
			temp[2*N-1:N] = temp[2*N-1:N] + B;
		end
		else Q[i] = 1'b1;
	end
	R = temp[2*N-1:N];
end
endmodule



module ctrlBlock (
	input [5:0]opcode,fn,
	output [16:0] ctrlSig
);

assign ctrlSig = ({opcode} == 6'b001111) ? 17'b100011zzz00000000 :	//lui
					  ({opcode,fn} == 12'b000000100000) ? 17'b1010100zz10000000 :	//add
					  ({opcode,fn} == 12'b000000100010) ? 17'b1010101zz10000000 :	//sub
					  ({opcode,fn} == 12'b000000101010) ? 17'b1010101zz01000000 :	//slt
					  ({opcode} == 12'b001000) ? 17'b1000110zz10000000 :	//addi
					  ({opcode} == 12'b001010) ? 17'b1000111zz01000000 :	//slti
					  ({opcode,fn} == 12'b000000100100) ? 17'b101010z0011000000 :	//and
					  ({opcode,fn} == 12'b000000100101) ? 17'b101010z0111000000 :	//or
					  ({opcode,fn} == 12'b000000100110) ? 17'b101010z1011000000 :	//xor
					  ({opcode,fn} == 12'b000000100111) ? 17'b101010z1111000000 :	//nor
					  ({opcode} == 12'b001100) ? 17'b100011z0011000000	:	//andi
					  ({opcode} == 12'b001101) ? 17'b100011z0111000000 :	//ori
					  ({opcode} == 12'b001110) ? 17'b100011z1011000000 :	//xori
					  ({opcode} == 12'b100011) ? 17'b1000010zz10100000	:	//lw
					  ({opcode} == 12'b101011) ? 17'b0zzzz10zz10010000	:	//sw
					  ({opcode} == 12'b000010) ? 17'b0zzzzzzzzzz00zz01 : 	//jmp
					  ({opcode,fn} == 12'b000000001000) ? 17'b0zzzzzzzzzz00zz10 :	//jr
					  ({opcode} == 12'b000001) ? 17'b0zzzzzzzzzz001100 :	//bltz
					  ({opcode} == 12'b000100) ? 17'b0zzzzzzzzzz000100 :	//beq
					  ({opcode} == 12'b000101) ? 17'b0zzzzzzzzzz001000 :  //bne
					  ({opcode} == 12'b000011) ? 17'b11010zzzzzz000001 :	//jal
					  ({opcode,fn} == 12'b000000001100) ? 17'b0zzzzzzzzzz00zz11 : 	//syscall
					  {17{1'bz}};

endmodule

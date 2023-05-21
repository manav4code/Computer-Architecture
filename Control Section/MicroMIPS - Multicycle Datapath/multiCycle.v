module multiCycle(clk,reset,op_code,func,jumpAddr,PCWrite,Inst_data,MemRead,
MemWrite,IRWrite,RegWrite,ALUSrcX,Add_Sub,PCSrc,RegDst,RegInSrc,ALUSrcY,LogicFn,FnType);

input [5:0] op_code;
input [5:0] func;
input clk,reset;

output reg jumpAddr,PCWrite,Inst_data,MemRead,MemWrite,IRWrite,RegWrite,ALUSrcX,Add_Sub;
output reg[1:0] PCSrc,RegDst,RegInSrc,ALUSrcY,LogicFn,FnType;

reg [20:0]final;

reg [3:0] p_state,n_state;
parameter state0=0, state1=1, state2=2, state3=3, state4=4, state5=5, state6=6, state7=7, state8=8;

initial
begin
	p_state<=state0;
end	

always @(*)
begin

n_state<=state0;
	
	case(p_state)
		
		state0: 
			begin
				Inst_data<=1'b0; 
				MemRead<=1'b1;
				IRWrite<=1'b1;
				ALUSrcX<=1'b0;
				ALUSrcY<=2'b00;
				Add_Sub<=1'b0;
				LogicFn<=2'b00;
				FnType<=2'b10;
				PCSrc<=2'b11;
				PCWrite<=1'b1;
				
				n_state<=state1;
			end
		
		state1:
			begin
				ALUSrcX<=1'b0;
				ALUSrcY<=2'b11;
				Add_Sub<=1'b0;
				LogicFn<=2'b00;
				FnType<=2'b10;
				
				if(op_code==6'b000010 || op_code==6'b000001 || op_code==6'b000100 || op_code==6'b000101 || 
				   op_code==6'b000011 || op_code=='b001111 || (op_code==6'b000000 && (func==6'b001000 || func==6'b001100)))
						n_state<=state5;
						
				else if(op_code==6'b100011 || op_code==6'b101011)
					n_state<=state2;
				
				else
					n_state<=state7;
			end
		
		state2:
			begin
				ALUSrcX<=1'b1;
				ALUSrcY<=2'b10;
				Add_Sub<=1'b0;
				LogicFn<=2'b00;
				FnType<=2'b10;
				
				if(op_code==6'b101011)
					n_state<=state6;
				else
					n_state<=state3;
			end
		
		state3:
			begin
				Inst_data<=1'b1;
				MemRead<=1'b1;
				
				n_state<=state4;
			end
		
		state4:
			begin
				RegDst<=1'b0;
				RegInSrc<=1'b0;
				RegWrite<=1'b1;
				
				n_state<=state0;
			end
		
		state5:
			begin
				ALUSrcX<=1'b1;
				ALUSrcY<=2'b01;
				Add_Sub<=1'b1;
				LogicFn<=2'b00;
				FnType<=2'b10;
				
				if(op_code==6'b000010 || op_code==6'b000011)
					jumpAddr<=1'b0;
				else if(op_code==6'b000000 && func==6'b001100)
					jumpAddr<=1'b1;
				else
					jumpAddr<=1'bx;
				
				if(op_code==6'b000010 || op_code==6'b000011 || (op_code==6'b000000 && func==6'b001100))
					PCSrc<=2'b00;
				else if(op_code==6'b000000 && func==6'b001000)
					PCSrc<=2'b01;
				else
					PCSrc<=2'b10;
					
				n_state<=state0;
			end
		
		state6:
			begin
				Inst_data<=1'b1;
				MemWrite<=1'b1;
				
				n_state<=state0;
			end
		
		state7:
			begin
				ALUSrcX<=1'b1;
				if(op_code!=6'b000000)
					ALUSrcY<=2'b10;
				else
					ALUSrcY<=2'b01;
					
				n_state<=state8;
			end
		
		state8:
			begin
				if(op_code==6'b000000)
					RegDst<=2'b10;
				else
					RegDst<=2'b01;
				
				RegInSrc<=1'b1;
				RegWrite<=1'b1;
				
				n_state<=state0;
			end
		
	endcase

end

always@(posedge clk)
begin
	if(reset==1'b1)
		p_state<=state0;
	else
		p_state<=n_state;
	final={{jumpAddr},{PCSrc},{PCWrite},{Inst_data},{MemRead},{MemWrite},{IRWrite},{RegWrite},
	      {RegDst},{RegInSrc},{ALUSrcX},{ALUSrcY},{Add_Sub},{LogicFn},{FnType}};
end

endmodule

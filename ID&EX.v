module IDandEX(input clk,rst,output reg[31:0] rg1,output reg[31:0] rg2,output reg[31:0] immVal,output reg[4:0] destReg,output reg[4:0] rdRg1, output reg[4:0] rdRg2,
	output reg[1:0] AluOp,output reg AluSrc,RegDst,MemWr,MemRd,DataSrc,WrReg,
	input[31:0] Inrg1,input[31:0] Inrg2,input[31:0] InimmVal,input[4:0] IndestReg,input[4:0] InrdRg1, input[4:0] InrdRg2,
	input[1:0] InAluOp,input InAluSrc,InRegDst,InMemWr,InMemRd,InDataSrc,InWrReg);
	
	always@(posedge rst,posedge clk) begin
		if(rst)	{rg1,rg2,immVal,destReg,rdRg1,rdRg2,AluOp,AluSrc,RegDst,MemWr,MemRd,DataSrc,WrReg} <= 119'b0; 
		else begin
			rg1 <= Inrg1; rg2 <= Inrg2; immVal <= InimmVal; destReg <= IndestReg; rdRg1 <= InrdRg1; rdRg2 <= InrdRg2;
			AluOp <= InAluOp; AluSrc <= InAluSrc; RegDst <= InRegDst; MemWr <= InMemWr; MemRd <= InMemRd; DataSrc <= InDataSrc;
			WrReg <= InWrReg;
		end
	end
endmodule

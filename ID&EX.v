module IDandEX(input clk,rst,output reg[31:0] rg1,output reg[31:0] rg2,output reg[31:0] immVal,output reg[4:0] destReg,output reg[4:0] rdRg1, output reg[4:0] rdRg2,
	output reg[2:0] AluOperation,output reg AluSrc,RegDst,MemWr,MemRd,DataSrc,WrReg,
	input[31:0] Inrg1,input[31:0] Inrg2,input[31:0] InimmVal,input[4:0] IndestReg,input[4:0] InrdRg1, input[4:0] InrdRg2,
	input[2:0] InAluOperation,input InAluSrc,InRegDst,InMemWr,InMemRd,InDataSrc,InWrReg,zerocntrl, output reg EXMEMzerocntrl);
	
	always@(posedge rst,posedge clk) begin
		if(rst)	{rg1,rg2,immVal,destReg,rdRg1,rdRg2,AluOperation,AluSrc,RegDst,MemWr,MemRd,DataSrc,WrReg,EXMEMzerocntrl} <= 121'b0; 
		else begin
			rg1 <= Inrg1; rg2 <= Inrg2; immVal <= InimmVal; destReg <= IndestReg; rdRg1 <= InrdRg1; rdRg2 <= InrdRg2;
			AluOperation <= InAluOperation; AluSrc <= InAluSrc; RegDst <= InRegDst; MemWr <= InMemWr; MemRd <= InMemRd; DataSrc <= InDataSrc;
			WrReg <= InWrReg;
			EXMEMzerocntrl <= zerocntrl;
		end
	end
endmodule

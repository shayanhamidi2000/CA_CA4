module HazardUnit(input PcSrc,Jmp,memRd,input[4:0] rg1,input[4:0] rg2,input[4:0] rgDstNxt,output reg zeroCntrl,PcWrite,IRWrite,flush);
	wire ifFlush;
	assign ifFlush = PcSrc | Jmp;
	always@(PcSrc,Jmp,memRd,rg1,rg2,rgDstNxt) begin
		{zeroCntrl,flush} = 2'b00;
		{PcWrite,IRWrite}= 2'b11;
		if(ifFlush) flush = 1'b1;

		





	end
endmodule

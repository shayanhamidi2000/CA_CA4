module HazardUnit(input PcSrc,Jmp,branch,memRd,input[4:0] rg1,input[4:0] rg2,input[4:0] rgDstNxt,output reg zeroCntrl,PcWrite,IRWrite,flush);
	wire ifFlush;
	assign ifFlush = PcSrc | Jmp;
	always@(PcSrc,Jmp,memRd,rg1,rg2,rgDstNxt) begin
		{zeroCntrl,flush} <= 2'b00;
		{PcWrite,IRWrite} <= 2'b11;
		if(branch & (rgDstNxt != 5'b0) & ((rgDstNxt == rg1) | (rgDstNxt == rg2)) ) begin
			zeroCntrl <= 1'b1;
			PcWrite <= 1'b0;
			IRWrite <= 1'b0;
		end else if(ifFlush) flush = 1'b1;
		else if(memRd & (rgDstNxt != 5'b0) & ((rgDstNxt == rg1) | (rgDstNxt == rg2)) ) begin
			zeroCntrl <= 1'b1;
			PcWrite <= 1'b0;
			IRWrite <= 1'b0;	
		end
	end
endmodule
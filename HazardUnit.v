module HazardUnit(input PcSrc,Jmp,branch,memRd, EXMEMzerocntrl,input[4:0] rg1,input[4:0] rg2,input[4:0] rgDstNxt, input[4:0] rgRtNxt,output reg zeroCntrl,PcWrite,IRWrite,flush);
	wire ifFlush;
	assign ifFlush = PcSrc | Jmp;
	always@(PcSrc,Jmp,memRd,rg1,rg2,rgDstNxt,EXMEMzerocntrl) begin
		{zeroCntrl,flush} <= 2'b00;
		{PcWrite,IRWrite} <= 2'b11;
		if((EXMEMzerocntrl == 0) && branch && (rgRtNxt != 5'b0) && ((rgRtNxt == rg1) || (rgRtNxt == rg2)) ) begin
			zeroCntrl <= 1'b1;
			PcWrite <= 1'b0;
			IRWrite <= 1'b0;
			end
		else	if((EXMEMzerocntrl == 0) && branch && (rgDstNxt != 5'b0) && ((rgDstNxt == rg1) || (rgDstNxt == rg2)) ) begin
			zeroCntrl <= 1'b1;
			PcWrite <= 1'b0;
			IRWrite <= 1'b0;
		end else if(ifFlush) flush <= 1'b1;
		else if(memRd && (rgRtNxt != 5'b0) && ((rgRtNxt == rg1) || (rgRtNxt == rg2)) ) begin
			zeroCntrl <= 1'b1;
			PcWrite <= 1'b0;
			IRWrite <= 1'b0;	
		end
	end
endmodule
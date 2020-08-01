module PC(input pcWrite,clk,rst,input[31:0] parIn,output reg[31:0] pc);
	always@(posedge clk,posedge rst) begin
		if(rst) pc <= 32'b0;
		else if(pcWrite) pc <= parIn;
		else pc <= pc;
	end
endmodule

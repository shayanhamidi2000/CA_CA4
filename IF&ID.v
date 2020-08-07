module IFandID(input rst,clk,write,output reg[31:0] nextInstAdr ,output reg[31:0] ir, input[31:0] adrParIn, input[31:0] instParIn);
	always@(posedge clk , posedge rst) begin
		if(rst) begin
			nextInstAdr <= 32'b0;
			ir <= 32'b0;
		end else if(write) begin
			nextInstAdr <= adrParIn;
			 ir <= instParIn;
		end
	end
endmodule

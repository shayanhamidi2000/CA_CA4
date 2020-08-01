module InstMem(input [31:0] PC,input clk ,input rst, output[31:0] Inst);
	reg [31:0]inst [0:127];
	wire [6:0]pc;
	integer counter;
	initial begin
		#1000
    		$readmemh("./instructions.hex",inst);
	end
	
	always@(posedge clk , posedge rst) begin
		if(rst) begin
			for(counter = 0;counter < 128;counter = counter + 1)
				inst[counter] <= 32'b0;
		end
			
	end
	assign pc = PC[8:2];
	assign Inst = inst[pc];
endmodule

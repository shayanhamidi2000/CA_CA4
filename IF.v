module IF(input rst,clk,flush,jmp,PcSrc,pcWrite,input[31:0] beqAdr, input[25:0]jmpAdr, output[31:0] nextInstAdr , output[31:0] Inst);
	wire[31:0] pc;
	wire[31:0] pcIn;
	wire[31:0] pcsrc;
	wire[31:0] inst;
	wire[27:0] shl2;
	PC Pc (.rst(rst) , .clk(clk) , .pcWrite(pcWrite) , .parIn(pcIn) , .pc(pc) );
	InstMem instmem (.clk(clk) , .rst(rst) , .PC(pc) , .Inst(inst) );
	Shift2b26 shiftL2 (.in(jmpAdr) , .out(shl2));
	assign nextInstAdr = pc + 3'b100;
	assign pcsrc = PcSrc ? beqAdr : nextInstAdr;
	assign pcIn = jmp ? {pc[31:28] , shl2} : pcsrc;
	assign Inst = flush ? 32'b0 : inst;
endmodule

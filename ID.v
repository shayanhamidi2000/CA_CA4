module ID(input clk,rst,WrReg,Brancheq,Branchneq,input[31:0] IR,input[31:0] nextInst,input[31:0] wd,input[4:0] wr,
	output PcSrc,output[31:0] beqAdr,output[25:0] jmpAdr,output[31:0] rdReg1,output[31:0] rdReg2,
	output[4:0] fwdReg1,output[4:0] fwdReg2,output[4:0] destReg,output[31:0] immVal,output[5:0] opcode,output[5:0] func);
	
	wire[31:0] shl;
	RegFile Reg (.rst(rst) ,.clk(clk) , .regWrite(WrReg) , .r1(IR[25:21]) , .r2(IR[20:16]) , .rw(wr) , .wd(wd) , .rd1(rdReg1) , .rd2(rdReg2) );
	SignExt sgnext (.in(IR[15:0]) , .out(immVal) );
	Shift2b32 shl2 (.in(immVal) , .out(shl) );
	assign opcode = IR[31:26];
	assign func = IR[5:0];
	assign beqAdr = shl + nextInst;
	assign jmpAdr = IR[25:0];
	assign fwdReg1 = IR[25:21];
	assign fwdReg2 = IR[20:16];
	assign destReg = IR[15:11];
	assign PcSrc = ((rdReg1 == rdReg2) & Brancheq) | (~(rdReg1 == rdReg2) & Branchneq);
endmodule

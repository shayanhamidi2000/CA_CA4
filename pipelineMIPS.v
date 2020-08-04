module MIPS(input rst, clk);
       
       wire flush, jump, PcSrc, pcWrite, write;
       wire[31:0] beqAdr, Inst, nextInstAdr, nextInstAdrOut, ir;
       wire[25:0] jmpAdr;
       
       IF(.rst(rst), .clk(clk), .flush(flush), .jmp(jmp), .PcSrc(PcSrc), .pcWrite(pcWrite), .beqAdr(beqAdr), .jmpAdr(jmpAdr), .nextInstAdr(nextInstAdr), .Inst(Inst));
       
       IFandID(.rst(rst), .clk(clk), .write(write), .nextInstAdr(nextInstAdrOut), .ir(ir), .adrParIn(nextInstAdr), .instParIn(Inst));

       ID(input clk,rst,WrReg,Brancheq,Branchneq,input[31:0] IR,input[31:0] nextInst,input[31:0] wd,input[4:0] wr,
	     output PcSrc,output[31:0] beqAdr,output[25:0] jmpAdr,output[31:0] rdReg1,output[31:0] rdReg2,
	     output[4:0] fwdReg1,output[4:0] fwdReg2,output[4:0] destReg,output[31:0] immVal,output[5:0] opcode,output[5:0] func);
	     
	     
       IDandEX(input clk,rst,output reg[31:0] rg1,output reg[31:0] rg2,output reg[31:0] immVal,output reg[4:0] destReg,output reg[4:0] rdRg1, output reg[4:0] rdRg2,
	     output reg[2:0] AluOperation,output reg AluSrc,RegDst,MemWr,MemRd,DataSrc,WrReg,
	     input[31:0] Inrg1,input[31:0] Inrg2,input[31:0] InimmVal,input[4:0] IndestReg,input[4:0] InrdRg1, input[4:0] InrdRg2,
	     input[2:0] InAluOperation,input InAluSrc,InRegDst,InMemWr,InMemRd,InDataSrc,InWrReg);

       EX(input[2:0] AluOperation, input[31:0] rg1, input[31:0] rg2, input[31:0] immVal, input[31:0] WBData, input[31:0] EXData, input[1:0] src1, src2, 
       input AluSrc, RegDst, input[4:0] Rg1, Rg2,
       output[31:0] Alures, Data, output[4:0] Rg);
              
       EXandMEM(input clk, rst,input[31:0] ALUres, input[31:0] data, input[4:0] InputDestReg, input InputMemRd, InputMemWr, InputWrReg, InputDataSrc,
       output reg [31:0]ALUresOut, output reg [31:0] Data, output reg[4:0] DestReg, output reg  MemRd, MemWr, WrReg, DataSrc);
       
       Memory(input clk, MemRead , MemWrite, rst,input [31:0]writeData, input[31:0]Address, output[31:0] ReadData);

       MEMandWB(input clk, rst, input[31:0] data,input[31:0] ALUres, input InputWrReg, InputDataSrc, input[4:0] InputDestReg,
       output reg [31:0]ALUresOut, output reg [31:0] Data, output reg[4:0] DestReg, output reg WrReg, DataSrc);
       
       
       WB(input[31:0] data,input[31:0] ALUres, input DataSrc, output [31:0]Data);


       HazardUnit(input PcSrc,Jmp,memRd,input[4:0] rg1,input[4:0] rg2,input[4:0] rgDstNxt,output reg zeroCntrl,PcWrite,IRWrite,flush);
       
       ForwardingUnit(input EXMEMregWr, EXMEMrd, input IDEXrs, IDEXrt, input MEMWBregWr, MEMWBrd,
       output[1:0] src1, src2);
       
       controlUnit(AluOperation, Jmp, Brancheq, Branchneq, DataSrc, regDst, regWrite, AluSrc, MemWrite, MemRead, func, opcode);

endmodule

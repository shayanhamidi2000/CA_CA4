module MIPS(input rst, clk);
       
       wire flush, jmp, PcSrc, PcWrite, write, Brancheq, Branchneq, zeroCntrl;
       wire AluSrcEX, RegDstEX, MemWrEX, MemRdEX, DataSrcEX, WrRegEX, WrRegWB, DataSrcWB;
       wire MemRdMEM, MemWrMEM, WrRegMEM, DataSrcMEM;
       wire DataSrcCU, regDstCU, regWriteCU, AluSrcCU, MemWriteCU, MemReadCU;
       wire InAluSrc, InRegDst, InMemWr, InMemRd, InDataSrc, InWrReg;
       wire[31:0] beqAdr, Inst, nextInstAdr, nextInstAdrOut, ir, rdReg1, rdReg2, immVal, immVal2;
       wire[31:0] rg1, rg2, WBData, MEMData, Data, Alures, dataOutMEM, ReadDataMEM, Data0WB, Data1WB;
       wire[25:0] jmpAdr;
       wire[4:0] fwdReg1, fwdReg2, destReg, destReg2, rdRg1, rdRg2, Rg, DestRegMEM, MEMWBrd;
       wire[5:0] opcode, func;
       wire[2:0] AluOperation, InAluOperation, AluOperationCU;
       wire[1:0] fwSrc1, fwSrc2;
       IF iff(.rst(rst), .clk(clk), .flush(flush), .jmp(jmp), .PcSrc(PcSrc), .pcWrite(PcWrite), .beqAdr(beqAdr), .jmpAdr(jmpAdr), .nextInstAdr(nextInstAdr), .Inst(Inst));
       
       IFandID ifandid(.rst(rst), .clk(clk), .write(write), .nextInstAdr(nextInstAdrOut), .ir(ir), .adrParIn(nextInstAdr), .instParIn(Inst));

       ID id(.clk(clk), .rst(rst), .WrReg(WrRegWB), .Brancheq(Brancheq), .Branchneq(Branchneq), .IR(ir), .nextInst(nextInstAdrOut), .wd(WBData), .wr(MEMWBrd),
	      .PcSrc(PcSrc), .beqAdr(beqAdr), .jmpAdr(jmpAdr), .rdReg1(rdReg1), .rdReg2(rdReg2),
	      .fwdReg1(fwdReg1), .fwdReg2(fwdReg2), .destReg(destReg), .immVal(immVal), .opcode(opcode), .func(func));
	     
	     assign {InAluOperation, InAluSrc, InRegDst, InMemWr, InMemRd, InDataSrc, InWrReg} = zeroCntrl ? {AluOperationCU, AluSrcCU, regDstCU, MemWriteCU, MemReadCU, DataSrcCU, regWriteCU}  : 9'b0;
	     
       IDandEX idandex(.clk(clk), .rst(rst), .rg1(rg1), .rg2(rg2), .immVal(immVal2), .destReg(destReg2), .rdRg1(rdRg1), .rdRg2(rdRg2),
	     .AluOperation(AluOperation), .AluSrc(AluSrcEX), .RegDst(RegDstEX), .MemWr(MemWrEX), .MemRd(MemRdEX), .DataSrc(DataSrcEX), .WrReg(WrRegEX),
	     .Inrg1(rdReg1), .Inrg2(rdReg2), .InimmVal(immVal), .IndestReg(destReg), .InrdRg1(fwdReg1), .InrdRg2(fwdReg2),
	     .InAluOperation(InAluOperation), .InAluSrc(InAluSrc), .InRegDst(InRegDst), .InMemWr(InMemWr), .InMemRd(InMemRd), .InDataSrc(InDataSrc), .InWrReg(InWrReg));

       EX ex(.AluOperation(AluOperation), .rg1(rg1), .rg2(rg2), .immVal(immVal2), .WBData(WBData), .MEMData(MEMData), .src1(fwSrc1), .src2(fwSrc2), 
       .AluSrc(AluSrcEX), .RegDst(RegDstEX), .Rg1(rdRg2), .Rg2(destReg2),
       .Alures(Alures), .Data(Data), .Rg(Rg));
              
       EXandMEM exandmem(.clk(clk), .rst(rst), .ALUres(Alures), .data(Data), .InputDestReg(Rg), .InputMemRd(MemRdEX), .InputMemWr(MemWrEX), .InputWrReg(WrRegEX), .InputDataSrc(DataSrcEX),
       .ALUresOut(MEMData), .Data(dataOutMEM), .DestReg(DestRegMEM), .MemRd(MemRdMEM), .MemWr(MemWrMEM), .WrReg(WrRegMEM), .DataSrc(DataSrcMEM));
       
       Memory memory(.clk(clk), .MemRead(MemRdMEM) , .MemWrite(MemWrMEM), .rst(rst), .writeData(dataOutMEM), .Address(MEMData), .ReadData(ReadDataMEM));

       MEMandWB memandwb(.clk(clk), .rst(rst), .data(ReadDataMEM), .ALUres(MEMData), .InputWrReg(WrRegMEM), .InputDataSrc(DataSrcMEM), .InputDestReg(DestRegMEM),
       .ALUresOut(Data0WB), .Data(Data1WB), .DestReg(MEMWBrd), .WrReg(WrRegWB), .DataSrc(DataSrcWB));
       
       
       WB wb(.data(Data1WB), .ALUres(Data0WB), .DataSrc(DataSrcWB), .Data(WBData));


       HazardUnit hu(.PcSrc(PcSrc), .Jmp(jmp), .memRd(MemRdEX), .rg1(fwdReg1), .rg2(fwdReg2), .rgDstNxt(rdRg2), .zeroCntrl(zeroCntrl), .PcWrite(PcWrite), .IRWrite(write), .flush(flush));
       
       ForwardingUnit fw(.EXMEMregWr(WrRegMEM), .EXMEMrd(DestRegMEM), .IDEXrs(rdRg1), .IDEXrt(rdRg2), .MEMWBregWr(WrRegWB), .MEMWBrd(MEMWBrd),
       .src1(fwSrc1), .src2(fwSrc2));
       
       controlUnit cu(.AluOperation(AluOperationCU), .Jmp(jmp), .Brancheq(Brancheq), .Branchneq(Branchneq), 
       .DataSrc(DataSrcCU), .regDst(regDstCU), .regWrite(regWriteCU), .AluSrc(AluSrcCU), .MemWrite(MemWriteCU), .MemRead(MemReadCU), 
       .func(func), .opcode(opcode));

endmodule
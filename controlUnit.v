module CUcenter(AluOp,Jmp, Brancheq, Branchneq, DataSrc, regDst, regWrite, AluSrc, MemWrite, MemRead, opcode,func);
  output reg [1:0] AluOp;
  output reg Brancheq, Branchneq, DataSrc, regDst,regWrite, AluSrc, MemWrite, MemRead,Jmp;
  input[5:0] opcode;
  input[5:0] func;
  
  always@(opcode , func)begin
    {AluOp,Jmp, Brancheq, Branchneq, DataSrc, regDst, regWrite, AluSrc, MemWrite, MemRead} = 11'b0;
    case(opcode)
      6'b000000:begin if(func != 6'b0) {DataSrc,regDst, regWrite, AluOp} = 5'b11110; end
      6'b100011:{regWrite, AluSrc, MemRead} = 3'b111;
      6'b101011:{AluSrc, MemWrite} = 2'b11;
      6'b001000:{regWrite, AluSrc} = 2'b11;
      6'b001100:{regWrite, AluSrc, AluOp} = 4'b1111;
      6'b000010:Jmp = 1'b1;
      6'b000100:{Brancheq, AluOp} = 3'b101;
      6'b000101:{Branchneq, AluOp} = 3'b101;
    endcase
  end 
endmodule

module ALUcontroller(AluOp, func, AluOperation);
  input [1:0] AluOp;
  input [5:0] func;
  output reg [2:0] AluOperation;
  
  always@(AluOp, func) begin
    AluOperation = 3'b000;
    case(AluOp)
      2'b00: AluOperation = 3'b010;
      2'b01: AluOperation = 3'b110;
      2'b10: begin
              if( func == 6'b100000) AluOperation = 3'b010;
              if( func == 6'b100010) AluOperation = 3'b110;
              if( func == 6'b100100) AluOperation = 3'b000;
              if( func == 6'b100101) AluOperation = 3'b001;
              if( func == 6'b101010) AluOperation = 3'b111;
             end
      2'b11: AluOperation = 3'b000;
    endcase
  end
endmodule

module controlUnit(AluOperation, Jmp, Brancheq, Branchneq, DataSrc, regDst, regWrite, AluSrc, MemWrite, MemRead, func, opcode);
  output [2:0] AluOperation;
  output Jmp, Brancheq, Branchneq, DataSrc, regDst, regWrite, AluSrc, MemWrite, MemRead;
  input[5:0] func;
  input[5:0] opcode;
  
  wire [1:0] AluOp;
  wire Brancheq, Branchneq;
  
  CUcenter cu(.func(func) , .AluOp(AluOp), .Brancheq(Brancheq), .Branchneq(Branchneq) , .Jmp(Jmp) , .DataSrc(DataSrc), .regDst(regDst), .regWrite(regWrite), .AluSrc(AluSrc), .MemWrite(MemWrite), .MemRead(MemRead), .opcode(opcode));
  ALUcontroller alucu(.AluOp(AluOp), .func(func), .AluOperation(AluOperation));
  
endmodule

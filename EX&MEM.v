module EXandMEM(input clk, rst,input[31:0] ALUres, input[31:0] data, input[4:0] InputDestReg, input InputMemRd, InputMemWr, InputWrReg, InputDataSrc,
       output reg [31:0]ALUresOut, output reg [31:0] Data, output reg[4:0] DestReg, output reg  MemRd, MemWr, WrReg, DataSrc);
       
       always@(posedge clk, posedge rst) begin
         if(rst) {ALUresOut, Data, DestReg, MemRd, MemWr, WrReg, DataSrc} <= 73'b0;
         else begin
            ALUresOut <= ALUres;
            Data <= data;
            DestReg <= InputDestReg;
            MemRd <= InputMemRd;
            MemWr <= InputMemWr;
            WrReg <= InputWrReg;
            DataSrc <= InputDataSrc;
         end
       end
  
endmodule

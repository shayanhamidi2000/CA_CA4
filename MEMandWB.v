module MEMandWB(input clk, rst, input[31:0] data,input[31:0] ALUres, input InputWrReg, InputDataSrc, input[4:0] InputDestReg,
       output reg [31:0]ALUresOut, output reg [31:0] Data, output reg[4:0] DestReg, output reg WrReg, DataSrc);
       
       always@(posedge clk, posedge rst) begin
         if(rst) {ALUresOut, Data, DestReg, WrReg, DataSrc} <= 71'b0;
         else begin
            ALUresOut <= ALUres;
            Data <= data;
            DestReg <= InputDestReg;
            WrReg <= InputWrReg;
            DataSrc <= InputDataSrc;
         end
       end
  
endmodule

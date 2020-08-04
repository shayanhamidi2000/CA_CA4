module EX(input[2:0] AluOperation, input[31:0] rg1, input[31:0] rg2, input[31:0] immVal, input[31:0] WBData, input[31:0] EXData, input[1:0] src1, src2, 
       input AluSrc, RegDst, input[4:0] Rg1, Rg2,
       output[31:0] Alures, Data, output[4:0] Rg);
       
       wire [31:0] mux1, mux2, mux3;
       wire zero;
       
       MUX32in3 mx1(.s0(rg1) , .s2(WBData) , .s1(EXDAta) , .s(src1) , .out(mux1));
       MUX32in3 mx2(.s0(rg2) , .s2(WBData) , .s1(EXDAta) , .s(src2) , .out(mux2));
       MUX32 mx3(.s0(mux2) , .s1(immVal) , .s(AluSrc) , .out(mux3));
       MUX5 mx4(.s0(Rg1) , .s1(Rg2) , .s(RegDst) , .out(Rg));
       
       ALU alu(.A(mux1), .B(mux3), .AluOperation(AluOperation), .zero(zero), .out(Alures));
       
       assign Data = mux2;
       
endmodule

module WB(input[31:0] data,input[31:0] ALUres, input DataSrc, 
       output [31:0]Data);
       
       MUX32 mx3(.s0(ALUres) , .s1(data) , .s(DataSrc) , .out(Data));
endmodule

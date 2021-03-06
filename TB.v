module TB();
  reg clk, rst;
  
  MIPS mp(.rst(rst), .clk(clk));
  
  initial begin
    rst = 1'b1;
    #100
    clk = 1'b0;
    rst = 1'b0;
    #1500
    repeat(20000) #150 clk = ~clk;
    
  end
endmodule

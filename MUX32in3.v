module MUX32in3(input[31:0] s0 , input[31:0] s1 , input[31:0] s2 , input[1:0] s , output[31:0] out);
	assign out = (s == 2'b00) ? s0 : (s == 2'b01) ? s1 : (s == 2'b10) ? s2 : 32'b0; 
endmodule



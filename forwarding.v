module ForwardingUnit(input EXMEMregWr, input[4:0] EXMEMrd, IDEXrs, IDEXrt, input MEMWBregWr, input[4:0] MEMWBrd,
       output[1:0] src1, src2);
       
       assign src1 = (EXMEMregWr == 1 && EXMEMrd == IDEXrs && EXMEMrd != 5'b0) ? 2'b10 : (MEMWBregWr == 1 && MEMWBrd == IDEXrs && MEMWBrd != 5'b0) ? 2'b01 : 2'b0;
       
       assign src2 = (EXMEMregWr == 1 && EXMEMrd == IDEXrt && EXMEMrd != 5'b0) ? 2'b10 : (MEMWBregWr == 1 && MEMWBrd == IDEXrt && MEMWBrd != 5'b0) ? 2'b01 : 2'b0;
  
endmodule


module ForwardingUnit(input EXMEMregWr, input[4:0] EXMEMrd, IDEXrs, IDEXrt, input MEMWBregWr, input[4:0] MEMWBrd,
        /**/input branch, input[4:0] IFIDrs, IFIDrt, output forwardC, forwardD,/**/
       output[1:0] src1, src2);
       
       assign src1 = (EXMEMregWr && EXMEMrd == IDEXrs && EXMEMrd != 5'b0) ? 2'b01 : (MEMWBregWr && MEMWBrd == IDEXrs && MEMWBrd != 5'b0) ? 2'b10 : 2'b0;
       
       assign src2 = (EXMEMregWr && EXMEMrd == IDEXrt && EXMEMrd != 5'b0) ? 2'b01 : (MEMWBregWr && MEMWBrd == IDEXrt && MEMWBrd != 5'b0) ? 2'b10 : 2'b0;
       /**/
       assign forwardC = (branch == 1 && (EXMEMrd == IFIDrs) && EXMEMrd != 5'b0) ? 1'b1 : 1'b0;
       
       assign forwardD = (branch == 1 && (EXMEMrd == IFIDrt) && EXMEMrd != 5'b0) ? 1'b1 : 1'b0;
       
  
endmodule


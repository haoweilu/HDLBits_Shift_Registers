module top_module(
        input    [3:0]    SW       ,
        input    [3:0]    KEY      ,
        output   [3:0]    LEDR   
);

        wire     clk, E, L, w                        ;
        wire     [3:0]    R                          ;
        reg      [3:0]    Q                          ;

        assign   clk   =  KEY[0]                     ;
        assign   E     =  KEY[1]                     ;
        assign   L     =  KEY[2]                     ;
        assign   w     =  KEY[3]                     ;
        assign   LEDR  =  Q                          ;
        assign   R     =  SW                         ;

        MUXDFF muxdff0(clk, E, L, w   , R[3], Q[3])  ;
        MUXDFF muxdff1(clk, E, L, Q[3], R[2], Q[2])  ;
        MUXDFF muxdff2(clk, E, L, Q[2], R[1], Q[1])  ;
        MUXDFF muxdff3(clk, E, L, Q[1], R[0], Q[0])  ;

endmodule

module MUXDFF(
         input            clk      ,
         input            sel_E    ,
         input            sel_L    ,
         input            input_W  ,
         input            input_R  ,
         output           Q
);
     
         always @(posedge clk) begin
                if      (!sel_E && !sel_L) begin
                                Q <= Q               ;
                end
                else if (!sel_E &&  sel_L) begin
                                Q <= input_R         ;
                end
                else if ( sel_E && !sel_L) begin
                                Q <= input_W         ;
                end
                else if ( sel_E &&  sel_L) begin
                                Q <= input_R         ;
                end
         end

endmodule

module top_module(
    input             clk    ,
    input             load   ,
    input      [1:0]  ena    ,
    input      [99:0] data   ,
    output reg [99:0] q 
);

    wire rotates_right, rotates_left           ;

    assign rotates_right = (ena == 2'b01)      ;
    assign rotates_left  = (ena == 2'b10)      ;

    always @(posedge clk) begin
           if       (load)         begin
                      q <= data                ;          
           end
           else if (rotates_right) begin
                      q <= {q[0],q[99:1]}      ;
           end
           else if (rotates_left)  begin
                      q <= {q[98:0],q[99]}     ;
           end
    end

endmodule

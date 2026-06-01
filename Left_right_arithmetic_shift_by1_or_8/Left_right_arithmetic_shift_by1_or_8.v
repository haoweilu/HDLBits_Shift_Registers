module top_module(
    input             clk     ,
    input             load    ,
    input             ena     ,
    input      [1:0]  amount  ,
    input      [63:0] data    ,
    output reg [63:0] q 
);

    wire shift_left_1bit, shift_left_8bit, shift_right_1bit, shift_right_8bit         ;
	
    assign shift_left_1bit  = (amount == 2'b00 && ena)                                ;
    assign shift_left_8bit  = (amount == 2'b01 && ena)                                ;
    assign shift_right_1bit = (amount == 2'b10 && ena)                                ;
    assign shift_right_8bit = (amount == 2'b11 && ena)                                ;

    always @(posedge clk) begin
           if      (load)              begin
                         q <= data                                                    ;
           end
           else if (shift_left_1bit)   begin
                         q <= {q[62:0],1'b0}                                          ;
           end
           else if (shift_left_8bit)   begin
                         q <= {q[55:0],8'b0}                                          ;
           end
           else if (shift_right_1bit)  begin
                         q <= {q[63],q[63:1]}                                         ;
           end
           else if (shift_right_8bit)  begin
                         q <= {{8{q[63]}},q[63:8]}                                    ;
           end
    end

endmodule

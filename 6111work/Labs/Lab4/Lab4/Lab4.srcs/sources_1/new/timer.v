`default_nettype none
module timer ( clk_in, clk_1hz_in,  start_in, value_in, counter_out, expire_out );
    input wire        clk_in;
    input wire        clk_1hz_in;
    input wire        start_in;
    input wire [3:0]  value_in;
    output     [3:0] counter_out;
    output       expire_out;
    
    
    
//    reg [3:0] counter_next = 4'b0;
    reg [3:0] counter_out;
    reg expire_out = 1'b0;
    reg started   = 1'b0;
    reg clk_1hz_prev = 1'b0;
    
    always @(posedge clk_in)
    begin
        clk_1hz_prev <= clk_1hz_in;
        if (start_in)
        begin
            started <= 1'b1;
            expire_out <= 1'b0;
            counter_out <= value_in;
        end
        else
        begin
            if (started & (~(|counter_out)))
            begin
                started <= 1'b0;
                counter_out    <= 0;
                expire_out <= 1'b1;
            end
            else if (started & (clk_1hz_in & ~(clk_1hz_prev)))
            begin
                counter_out <= counter_out - 1;
            end
        end
    end
    
endmodule
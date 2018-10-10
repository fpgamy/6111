module timer ( clk_1hz_in,  start_in, value_in, count_out, expire_out );
    input       clk_1hz_in;
    input       start_in;
    input [3:0] value_in;
    output reg  expire_out;
    output [3:0] count_out;

    
    reg [3:0] counter_out = 4'b1;

    always @(posedge clk_1hz_in or posedge start_in)
    begin
        if (start_in)
        begin
            expire_out <= 1'b0;
            counter_out <= value_in;
        end
        else
        begin
            if (counter_out == 0)
            begin
                counter_out    <= 0;
                expire_out <= 1'b1;
            end
            else
            begin
                counter_out <= counter_out - 1;
            end           
        end
    end
    
endmodule
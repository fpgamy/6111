module timer ( clk_1hz_in,  start_in, value_in, counter_out, expire_out );
    input       clk_1hz_in;
    input       start_in;
    input [3:0] value_in;
    output reg  expire_out;
    output [3:0] counter_out;

    assign counter_out = counter;
    reg [3:0] counter = 4'b1;

    always @(posedge clk_1hz_in or posedge start_in)
    begin
        if (start_in)
        begin
            expire_out <= 1'b0;
            counter <= value_in;
        end
        else
        begin
            if (counter_out == 0)
            begin
                counter    <= 0;
                expire_out <= 1'b1;
            end
            else
            begin
                counter <= counter - 1;
            end           
        end
    end
    
endmodule
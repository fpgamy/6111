`default_nettype none
module clk_divider( clk_in, reset_in, en_in, clk_out );
    parameter RATIO = 12499999;
    parameter WIDTH = $clog2(RATIO);
    input     wire clk_in, en_in, reset_in;
    output    clk_out;
    
    reg clk_out = 0;
    // a counter used to divide by ratio
    reg [(WIDTH-1):0] counter = RATIO;
    
    always @(posedge clk_in or posedge reset_in)
    begin
        if (reset_in)
        begin // reset the counter
            clk_out <= 0;
            counter <= RATIO;
        end
        else if (~en_in)
        begin // reset the counter
            counter <= RATIO;
        end
        else if (counter == 0)
        begin // we are enabled, toggle counter if 0
            clk_out <= ~clk_out;
            counter <= RATIO;
        end
        else
        begin // count down from RATIO
            counter <= counter - 1;
        end
    end

endmodule
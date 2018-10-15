module crc(clk_in, start_in, data_in, done_out, r_out);
    input clk_in, start_in, data_in;
    output done_out;
    output [15:0] r_out;

    reg start_latch          = 1'b0;

    reg  [15:0] r_out        = 16'hFFFF;
    // determines number of clock cycles before done signal is asserted
    reg  [6:0] counter       = 7'd31;
    // the next value of the counter
    wire [6:0] counter_next;
    // done signal is asserted when we get to 64
    // this prevents any potential glitches 
    assign done_out = counter_next[6];
    // increment the counter
    assign counter_next = counter + 1;
    always @ (posedge clk_in)
    begin        
    if (start_in)
        begin
            // reset the vals
            start_latch  <= 1'b1;
            r_out        <= 16'hFFFF;
            counter      <= 7'd31;
        end
        else 
        begin
            if (start_latch & ~(counter_next[6]))
            begin
                // create the gen polynomial
                r_out <= { r_out[15] ^ r_out[14] ^ data_in, 
                            r_out[13:2], 
                            r_out[15] ^ data_in ^ r_out[1], 
                            r_out[0], 
                            r_out[15] ^ data_in
                      };
                counter <= counter_next;
            end
            else 
            begin
                start_latch <= 1'b0;
                // If you don't want done_out to stay high, uncomment below
                // counter <= 7'd32;
            end
        end
    end

endmodule
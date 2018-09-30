module lpset6(clock, start, data, done, r);
    input clock, start, data;
    output done;
    output [15:0] r;

    reg start_latch          = 1'b0;

    reg [15:0] r             = 16'hFFFF;
    // 64 - 16 = 48
    reg [6:0] counter        = 7'd16;
    
    wire processed_48_bits;

    assign processed_48_bits = counter[6];

    always @ (posedge clock)
    begin
        if (start)
        begin
            start_latch <= 1'b1;
            r           <= 16'hFFFF;
            counter     <= 7'd16;
        end
        else 
        begin
            if (start_latch & (~processed_48_bits))
            begin
                r <=  {r[15] ^ r[14] ^ data, 
                                    r[13:2], 
                        r[15] ^ data ^ r[1], 
                                       r[0], 
                               r[15] ^ data
                      };
                counter <= counter + 1;
            end
            else 
            begin
                start_latch <= 1'b0;
                // If you don't want done to stay high, uncomment below
                // counter <= 7'd16;
            end
        end
    end

    assign done = processed_48_bits;

endmodule
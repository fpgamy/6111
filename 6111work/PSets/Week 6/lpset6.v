module lpset6(clock, start, data, done, r);
    input clock, start, data;
    output done;
    output [15:0] r;

    reg start_latch          = 1'b0;

    reg [15:0] r             = 16'hFFFF;
    // 64 - 16 = 48
    reg [6:0] counter        = 7'd31;
    wire [6:0] counter_next;

    assign done = counter_next[6];
    assign counter_next = counter + 1;

    always @ (posedge clock)
    begin
        if (start)
        begin
            start_latch <= 1'b1;
            r           <= 16'hFFFF;
            counter     <= 7'd31;
        end
        else 
        begin
            if (start_latch & (~counter_next[6]))
            begin
                r <=  {r[15] ^ r[14] ^ data, 
                                    r[13:2], 
                        r[15] ^ data ^ r[1], 
                                       r[0], 
                               r[15] ^ data
                      };
                counter <= counter_next;
            end
            else 
            begin
                start_latch <= 1'b0;
                // If you don't want done to stay high, uncomment below
                // counter <= 7'd32;
            end
        end
    end

endmodule
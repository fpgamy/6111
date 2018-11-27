`timescale 1ns / 1ps

module frame_parser(
        input clk,
        input start,
        
        input[9:0] x1, y1, // top-left
        input [9:0] x2, y2, // bottom right
        
        // Goes to big frame buffer
        input[11:0] img_read_data_in,
        output[18:0] img_read_addr_out,
        
        output[11:0] img_write_data_out,
        output[14:0] img_write_addr_out,
        output we_out,
        
        output done
    );
    
// States

parameter IDLE = 0;
parameter DIV_X_START = 1;
parameter DIV_X_END = 2;
parameter DIV_Y_START = 3;
parameter DIV_Y_END = 4;
parameter RESCALING = 5;

reg[3:0] state = 0;


// Actual parameters 

parameter SCREENWIDTH = 640;
parameter SCREENHEIGHT = 480;

parameter TARGET = 'd144;

// Divider variables

reg div_start = 0;
wire div_ready;

wire [9:0] quotient;
wire [9:0] remainder;

reg[9:0] dividend = 0;

// Quotient, remainder for x
reg[9:0] q_x = 0;
reg[9:0] r_x = 0;

// Quotient, remainder for y
reg[9:0] q_y = 0;
reg[9:0] r_y = 0;

// Accumulators
reg[9:0] accl_x = 0;
reg[9:0] accl_y = 0;
wire[9:0] accl_x_temp;
wire[9:0] accl_y_temp;

// Screen positions
reg[9:0] hcount;
reg[9:0] vcount;

// Memory mapping stuff
wire[18:0] read_addr = hcount + SCREENWIDTH * vcount;   
assign img_read_addr_out = read_addr;

divider #(.WIDTH(10)) divider_1 (
    .clk(clk),
    .sign(1'b0), // always positive
    .start(div_start),
    .dividend(dividend),
    .divisor(TARGET - 1),
    .quotient(quotient),
    .remainder(remainder),
    .ready(div_ready));
    
wire[14:0] write_addr;
reg rescale_start = 0;
wire rescale_done;

frame_transfer #(.TARGET(TARGET)) frame_transfer_1 (
    .clk(clk),
    .read_addr(read_addr),
    .read_data(img_read_data_in),
    .write_addr_out(img_write_addr_out),
    .write_data_out(img_write_data_out),
    .we_out(we_out),
    .start(rescale_start),
    .done(rescale_done));

//assign accl_x_temp = accl_x + r_x;
//assign accl_y_temp = accl_y + r_y;

always @(posedge clk) begin
    case(state)
        IDLE: begin
            if(start) begin
                state <= DIV_X_START;
            end
        end
        DIV_X_START: begin
            // Load variables we want to divide
            dividend <= x2 - x1;
            div_start <= 1;
            state <= DIV_X_END;
        end
        DIV_X_END: begin
            if(div_ready) begin
                q_x <= quotient;
                r_x <= remainder;
                state <= DIV_Y_START;
            end
        end
        DIV_Y_START: begin
            dividend <= y2 - y1;
            div_start <= 1;
            state <= DIV_Y_END;
        end
        DIV_Y_END: begin
            if(div_ready) begin
                q_y <= quotient;
                r_y <= remainder;
                state <= RESCALING;
                // Prepare for rescaling...
                hcount <= x1;
                vcount <= y1;
                
                rescale_start <= 1;
            end
        end
        RESCALING: begin
            // Memory address mapping shit...
            // Basically a while loop here 
            accl_x = accl_x + r_x;
            
            if(hcount < (x2 - q_x)) begin
                if(accl_x >= TARGET) begin
                    hcount <= hcount + q_x + 1;
                    accl_x <= accl_x - TARGET;
                end else begin
                    hcount <= hcount + q_x;
                end
            end else if (vcount < (y2 - q_y)) begin
                hcount <= x1;
                accl_x <= 0;
                accl_y = accl_y + r_y;

                if(accl_y >= TARGET) begin
                    vcount <= vcount + q_y + 1;
                    accl_y <= accl_y - TARGET;
                end else begin
                    vcount <= vcount + q_y;
                end
            end else if (rescale_done) begin
                state <= IDLE;
            end          
        end
    endcase
    
    // Reset start signals
    if(div_start) div_start <= 0;
    if(rescale_start) rescale_start <= 0;
end

assign done = (state == 0);

endmodule

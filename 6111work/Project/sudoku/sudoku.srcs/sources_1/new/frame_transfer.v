`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 02:28:24 PM
// Design Name: 
// Module Name: frame_transfer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module frame_transfer(
        input clk,
        input[18:0] read_addr,
        input[11:0] read_data,
        
        // Properly timed outputs
        output[14:0] write_addr_out,
        output[11:0] write_data_out,
        
        output we_out,
        
        input start,
        output done
    );
   
parameter TARGET = 144;
parameter MAX_CYCLES = TARGET ** 2 + 2;

// States
parameter IDLE = 0;
parameter TRANSFERRING = 1;

reg state = 0;

reg[15:0] cycle_count = 0;

// Shift registers for data, addresses

// Read data shift register (only 2 needed)
reg[11:0] read_data_sr[1:0];

// Write address SR (only 1 needed)
// I guess not really a shift register but whatever
//reg[14:0] write_addr_sr;

always @(posedge clk) begin
    case(state)
        IDLE: begin
            if(start) begin
                state <= TRANSFERRING;
                read_data_sr[1] <= read_data_sr[0];
                read_data_sr[0] <= read_data;
                cycle_count <= 0;
            end
        end
        TRANSFERRING: begin
            cycle_count <= cycle_count + 1;

            // Shift data
            read_data_sr[1] <= read_data_sr[0];
            read_data_sr[0] <= read_data;
//            write_addr_sr <= write_addr;
            
            if(cycle_count == MAX_CYCLES - 1) begin
                state <= IDLE;
            end
        end
    endcase
    
end

//assign write_addr_out = write_addr_sr;
assign write_addr_out = cycle_count;
assign write_data_out = read_data_sr[1];
assign we_out = (state == TRANSFERRING);
assign done = !start && (cycle_count == MAX_CYCLES);
endmodule

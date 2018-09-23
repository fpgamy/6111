module mem_controller(
						input        clk_in,
						input        req_in,
						output       ras_out,
						output       mux_out,
						output       cas_out
					);

	localparam STATE_IDLE = 3'b000;
	localparam STATE_ROW  = 3'b001;
	localparam STATE_MUX  = 3'b011;
	localparam STATE_COL  = 3'b010;
	localparam STATE_HOLD = 3'b110;

	reg [2:0] state = STATE_IDLE;

	assign ras_out = (state == STATE_IDLE);
	assign mux_out = ~((state == STATE_IDLE) | (state == STATE_ROW));
	assign cas_out = ((state == STATE_IDLE) | (state == STATE_ROW) | (state == STATE_MUX));

	// state machine
	always @(posedge clk_in)
	begin
		case (state)
			STATE_IDLE : state <= req_in ? STATE_ROW : STATE_IDLE;
			STATE_ROW  : state <= STATE_MUX;
			STATE_MUX  : state <= STATE_COL;
			STATE_COL  : state <= STATE_HOLD;
			STATE_HOLD : state <= STATE_IDLE;
		endcase
	end

endmodule
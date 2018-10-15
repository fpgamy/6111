localparam RADIUS_SQ = RADIUS*RADIUS

always @(posedge clk_65mhz)
begin
	deltax <= (hcount > (x+RADIUS)) ? (hcount - (x + RADIUS)) : ((x + RADIUS) - hcount);
	deltax <= (vcount > (y+RADIUS)) ? (vcount - (x + RADIUS)) : ((y + RADIUS) - vcount);
	if (deltax*deltax + deltay*deltay <= RADIUS_SQ)
	begin
		pixel <= COLOR;
	end
	else 
	begin
		pixel <= 1'b0;	
	end
end
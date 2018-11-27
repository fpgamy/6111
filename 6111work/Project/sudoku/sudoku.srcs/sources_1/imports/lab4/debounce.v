// Switch Debounce Module
// use your system clock for the clock input
// to produce a synchronous, debounced output
module debounce #(parameter DELAY=250000)   // .01 sec with a 100Mhz clock
	        (input reset, clk, noisy,
	         output reg clean);

   reg [19:0] count = 0;
   reg new;

   always @(posedge clk)
     if (reset)
       begin
	  count <= 0;
	  new <= noisy;
	  clean <= noisy;
       end
     else if (noisy != new)
       begin
	  new <= noisy;
	  count <= 0;
       end
     else if (count == DELAY)
       clean <= new;
     else
       count <= count+1;
      
endmodule
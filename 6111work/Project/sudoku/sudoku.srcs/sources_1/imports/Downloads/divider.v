// The divisor module divides one number by another. It
// produces a signal named "ready" when the quotient output
// is ready, and takes a signal named "start" to indicate
// the the input dividend and divisor is ready.
// sign -- 0 for unsigned, 1 for twos complement

// It uses a simple restoring divide algorithm.
// http://en.wikipedia.org/wiki/Division_(digital)#Restoring_division

module divider #(parameter WIDTH = 8) 
  (input clk, sign, start,
   input [WIDTH-1:0] dividend, 
   input [WIDTH-1:0] divisor,
   output reg [WIDTH-1:0] quotient,
   output [WIDTH-1:0] remainder,
   output ready);

   reg [WIDTH-1:0]  quotient_temp;
   reg [WIDTH*2-1:0] dividend_copy, divisor_copy, diff;
   reg negative_output;
   
   assign remainder = (!negative_output) ?
             dividend_copy[WIDTH-1:0] : ~dividend_copy[WIDTH-1:0] + 1'b1;

   reg [5:0] bit;
   reg del_ready = 1;
   assign ready = (!bit) & ~del_ready;

   wire [WIDTH-2:0] zeros = 0;
   initial bit = 0;
   initial negative_output = 0;
   always @( posedge clk ) begin
      del_ready <= !bit;
      if( start ) begin

         bit = WIDTH;
         quotient = 0;
         quotient_temp = 0;
         dividend_copy = (!sign || !dividend[WIDTH-1]) ?
                         {1'b0,zeros,dividend} :  
                         {1'b0,zeros,~dividend + 1'b1};
         divisor_copy = (!sign || !divisor[WIDTH-1]) ?
			 {1'b0,divisor,zeros} :
			 {1'b0,~divisor + 1'b1,zeros};

         negative_output = sign &&
                           ((divisor[WIDTH-1] && !dividend[WIDTH-1])
                            ||(!divisor[WIDTH-1] && dividend[WIDTH-1]));
       end
      else if ( bit > 0 ) begin
         diff = dividend_copy - divisor_copy;
         quotient_temp = quotient_temp << 1;
         if( !diff[WIDTH*2-1] ) begin
            dividend_copy = diff;
            quotient_temp[0] = 1'd1;
         end
         quotient = (!negative_output) ?
                    quotient_temp :
                    ~quotient_temp + 1'b1;
         divisor_copy = divisor_copy >> 1;
         bit = bit - 1'b1;
      end
   end
endmodule

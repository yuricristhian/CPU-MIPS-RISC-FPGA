`timescale 10ms/100us
module extend_TB;
reg [15:0] in;
wire [31:0] out;
	
extend DUT (
.dataIn(in), 
.dataOut(out)
);
initial begin
	in = 0;
	#20 in = 3;
	#20 in = 15;
	#20 in = 65;
	#20 in = 255;
	#20 in = 1023;
	#20 in = 4095;
	#20 in = 16383;
	#20 in = 65535;	
	end	
	initial #200 $stop;
endmodule 
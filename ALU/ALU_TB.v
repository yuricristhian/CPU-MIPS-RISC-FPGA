`timescale 10ms/100us
module ALU_TB;
reg clock2;
reg [2:0] ULAops;
reg [31:0]ULAa;
reg [31:0]ULAb;
reg reset;
wire [31:0]ULAout;
ALU DUT(
.clock2(clock2),
.ULAops(ULAops),
.ULAa(ULAa),
.ULAb(ULAb),
.ULAout(ULAout) 
);
initial begin
	clock2 = 0;
	forever #1 clock2 = ~clock2;
end
initial begin
	reset = 1'd1;
	#1 reset = 1'd0;
	ULAops = 3'd1;
	ULAa = 32'd3000;
	ULAb = 32'd2000;
	#80 ULAops = 3'd2;
	#80 ULAa = 32'd4000;
		 ULAb = 32'd2000;
		 ULAops = 3'd3;
	#80 ULAops = 3'd0;
end
initial begin
	#300 $stop;
end

endmodule


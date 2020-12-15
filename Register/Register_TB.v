`timescale 10ms/100us
module Register_TB();
reg [31:0] regIn;
reg clock, reset;
wire [31:0] regOut;
Register DUT(
.regIn(regIn),
.clock(clock),
.reset(reset),
.regOut(regOut)
);
initial begin
clock = 0;
reset = 1;
regIn = 0;
#20 reset = 0;
#20 regIn = 1;
#20 regIn = 2;
#20 regIn = 3;
#20 regIn = 4;
#20 regIn = 5;
#20 regIn = 6;
#20 regIn = 7;
#200 $stop;
end
initial begin
forever #10 clock = ~clock;
end

endmodule 
`timescale 10ms/100us
module mux_TB();
reg [31:0] muxInA, muxInB;
reg select;
wire [31:0] muxOut;

mux DUT(
.muxInA(muxInA),
.muxInB(muxInB),
.select(select),
.muxOut(muxOut)
);
initial begin
muxInA = 32'h55555555;
muxInB = 32'hAAAAAAAA;
select = 0;
#30 select = 1;
#30 $stop;
end
endmodule 
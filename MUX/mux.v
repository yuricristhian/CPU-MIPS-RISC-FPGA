module mux(
input [31:0] muxInA,
input [31:0] muxInB,
input select,
output reg [31:0] muxOut
);
always @(muxInA or muxInB or select) begin
if(select)
muxOut <= muxInB;
else if(~select)
muxOut <= muxInA;
end

endmodule 
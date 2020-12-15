module Register(
input [31:0] regIn,				//Data imput
input clock, reset,				
output reg [31:0] regOut
);
initial begin
regOut <= 0;
end
always @(posedge clock or posedge reset) begin
if (reset)
regOut <= 0;
else
regOut <= regIn;
end
endmodule 
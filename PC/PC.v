module PC(
input clock, reset,
output reg [9:0] PCAdress
);

always @(posedge reset, posedge clock) begin
	if (reset)
	PCAdress <= 9'b0;
	else PCAdress <= PCAdress +1'd1;
	end
endmodule 
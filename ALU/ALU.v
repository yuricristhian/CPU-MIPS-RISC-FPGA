module ALU(
input clock2,
input reset,
input [2:0] ULAops,
input [31:0]ULAa,
input [31:0]ULAb,
output reg [31:0]ULAout);

wire [31:0]result;
wire done;
reg  start;
reg [31:0]oldULAa;
reg [31:0]oldULAb;
integer counter;	 
			  
Multiplier multiplier_1(
	.start(start), 
	.clockMul(clock2),
	.mult1(ULAa[15:0]),
	.mult2(ULAb[15:0]), 
	.done(done), 
	.produto(result)
);

initial begin
	start = 0;
	oldULAa = ULAa;
	oldULAb = ULAb;
end 

always @(ULAops or ULAa or ULAb or result)begin
	if (reset == 1) begin
		ULAout <= 0;
	end else begin
		case (ULAops)
					3'd1:
						begin
							ULAout <= ULAa + ULAb;
						end
					3'd2:
						begin
							ULAout <= ULAa - ULAb;
						end
					3'd3:
						begin
							ULAout <= result;
						end
					3'd4:
						begin
							ULAout <= ULAa & ULAb;
						end
					3'd5:
						begin
							ULAout <= ULAa | ULAb;
						end
					default: ULAout <= 32'd0;
		endcase
	end
end

always @(negedge clock2) begin
	if (ULAops == 3) begin
		if (done == 1) begin
			start = 0;
			if ((oldULAa != ULAa) | (oldULAb != ULAb)) begin
				start = 1;
			end
		end else begin
			start = 1;
		end
	end
	oldULAa = ULAa;
	oldULAb = ULAb;
end

endmodule

`timescale 10ms/100us
module PC_TB();
reg clock, reset;
wire [9:0] PCAdress;
PC DUT(
.clock(clock),
.reset(reset),
.PCAdress(PCAdress)
);
initial begin
clock =0;
reset =1;
#10 reset = 0;
end
always #10 clock = ~clock;
initial
#20520 $stop;
endmodule 
`timescale 10ms/100us
module instructionmemory_TB();
reg [9:0] Adress;
reg clock;
wire [31:0] Instruction;
integer i;

instructionmemory DUT(
.Adress(Adress),
.Instruction(Instruction),
.clock(clock)
);
initial begin
Adress = 0;
clock = 0;
for (i=0;i<1023;i=i+1)
#10 Adress = Adress + 1;
end
always begin
#5 clock = ~clock;
end
initial begin
#2000 $stop;
end
endmodule 
`timescale 10ms/100us
module cpu_TB();
reg clock, clock2;
reg reset;
wire [31:0] mux2Out;
wire [31:0] readyData;
wire [31:0] aluOut;
wire [31:0] rawData;
wire [31:0] regsOutA;
wire [31:0] mux1Out;
wire [31:0] regsOutB;
wire [6:0]  regCtrR3Out;
wire [2:0]  regCtrR1Out;

cpu DUT(
.clock2(clock2),
.clock(clock),
.reset(reset),
.mux2Out(mux2Out), 
.readyData(readyData), 
.aluOut(aluOut),
.rawData(rawData),
.regsOutA(regsOutA),
.mux1Out(mux1Out),
.regsOutB(regsOutB),
.regCtrR1Out(regCtrR1Out),
.regCtrR3Out(regCtrR3Out)
);

initial begin
clock = 0;
clock2= 0;
reset = 1;
#1 reset = 0;
end
initial begin
forever #18 clock = ~clock;
end
initial begin
forever #1 clock2 = ~clock2;
end
initial begin
#1188 $stop;
end
endmodule 
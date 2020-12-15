`timescale 10ms/100us
module datamemory_TB();
reg[31:0] ramIn;
reg [9:0] ramAdress;
reg clock, ramWP;
wire [31:0] ramOut;

datamemory DUT(
.ramIn(ramIn),
.ramAdress(ramAdress),
.clock(clock),
.ramWP(ramWP),
.ramOut(ramOut)
);
initial begin
	ramIn=32'hA0000000;
	ramAdress=0; //h07D0
	clock=0;
	ramWP=1;  //read
	#10 clock = ~clock;
	#10 clock = ~clock;
	ramAdress=1; //h0FA0
	#10 clock = ~clock;
	#10 clock = ~clock;
	ramAdress=2; //h07D0
	#10 clock = ~clock;
	#10 clock = ~clock;
	ramAdress=3; //h0BB8
	#10 clock = ~clock;
	#10 clock = ~clock;
	ramWP=0;		//write
	ramAdress=4;
	#10 clock = ~clock;
	#10 clock = ~clock;
	ramIn=32'h50000000;
	ramAdress=5;
	#10 clock = ~clock;
	#10 clock = ~clock;
	ramIn=32'hF0000000;
	ramAdress=6;
	#10 clock = ~clock;
	#10 clock = ~clock;
	ramIn=32'h70000000;
	ramAdress=7;
	#10 clock = ~clock;
	#10 clock = ~clock;
	ramWP=1;			//read
	ramAdress=4; 	
	#10 clock = ~clock;
	#10 clock = ~clock;
	ramAdress=5; 	
	#10 clock = ~clock;
	#10 clock = ~clock;
	ramAdress=6; 	
	#10 clock = ~clock;
	#10 clock = ~clock;
	ramAdress=7; 
	#10 clock = ~clock;
	#10 clock = ~clock;
end
initial begin
	#250 $stop;
end
endmodule 
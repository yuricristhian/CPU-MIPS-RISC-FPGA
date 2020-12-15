`timescale 10ms/100us
module registerfile_TB();
reg clock, reset, registerFileWP;
reg [4:0] regS, regT, regD; 
reg [31:0] regsIn;
wire [31:0] regsOutA, regsOutB;

registerfile DUT(
.clock(clock),
.reset(reset),
.regS(regS),
.regT(regT),
.regD(regD),
.regsIn(regsIn),
.regsOutA(regsOutA),
.regsOutB(regsOutB),
.registerFileWP(registerFileWP)
);
initial begin
	clock = 0;
	regsIn = 0;
	registerFileWP = 1;
	reset = 1;
	regD = 5'b00000;
	regS = 5'b00000;
	regT = 5'b00000;
	#10 reset = 0;
	regsIn = 32'h05555555;
	registerFileWP = 0;
	regD = 5'b00111;
	#10 clock = 1; #10 clock = 0; //grava h05555555 no regS7
	regsIn = 32'h0AAAAAAA;
	regD = 5'b01111;
	#10 clock = 1; #10 clock = 0; //grava h0AAAAAAA no regT7
	registerFileWP = 1;
	regS = 7;
	regT = 15;
	#10 clock = 1; #10 clock = 0; //joga regS7 em regA e regT7 em regB
	
end
endmodule 
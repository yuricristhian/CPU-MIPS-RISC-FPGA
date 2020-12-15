module registerfile(
input clock, reset, registerFileWP,		//Clock, Reset and Write Protection
input [4:0] regS, regT, regD, 			//Registers
input [31:0] regsIn, 						//Imput Data
output reg [31:0] regsOutA, regsOutB 	//Outputs A nad B
);
									//Registers criation
									
reg [31:0] regS0, regS1, regS2, regS3, regS4, regS5, regS6, regS7;
reg [31:0] regT0, regT1, regT2, regT3, regT4, regT5, regT6, regT7;

									//Registers starts with zeroes
initial begin
	regS0 = 0; regS1 = 0; regS2 = 0; regS3 = 0; regS4 = 0; regS5 = 0; regS6 = 0; regS7 = 0;
	regT0 = 0; regT1 = 0; regT2 = 0; regT3 = 0; regT4 = 0; regT5 = 0; regT6 = 0; regT7 = 0;
end	 
always @(posedge clock or posedge reset) begin
	if (reset)begin
		regS0 = 32'd0; regS1 = 32'd0; regS2 = 32'd0; regS3 = 32'd0; regS4 = 32'd0; regS5 = 32'd0; regS6 = 32'd0; regS7 = 32'd0;
		regT0 = 32'd0; regT1 = 32'd0; regT2 = 32'd0; regT3 = 32'd0; regT4 = 32'd0; regT5 = 32'd0; regT6 = 32'd0; regT7 = 32'd0;	
	end
	else if(registerFileWP == 0)	begin			//Check if Write Protection is off (Write)
	  case(regD)
			00: regS0 <= regsIn;
			01: regS1 <= regsIn;
			02: regS2 <= regsIn;
			03: regS3 <= regsIn;
			04: regS4 <= regsIn;
			05: regS5 <= regsIn;
			06: regS6 <= regsIn;
			07: regS7 <= regsIn;
			08: regT0 <= regsIn;
			09: regT1 <= regsIn;
			10: regT2 <= regsIn;
			11: regT3 <= regsIn;
			12: regT4 <= regsIn;
			13: regT5 <= regsIn;
			14: regT6 <= regsIn;
			15: regT7 <= regsIn;
	  endcase end
	else begin
	if (registerFileWP == 1) begin				//Check of Write Protection is on (Read)
		case(regS) 										//Check with register should be send to output A
			00: regsOutA = regS0; 
			01: regsOutA = regS1; 
			02: regsOutA = regS2; 
			03: regsOutA = regS3; 
			04: regsOutA = regS4; 
			05: regsOutA = regS5; 
			06: regsOutA = regS6;
			07: regsOutA = regS7; 
			08: regsOutA = regT0; 
			09: regsOutA = regT1; 
			10: regsOutA = regT2; 
			11: regsOutA = regT3; 
			12: regsOutA = regT4; 
			13: regsOutA = regT5; 
			14: regsOutA = regT6; 
			15: regsOutA = regT7;
	  default regsOutA = 0;
	  endcase		
		case(regT) 										//Check with register should be send to output B
			00: regsOutB = regS0; 
			01: regsOutB = regS1; 
			02: regsOutB = regS2; 
			03: regsOutB = regS3; 
			04: regsOutB = regS4; 
			05: regsOutB = regS5; 
			06: regsOutB = regS6; 
			07: regsOutB = regS7; 
			08: regsOutB = regT0; 
			09: regsOutB = regT1; 
			10: regsOutB = regT2; 
			11: regsOutB = regT3; 
			12: regsOutB = regT4; 
			13: regsOutB = regT5; 
			14: regsOutB = regT6; 
			15: regsOutB = regT7;
	  default regsOutB = 0; 
	  endcase 
	 end
	end
end
endmodule 
module control(
input [31:0] rawData,
output reg [31:0] readyData
);
reg [4:0] RS, RT, RD;
parameter NOP = 4'd0, LW = 4'd1, SW = 4'd2, ADD = 4'd3, SUB = 4'd4, MULT = 4'd5, AND = 4'd6, OR = 4'd7; 
reg [5:0] WTD; 														// 7 or 8 = I type, where 7 = LW and 8 = SW. If 6 =  R type for ALU
reg [5:0] OPR; 														// 32 = ADD, 34 = SUB, 36 = AND, 37 = OR and 50 = MULT;
reg [3:0] CODEFUNC; 													// R type operations
reg [2:0] ALUops;														// Destiny Registers
reg SelectMux1, SelectMux2, registerfileWP, ramWP;	      // Periferal Controls
initial begin
	readyData={25'd0, 1'd1,  1'd1, 1'd1, 1'd1, 3'd0};
	WTD = 6'd0;
	RT = 5'd0;
	RS = 5'd0;
	CODEFUNC = 4'd0;
	OPR = 6'd0;
	RD = 5'd0;
	ALUops = 3'd0;
	SelectMux1 = 1'd1;
	SelectMux2 = 1'd1;
	registerfileWP = 1'd1;
	ramWP = 1'd1;
end
always @(rawData) begin
	WTD  =  rawData [31:26]; // What to do
	RD   =  rawData [25:21]; // D Destiny 
	RS   =  rawData [20:16]; // S Registers
	RT   =  rawData [15:11]; // T Registers
	OPR  =  rawData [5:0];	 // ALU Operation
	//Identifying What To Do
	if (WTD == 6'd0)
		CODEFUNC = NOP;
		else if (WTD ==6'd7)
			CODEFUNC = LW;
			else if (WTD == 6'd8)
				CODEFUNC = SW;
				else if (WTD == 6'd6) begin
					case (OPR)
						6'd32: CODEFUNC = ADD;
						6'd34: CODEFUNC = SUB;
						6'd36: CODEFUNC = AND;
						6'd37: CODEFUNC = OR;
						6'd50: CODEFUNC = MULT;
					default : CODEFUNC = ADD;
					endcase end
	case (CODEFUNC)
	LW:	begin
		registerfileWP = 1'd0;
		SelectMux1 = 1'd1;
		SelectMux2 = 1'd1;
		ramWP = 1'd1;
		ALUops = 3'd1;
		end
	SW:	begin
		registerfileWP = 1'd1;
		SelectMux1 = 1'd1;
		SelectMux2 = 1'd1;
		ramWP = 1'd0;
		ALUops = 3'd1;
		end
	ADD:	begin
		registerfileWP = 1'd0;
		SelectMux1 = 1'd0;
		SelectMux2 = 1'd0;
		ramWP = 1'd1;
		ALUops = 3'd1;
		end
	SUB:	begin
		registerfileWP = 1'd0;
		SelectMux1 = 1'd0;
		SelectMux2 = 1'd0;
		ramWP = 1'd1;
		ALUops = 3'd2;
		end
	MULT:	begin
		registerfileWP = 1'd0;
		SelectMux1 = 1'd0;
		SelectMux2 = 1'd0;
		ramWP = 1'd1;
		ALUops = 3'd3;
		end
	AND:  begin
		registerfileWP = 1'd0;
		SelectMux1 = 1'd0;
		SelectMux2 = 1'd0;
		ramWP = 1'd1;
		ALUops = 3'd4;
		end
	OR:	begin
		registerfileWP = 1'd0;
		SelectMux1 = 1'd0;
		SelectMux2 = 1'd0;
		ramWP = 1'd1;
		ALUops = 3'd5;
		end
	NOP:	begin
		registerfileWP = 1'd1;
		SelectMux1 = 1'd0;
		SelectMux2 = 1'd0;
		ramWP = 1'd1;
		ALUops = 3'd0;
		end
	endcase		  
	readyData = {10'd0, RD, RS, RT, registerfileWP,  SelectMux1, SelectMux2, ramWP, ALUops}; //10 5 5 5 1 1 1 1 3                                                                        
end
endmodule 
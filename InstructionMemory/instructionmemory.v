module instructionmemory(
input [9:0] Adress,
input clock,
output reg [31:0] Instruction
);
parameter 	NOP = 32'd0, LW = 6'd7, SW = 6'd8, ADD = {5'd10 ,6'd32}, SUB = {5'd10, 6'd34},
				MULT = {5'd10, 6'd50},  AND = {5'd10, 6'd36}, OR = {5'd10, 6'd37}, ALU = 6'd6;
reg [31:0] rom [0:(1<<10)-1];
integer i;
initial
	begin : MEM_WRITE
		for(i = 0; i < 1023; i = i + 1)begin
		rom[i]=NOP;
		//Pipeline Hazzard
		rom[00] = {LW, 	5'd1, 	5'd0, 	16'd1				}; //	A=>reg1
		rom[01] = {LW, 	5'd2, 	5'd0, 	16'd2				}; //	B=>reg2
		rom[02] = {LW, 	5'd3, 	5'd0, 	16'd3				}; //	C=>reg3
		rom[03] = {LW,		5'd4, 	5'd0, 	16'd4				}; //	D=>reg4
		rom[04] = {ALU,	5'd5,		5'd1,		5'd2,		MULT	};	// A*B=>reg12
		rom[05] = {ALU,	5'd6,		5'd3,		5'd4,		ADD	};	// C+D=>reg12
		rom[06] = {ALU,	5'd7,		5'd5,		5'd3,		SUB	};	// (A*B)-(C+D)=>reg12
		
		//To work properly we have to wait a few clocks cicles
		
		rom[11] = {LW, 	5'd8, 	5'd0, 	16'd1				}; //A=>reg8
		rom[12] = {LW, 	5'd9, 	5'd0, 	16'd2				}; //B=>reg9
		
		//Here we wait 5 clocks to save the words A (32'd4000) and B (32'd2000)
		
		rom[17] = {LW, 	5'd10, 	5'd0, 	16'd3				}; //C=>reg10
		rom[18] = {LW,		5'd11, 	5'd0, 	16'd4				}; //D=>reg11
		
		//Here we wait more 5 clocks to save the words C (32'd2000) and D (32'd3000)
		
		rom[23] = {ALU,	5'd12,	5'd8,		5'd9,		MULT	};// A*B=>reg12
		rom[24] = {ALU,	5'd13,	5'd10,	5'd11,	ADD	};// C+D=>reg13
		
		//here again we wait 5 clocks to store properly the operations  A*B (32'd8000000) and C+D(32'd5000)
		
		rom[29] = {ALU,	5'd14,	5'd12,	5'd13,	SUB	};
		
		//And finaly, after some more clocks we have our final result (A*B)-(C+D) = 32'd7995000
		
	end
end
always @(posedge clock) 
	begin : MEM_READ
		Instruction <= rom[Adress];
	end
endmodule 

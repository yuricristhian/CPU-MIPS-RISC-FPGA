`timescale 10ms/100us
	//			   [31:22]  [21:17] [16:12] [11:7]      [5]            [4]         [3]       [3]    [2:0]
	//readyData ={10'd0,    RS,     RT,    RD,  registerfileWP,  SelectMux1, SelectMux2, ramWP, ALUops}; //10 5 5 5 1 1 1 1 3
module control_TB();
reg  [31:0] rawData;
wire [31:0] readyData;
parameter 	NOP = 32'd0, LW = 6'd7, SW = 6'd8, ADD = {5'd10 ,6'd32}, SUB = {5'd10, 6'd34},
				MULT = {5'd10, 6'd50}, AND = {5'd10, 6'd36}, OR = {5'd10, 6'd37}, ALU = 6'd6;
control DUT(
.rawData(rawData),
.readyData(readyData)
);
initial begin
		rawData = NOP;
	#1 rawData = {LW,  5'd0, 5'd0, 16'd0};		//LW		1C000000 - 00000039
	#1 rawData = {SW,  5'd0, 5'd0, 16'd0};		//SW		20000001 - 00000071
	#1 rawData = {ALU, 5'd0, 5'd0 , 5'd0, ADD};	//ADD		180002A0 - 00000009
	#1 rawData = {ALU, 5'd0, 5'd0 , 5'd0, SUB};	//SUB		180002A2 - 0000000A
	#1 rawData = {ALU, 5'd0, 5'd0 , 5'd0, MULT};//MULT		180002B2 - 0000000B
	#1 rawData = {ALU, 5'd0, 5'd0 , 5'd0, AND};	//AND		180002A4 - 0000000C
	#1 rawData = {ALU, 5'd0, 5'd0 , 5'd0, OR};	//OR		180002A5 - 0000000D 
end		
initial begin
   #10 $stop;
end
endmodule 
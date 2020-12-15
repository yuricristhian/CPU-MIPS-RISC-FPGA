module datamemory(
input [31:0] ramIn,
input [9:0] ramAdress,
input clock, ramWP,
output reg [31:0] ramOut
);
reg [31:0] ram [0:(1<<10)-1];
integer i;
initial
	begin
		ram[0] = {32'd0000};
		ram[1] = {32'd2000};
		ram[2] = {32'd4000};
		ram[3] = {32'd2000};
		ram[4] = {32'd3000};
	for(i = 5; i < 1023; i = i + 1)
		ram[i]=32'd0;
end
always @(posedge clock) 
	begin 
		if(ramWP)
		ramOut <= ram[ramAdress];
		else if(~ramWP)
		ram[ramAdress] <= ramIn;
	end
endmodule 

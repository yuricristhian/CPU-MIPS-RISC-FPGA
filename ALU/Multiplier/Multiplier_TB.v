`timescale 1ms/100us

module Multiplier_TB;

reg start, clockMul;
reg [31:0]mult1; 
reg [31:0]mult2;
wire done;
wire [31:0]produto;

integer i, j;

Multiplier DUT(
	.start(start),
	.clockMul(clockMul),
	.mult1(mult1),
	.mult2(mult2),
	.done(done),
	.produto(produto)
);

initial begin
	clockMul = 0;
	forever #10 clockMul = ~clockMul;
end


initial begin
	start = 1;
	mult1 = 5;
	mult2 = 6;
	#20 start = 0;
end

initial begin											//Estrutura para contar o clock
	i = 0;
	j = 0;
	#10 i = 1;
	for (j = 0; j < 100; j = j+1)begin
		#20 i = i + 1;
		if (i == 34) begin
			mult1 = 10;
			mult2 = 20;
		end
	end
	
end

initial begin
	#2000 $stop;
end

endmodule

module Multiplier (
input start, clockMul,
input [15:0]mult1, 
input [15:0]mult2,
output reg done,
output reg [31:0]produto
);
						 
reg [32:0]register;
reg [16:0]soma;
reg load;
integer estado, count;

initial begin
	load = 0;
	estado = 0;
	done = 0;
	produto = 0;
end


always @(posedge clockMul) begin

	if  ((start == 0) & (load == 0)) begin
		estado = 0;
	end else begin
		if (estado == 0) begin
			estado = 1;
			load = 1;
			count = 0;
		end
	end
	
	if (estado == 1) begin
		register[32:16] = 0;								//carregou o registrador	
		register[15:0] = mult2[15:0];					//colocou o mult2 no byte menos significativo
		estado = 2;											//próximo estado
	end
	
	if (estado == 2) begin
		if(register[0] == 1) begin						//O ultimo bit é igual a 1?
			soma = mult1[15:0] + register[31:16];  //se sim soma
			register[32:16] = soma;
			estado = 3;
		end else begin										//se não pula soma
			estado = 3;
		end
	end
	
	if (estado == 3) begin						
		register = register >> 1;						//shift
		count = count + 1;
		if(count == 16) begin
			produto <= register[31:0];
			done <= 1;
			load = 0;
			estado  = 0;
		end else begin
			done <= 0;
			estado = 2;
		end		
	end
	
end
	
endmodule

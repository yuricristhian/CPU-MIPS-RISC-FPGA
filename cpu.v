//			   [31:22]  [21:17] [16:12] [11:7]      [6]            [5]         [4]       [3]    [2:0]
//readyData ={10'd0,    RD,     RS,    RT,  registerfileWP,  SelectMux1, SelectMux2, ramWP, ALUops}; //10 5 5 5 1 1 1 1 3
module cpu(
input clock, clock2, 
input reset,
output [31:0] rawData,			//rom out
output [31:0] mux2Out,			//regFileIn
output [31:0] readyData,		//control out
output [31:0] aluOut,			//alu out, usualy is the ram address
output [31:0] regsOutA,
output [31:0] mux1Out,
output [31:0] regsOutB,
output [31:0] regCtrR1Out,
output [31:0] regCtrR3Out
);
/* ----------------------------------------1 stage------------------------------------------- */
PC pc1(.clock(clock),.reset(reset),.PCAdress(PCAdress));
 wire [9:0] PCAdress;

instructionmemory rom1(.Adress(PCAdress),.clock(clock),.Instruction(rawData));
 //wire  [31:0] rawData;

/* ----------------------------------------2 stage------------------------------------------- */

extend ext1(.dataIn(rawData[15:0]),.dataOut(extendOut));
 wire [31:0] extendOut;

control ctr1(.rawData(rawData),.readyData(readyData));
// wire [31:0] readyData;

registerfile RF1(.clock(clock),.reset(reset),.registerFileWP(regCtrR3Out[6]),.regT(readyData [11:07]),
.regS(readyData [16:12]),.regD(regCtrR3Out[21:17]), .regsIn(mux2Out), .regsOutA(regsOutA),.regsOutB(regsOutB));
 //wire [31:0] regsOutA;
 //wire [31:0] regsOutB;
 
Register ctrR1(.regIn(readyData),.clock(clock),.reset(reset),.regOut(regCtrR1Out));
 //wire [31:0] regCtrR1Out;

Register imm(.regIn(extendOut),.clock(clock),.reset(reset),.regOut(regIMMOut));
 wire [31:0] regIMMOut;			

/* ----------------------------------------3 stage------------------------------------------- */
mux mux1(.muxInA(regsOutB),.muxInB(regIMMOut),.select(regCtrR1Out[5] ),.muxOut(mux1Out));
 //wire [31:0] mux1Out;

ALU alu1(.reset(reset),.clock2(clock2),.ULAa(regsOutA),.ULAb(mux1Out), .ULAops(regCtrR1Out[2:0]),.ULAout(aluOut));
 //wire [31:0] aluOut;
Register D1(.regIn(aluOut),.clock(clock),.reset(reset),.regOut(regD1out));
 wire [31:0] regD1out;

Register B(.regIn(regsOutB),.clock(clock),.reset(reset),.regOut(regBOut));
 wire [31:0] regBOut;

Register ctrR2(.regIn(regCtrR1Out),.clock(clock),.reset(reset),.regOut(regCtrR2Out));
 wire [31:0] regCtrR2Out;

/* ----------------------------------------4 stage------------------------------------------- */

datamemory ram1(.ramIn(regBOut),.ramAdress(regD1out),.clock(clock),.ramWP(regCtrR2Out [3]),.ramOut(ramOut));
 wire [31:0] ramOut;

Register ctrR3(.regIn(regCtrR2Out),.clock(clock),.reset(reset),.regOut(regCtrR3Out));
 //wire [31:0] regCtrR3Out;

Register D2(.regIn(regD1out),.clock(clock),.reset(reset),.regOut(regD2out));
 wire [31:0] regD2out;

/* ----------------------------------------5 stage------------------------------------------- */

mux mux2(.muxInA(regD2out),.muxInB(ramOut),.select(regCtrR3Out [4]),.muxOut(mux2Out));
 //wire [15:0] mux2Out;
endmodule 
/* ---------------------------------------Respostas------------------------------------------ */
/*
A)	A latencia do sistema é de cinco periodos de clock.

B)	O Throughput do sistema é de uma instrução de 32bits/periodo de clock.

C)	Com a FPGA EP2C20F484C7 a frequencia maxima é de 79.47 MHz sem o multiplicador e de 3.208 MHz com o multiplicador.

D)	Cada instrução demora cinco periodos de clock para ser devidamente processada, então quando se faz  (A*B) – (C+D) 
em sequancia não funciona. Para que funcione corretamente é nessecario esperar a instrução ser devidamente completada,
o que foi feito com o uso da instrução NOP. A instrução NOP basicamente carrega em A e B o conteudo do registro zero,
que vale 32'd0, soma A com B e salva no próprio registro zero.

E)	A forma com que implementamos os dois clocks garante que não ocorra problemas de metaestabilidade ja que um clock 
é multiplo do outro (clock2 = 18*clock1). O multiplicador exige 16 pulsos de clock para realizar a operação, deixamos
o clock2 18 veses mais rapido que o clock1 para garantir que a multiplicação seja realizada corretamente.

F)	O multiplicador utilizado não é nem um pouco eficiente. Tinha-mos o sistema rodando a 79.47 MHz utilizando as 
celulas de multiplicação nativas da FPGA, com a implementação desse multiplicador nossa frequencia maxima de operação
caiu para 3.208 MHz, o que representa apenas 4.03% da frequencia inicial. 

G)	O algoritimo utilizado no multiplicador da ULA  se tornou um gargalo para a velocidade do sistema. Utilizar os 
multiplicadores embarcados presentes na FPGA ou utilizar outro algoritimo de multiplicação resolveria esse problema.
*/
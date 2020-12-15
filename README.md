# CPU-MIPS-RISC-FPGA
## Projeto em VERILOG de uma CPU de 32 bits com arquitetura RISC MIPS implmentada em uma FPGA

Características Principais:
- A Word da arquitetura é definida em 32 bits;
- Todo o sistema é implementado em pipeline;
- Todas as instruções são formadas por 4 bytes;
- Tanto a memória de programa quanto a memória de dados são de 1kWord;
- A cada Reset, o Program Counter sempre aponta para o endereço 0 da memória de programa;
- Para essa versão, o instruction set não contemplará instruções de Branch/Jump;
- Para essa versão, o módulo register file conterá apenas 16 registros ($s0 a $s7 e $t0 a $t7);
- Como não será implementado instruções de JMP ou Branch, ignore o bloco new pc;
- Como as memórias trabalharão com Words de 32 bits, o incremento do PC não é de 4 em 4 e sim, de 1 em 1.

![Arquitetura MIPS](https://i.pinimg.com/originals/f3/04/fc/f304fc67868fed2a047d31746e8c910a.jpg)

O Instruction Set compreende apenas as intruções marcadas. Os 6 primeiros bits de cada instrução, que definem seu tipo, serão definidas pelo número do grupo.

![Instruction Set](https://i.pinimg.com/originals/75/c4/3d/75c43df21147f791cb195041244c7a20.jpg)

Lembre-se: arquiteturas MIPS não fazem operações aritméticas/lógicas diretamente em memória. Os dados precisam primeiramente ser carregados nos registros

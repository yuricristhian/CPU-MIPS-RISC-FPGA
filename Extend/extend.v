module extend(
input [15:0] dataIn,
output [31:0] dataOut
);
assign dataOut = {16'd0, dataIn};
endmodule 
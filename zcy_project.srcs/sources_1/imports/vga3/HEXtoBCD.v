`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:33 12/23/2016 
// Design Name: 
// Module Name:    HEXtoBCD 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module HEXtoBCD(
	input [11:0] binary,
	output reg [3:0] digit_5,
	output reg [3:0] digit_4,
	output reg [3:0] digit_3,
	output reg [3:0] digit_2,
	output reg [3:0] digit_1
);

integer i;
always @(binary) begin
	digit_5 = 4'b0;
	digit_4 = 4'b0;
	digit_3 = 4'b0;
	digit_2 = 4'b0;
	digit_1 = 4'b0;

for(i = 11; i>= 0; i = i - 1)
	begin 
		if(digit_5 >= 5) digit_5 = digit_5 + 3;
		if(digit_4 >= 5) digit_4 = digit_4 + 3;
		if(digit_3 >= 5) digit_3 = digit_3 + 3;
		if(digit_2 >= 5) digit_2 = digit_2 + 3;
		if(digit_1 >= 5) digit_1 = digit_1 + 3;

digit_5 = digit_5 << 1;
digit_5[0] = digit_4[3]; 

digit_4 = digit_4 << 1;
digit_4[0] = digit_3[3];

digit_3 = digit_3 << 1;
digit_3[0] = digit_2[3];

digit_2 = digit_2 << 1;
digit_2[0] = digit_1[3];

digit_1 = digit_1 << 1;
digit_1[0] = binary[i];

end

end

endmodule

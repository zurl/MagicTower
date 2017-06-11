`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:33:06 12/15/2016 
// Design Name: 
// Module Name:    vga_display 
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
module vga_display(
			input wire clk,
			input wire vidon,
			input	wire [11:0] data,
			output reg [3:0] vgaRed,
			output reg [3:0] vgaGreen,
			output reg [3:0] vgaBlue
    );
 
	always @(posedge clk)
	begin
		if (vidon == 1)
		begin
			vgaRed <= data[11:8];
			vgaGreen <= data[7:4];
			vgaBlue <= data[3:0];
		end
		else
		begin
			vgaRed <= 0;
			vgaGreen <= 0;
			vgaBlue <= 0;
		end
	end

endmodule

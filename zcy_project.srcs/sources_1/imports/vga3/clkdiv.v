`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:58:02 12/15/2016 
// Design Name: 
// Module Name:    clkdiv 
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
module clkdiv(
			input clk100,
			output clk25
    );
     reg [1:0] count;
     
     
	 
	 always @(posedge clk100)
	 begin
			count <= count + 2'b1;
	 end

	assign clk25 = count[1];
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:54:42 12/22/2016 
// Design Name: 
// Module Name:    clk_50 
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
module clk_50(
    input  clk, 
    output clk_50M);
    
	reg cnt = 1'b0;   
	always @ (posedge clk) begin
		if(cnt == 1'b1)
			cnt <= 1'b0;
		else
			cnt <= 1'b1;
	end
    assign clk_50M = cnt;
endmodule

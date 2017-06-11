`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:59:49 12/16/2016
// Design Name:   test
// Module Name:   D:/New File Location System/Course/2AW/Digtal Logic Design/VGA2/VGA/VGA/rqwewqe.v
// Project Name:  VGA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rqwewqe;

	// Outputs
	wire [11:0] data;

	// Instantiate the Unit Under Test (UUT)
	test uut (
		.data(data)
	);

	initial begin
		// Initialize Inputs

		// Wait 100 ns for global reset to finish
		#100;
		
		// Add stimulus here

	end
      
endmodule


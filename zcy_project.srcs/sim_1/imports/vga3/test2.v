`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:59:38 12/16/2016
// Design Name:   Top
// Module Name:   D:/New File Location System/Course/2AW/Digtal Logic Design/VGA2/VGA/VGA/test2.v
// Project Name:  VGA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test2;

	// Inputs
	reg clk;
	reg [15:0] SW;

	// Outputs
	wire HSYNC;
	wire VSYNC;
	wire [3:0] Red;
	wire [3:0] Green;
	wire [3:0] Blue;
	wire Buzzer;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.SW(SW), 
		.HSYNC(HSYNC), 
		.VSYNC(VSYNC), 
		.Red(Red), 
		.Green(Green), 
		.Blue(Blue), 
		.Buzzer(Buzzer)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		SW = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule


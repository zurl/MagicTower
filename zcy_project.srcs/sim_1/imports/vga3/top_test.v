`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:12:53 12/22/2016
// Design Name:   Top
// Module Name:   D:/New File Location System/Course/2AW/Digtal Logic Design/the vga/top_test.v
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

module top_test;

	// Inputs
	reg clk;
	reg [15:0] SW;
    reg [15:0] t_in;
	// Outputs
	wire HSYNC;
	wire VSYNC;
	wire [3:0] Red;
	wire [3:0] Green;
	wire [3:0] Blue;
	wire Buzzer;
	wire [7:0] LED;
	wire [7:0] t_map[0:7];
	wire [7:0] t_mem_in, t_mem_out;
	   wire [12:0] t_mem_addr;
	    wire [12:0] t_mem_addr_map;
       wire t_status_on_floor_read;
	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.SW(SW), 
		.HSYNC(HSYNC), 
		.VSYNC(VSYNC), 
		.Red(Red), 
		.Green(Green), 
		.Blue(Blue), 
		.Buzzer(Buzzer), 
		.LED(LED),
		.t_in(t_in),
		.t_mem_in(t_mem_in),
		.t_status_on_floor_read(t_status_on_floor_read),
		.t_mem_addr(t_mem_addr),
		.t_mem_addr_map(t_mem_addr_map),
		.t_mem_out(t_mem_out),
		.t_map({t_map[7],t_map[6],t_map[5],t_map[4],t_map[3],t_map[2],t_map[1],t_map[0]})
	);
	reg[15:0] addr,ain;
    wire[15:0] aout;
	  blk_mem_gen_0 blk_mem_gen_0_ins(
             .clka(clk),
             .wea(0),
             .addra(addr),
             .dina(ain),
             .douta(aout)
             );
	
	
	
	integer i;

	initial begin
		// Initialize Inputs
		clk = 0;
		SW = 0;
		t_in = 0;
		addr = 0;
		ain = 0;
		// Wait 100 ns for global reset to finish
		#2000;
		
		#10 t_in[0] = 1;
		#10 t_in[0] = 0;
	       # 2000
	    #10 t_in[1] = 1;
		#10 t_in[1] = 0;
		for(i=1;i<=10;i=i+1)begin
			#20 SW[1] = 1;
			#20 SW[1] = 0;
		end
		
		for(i=1;i<=10;i=i+1)begin
			#20 SW[0] = 1;
			#20 SW[0] = 0;
		end
		for(i=1;i<=10;i=i+1)begin
			#20 SW[3] = 1;
			#20 SW[3] = 0;
		end
		for(i=1;i<=10;i=i+1)begin
			#20 SW[2] = 1;
			#20 SW[2] = 0;
		end
		// Add stimulus here
        
	end
	
	always @(posedge clk)begin
	   addr <= addr + 1;
	end
	
	initial forever begin
		#1 clk = 0;
		#1 clk = 1;
	end
      
endmodule


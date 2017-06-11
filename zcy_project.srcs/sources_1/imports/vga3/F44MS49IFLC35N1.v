`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Montvydas Klumbys	
// 
// Create Date:    
// Design Name: 
// Module Name:    Keyboard 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//	A module which is used to receive the DATA from PS2 type keyboard and translate that data into sensible codeword.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Keyboard(
	input clk,
   input ps2_clk,
   input ps2_data,
	output wire [3:0] AN,
	output wire [7:0] SEGMENT,
   output reg [7:0] code
   );

	reg reading;				//this is 1 if still waits to receive more bits 
	reg [11:0] timing;		//this is used to detect how much time passed since it received the previous codeword
	reg last_clk;			//used to check the previous state of the keyboard clock signal to know if it changed
	reg [10:0] data;			//this stores 11 received bits
	reg [3:0] cnt;				//tells how many bits were received until now (from 0 to 11)
	reg TRIGGER = 0;			//This acts as a 250 times slower than the board clock. 
	reg [7:0]DOWNCOUNTER = 0;		//This is used together with TRIGGER - look the code
	
//    up=2'h57;
//    down=2'h27;
//    left=2'hB6;
//    right=2'h47;
    
	//Set initial values
	initial begin
		last_clk = 1;	
		data = 0;
		cnt = 0;
		reading = 0;
		timing = 0;
        code = 0;
	end

	always @(posedge clk) begin				//This reduces the frequency 250 times
		if (DOWNCOUNTER < 249) begin			//and uses variable TRIGGER as the new board clock 
			DOWNCOUNTER <= DOWNCOUNTER + 1;
			TRIGGER <= 0;
		end
		else begin
			DOWNCOUNTER <= 0;
			TRIGGER <= 1;
		end
	end
	
	always @(posedge clk) begin	
		if (TRIGGER) begin
			if (reading)				//if it still waits to read full packet of 11 bits, then (read == 1)
				timing <= timing + 1;	//and it counts up this variable
			else 						//and later if check to see how big this value is.
				timing <= 0;			//if it is too big, then it resets the received data
		end
	end


	always @(posedge clk) begin		
		if (TRIGGER) begin						//If the down counter (CLK/250) is ready
			if (ps2_clk != last_clk) begin			//if the state of Clock pin changed from previous state
				if (!ps2_clk) begin				//and if the keyboard clock is at falling edge  
					reading <= 1;				//mark down that it is still reading for the next bit
					data[10:0] <= {ps2_data,data[10:1]};	//add up the data received by shifting bits and adding one new bit
					cnt <= cnt + 1;			//
				end
			end
			else if (cnt == 11) begin				//if it already received 11 bits
				cnt <= 0;
				reading <= 0;					//mark down that reading stopped
			end	
			else  begin						//if it yet not received full pack of 11 bits
				if (cnt < 11 && timing >= 4000) begin	//and if after a certain time no more bits were received, then
					cnt <= 0;				//reset the number of bits received
					reading <= 0;				//and wait for the next packet
				end
			end
		last_clk <= ps2_clk;					//mark down the previous state of the keyboard clock
		end
	end
	
    always @(negedge reading) code<=data[8:1];
   disp_num mm(clk,{8'b0,code[7:0]}, 4'b0, 4'b0, 1'b0, AN, SEGMENT);

endmodule




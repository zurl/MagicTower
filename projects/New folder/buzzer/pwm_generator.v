`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:18 12/22/2016 
// Design Name: 
// Module Name:    pwm_generator 
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
module pwm_generator(Clk50M, 
                 Rst_n,  
                  cnt_en,    
                 counter_arr,   
                  counter_ccr,    
                 o_pwm ); 
   input Clk50M;   //50MHz时钟输入  
   input Rst_n;    //复位输入，低电平复位  
   input cnt_en;   //计数使能信号 
	input [31:0]counter_arr;//输入32位预重装值  
   input [31:0]counter_ccr;//输入32位输出比较值  
   output reg o_pwm;   //pwm输出信号  
   reg [31:0]counter;//定义32位计数器 
   always@(posedge Clk50M or negedge Rst_n)    
		if(!Rst_n) 
			counter <= 32'd0;   
		else if(cnt_en)
		begin       
			if(counter == 0) 
            counter <= counter_arr;//计数到0，加载自动预重装寄存器值      
			else 
            counter <= counter - 1'b1;//计数器自减1   
		end   
		else 
				counter <= counter_arr; //没有使能时，计数器值等于预重装寄存器值  
	always@(posedge Clk50M or negedge Rst_n)  
		if(!Rst_n)  //让PWM输出信号复位时输出低电平     
			o_pwm <= 1'b1; 
		else if(counter >= counter_ccr)//计数值大于比较值    
			o_pwm <= 1'b1;  //输出为0   
		else    //计数值小于比较值    
			o_pwm <= 1'b0; //输出为1        
endmodule

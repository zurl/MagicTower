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
   input Clk50M;   //50MHzʱ������  
   input Rst_n;    //��λ���룬�͵�ƽ��λ  
   input cnt_en;   //����ʹ���ź� 
	input [31:0]counter_arr;//����32λԤ��װֵ  
   input [31:0]counter_ccr;//����32λ����Ƚ�ֵ  
   output reg o_pwm;   //pwm����ź�  
   reg [31:0]counter;//����32λ������ 
   always@(posedge Clk50M or negedge Rst_n)    
		if(!Rst_n) 
			counter <= 32'd0;   
		else if(cnt_en)
		begin       
			if(counter == 0) 
            counter <= counter_arr;//������0�������Զ�Ԥ��װ�Ĵ���ֵ      
			else 
            counter <= counter - 1'b1;//�������Լ�1   
		end   
		else 
				counter <= counter_arr; //û��ʹ��ʱ��������ֵ����Ԥ��װ�Ĵ���ֵ  
	always@(posedge Clk50M or negedge Rst_n)  
		if(!Rst_n)  //��PWM����źŸ�λʱ����͵�ƽ     
			o_pwm <= 1'b1; 
		else if(counter >= counter_ccr)//����ֵ���ڱȽ�ֵ    
			o_pwm <= 1'b1;  //���Ϊ0   
		else    //����ֵС�ڱȽ�ֵ    
			o_pwm <= 1'b0; //���Ϊ1        
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2016 02:08:21 PM
// Design Name: 
// Module Name: Buzzer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
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
module buzzer(clk, Rst_n, buzzer );  
	input clk;    
	input Rst_n;    
	output buzzer;      
	reg [31:0]counter_arr;  //预重装值寄存器 
	reg [31:0]counter_ccr; //输出比较值 
	reg [23:0]cnt;    //10Hz节拍计数器
	reg [7:0]Pitch_num; //音调编号 
	wire Clk50M;
	clk_50 m0(clk, Clk50M);
 
	localparam 
		L1 = 191130, //低音1 
		L2 = 170241, //低音2 
		L3 = 151698, //低音3 
		L4 = 143183, //低音4 
		L5 = 127550, //低音5 
		L6 = 113635, //低音6 
		L7 = 101234, //低音7 
		M1 = 95546, //中音1 
		M2 = 85134, //中音2 
		M3 = 75837, //中音3 
		M4 = 71581, //中音4 
		M5 = 63775, //中音5 
		M6 = 56817, //中音6 
		M7 = 50617, //中音7 
		H1 = 47823, //高音1 
		H2 = 42563, //高音2 
		H3 = 37921, //高音3 
		H4 = 35793, //高音4 
		H5 = 31887, //高音5 
		H6 = 28408, //高音6 
		H7 = 25309, //高音7 
		VO = 200000; //空拍
		
 
	//10Hz 节拍
	always @(posedge Clk50M,negedge Rst_n)
	begin
		if(!Rst_n)
			cnt <= 24'd0;
		else
		begin
			cnt <= cnt + 1'b1;
			if(cnt==24'd4999999)
				cnt <= 24'd0;
		end
	end



    //音符
	always@(posedge Clk50M or negedge Rst_n)   
		if(!Rst_n) 
			Pitch_num <= 8'd0; 
		else if(cnt == 0)
		begin 
			if(Pitch_num == 8'd97)          
				Pitch_num <= 8'd0;       
			else 
				Pitch_num <= Pitch_num + 1'd1;   
		end 
		else 
			Pitch_num <= Pitch_num;   

		//根据音调编号给预重装值给相应的值 
	always@(*) 
	case(Pitch_num) 
			
			0:counter_arr = VO;
			1:counter_arr = L6;
			2:counter_arr = VO;
			3:counter_arr = M1;
			4:counter_arr = VO;
			5:counter_arr = M3;
			6:counter_arr = VO;
			7:counter_arr = L6;
			8:counter_arr = VO;
			9:counter_arr = M1;
			10:counter_arr = VO;
			11:counter_arr = M3;
			12:counter_arr = VO;
			13:counter_arr = L6;
			14:counter_arr = VO;
			15:counter_arr = M1;
			16:counter_arr = VO;
			17:counter_arr = M3;
			18:counter_arr = VO;
			19:counter_arr = L6;
			20:counter_arr = VO;
			21:counter_arr = M1;
			22:counter_arr = VO;
			23:counter_arr = M3;
			24:counter_arr = VO;
			25:counter_arr = L5;
			26:counter_arr = VO;
			27:counter_arr = L7;
			28:counter_arr = VO;
			29:counter_arr = M2;
			30:counter_arr = VO;
			31:counter_arr = L5;
			32:counter_arr = VO;
			33:counter_arr = L7;
			34:counter_arr = VO;
			35:counter_arr = M2;
			36:counter_arr = VO;
			37:counter_arr = L5;
			38:counter_arr = VO;
			39:counter_arr = L7;
			40:counter_arr = VO;
			41:counter_arr = M2;
			42:counter_arr = VO;
			43:counter_arr = L5;
			44:counter_arr = VO;
			45:counter_arr = L7;
			46:counter_arr = VO;
			47:counter_arr = M2;
			48:counter_arr = VO;
			49:counter_arr = L4;
			50:counter_arr = VO;
			51:counter_arr = L6;
			52:counter_arr = VO;
			53:counter_arr = M1;
			54:counter_arr = VO;
			55:counter_arr = L4;
			56:counter_arr = VO;
			57:counter_arr = L6;
			58:counter_arr = VO;
			59:counter_arr = M1;
			60:counter_arr = VO;
			61:counter_arr = L4;
			62:counter_arr = VO;
			63:counter_arr = L6;
			64:counter_arr = VO;
			65:counter_arr = M1;
			66:counter_arr = VO;
			67:counter_arr = L4;
			68:counter_arr = VO;
			69:counter_arr = L6;
			70:counter_arr = VO;
			71:counter_arr = M1;
			72:counter_arr = VO;
			73:counter_arr = L5;
			74:counter_arr = VO;
			75:counter_arr = L7;
			76:counter_arr = VO;
			77:counter_arr = M2;
			78:counter_arr = VO;
			79:counter_arr = L5;
			80:counter_arr = VO;
			81:counter_arr = L7;
			82:counter_arr = VO;
			83:counter_arr = M2;
			84:counter_arr = VO;
			85:counter_arr = L5;
			86:counter_arr = VO;
			87:counter_arr = L7;
			88:counter_arr = VO;
			89:counter_arr = M2;
			90:counter_arr = VO;
			91:counter_arr = L5;
			92:counter_arr = VO;
			93:counter_arr = L7;
			94:counter_arr = VO;
			95:counter_arr = M2;
			96:counter_arr = VO;

			
			
//		（6↓ 1 3）x4 （5↓ 7↓ 2）x4 （4↓ 6↓ 1）x4 （5↓ 7↓ 2）x4 


			default:counter_arr  = L1;   
	endcase 
	
	always@(posedge Clk50M or negedge Rst_n)   
	begin
		if(!Rst_n) 
			counter_ccr <= 32'd0; 
		else if(counter_arr < 32'd199999)
			counter_ccr <= counter_arr >> 1;  
		else 
			counter_ccr <= 0;
	end


		//输出比较值为预重装值一半 
//	assign counter_ccr = counter_arr >> 1;  
	pwm_generator m1( .Clk50M(Clk50M), .Rst_n(Rst_n), .cnt_en(1'b1), 
        .counter_arr(counter_arr),  .counter_ccr(counter_ccr),  .o_pwm(buzzer));  
endmodule


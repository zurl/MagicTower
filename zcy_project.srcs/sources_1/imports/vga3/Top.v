`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:20:32 12/15/2016 
// Design Name: 
// Module Name:    Top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies.: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clkdiv2(input wire clk,
	input wire rst,
	output reg[31:0] clkdiv
    );
	//clock divider
	always @(posedge clk or posedge rst) begin
		if (rst) clkdiv <= 0;
		else clkdiv <=	clkdiv + 1'b1;
	end

endmodule



module Top(input wire clk,
	input wire [15:0] SW,
	output wire HSYNC,
	output wire VSYNC,
	output wire [3:0] Red,
	output wire [3:0] Green,
	output wire [3:0] Blue,
	output wire Buzzer,
	output wire [7:0] LED,
	output wire [3:0] AN,
	output wire [7:0] SEGMENT,
    input wire ps2_clk,
    input wire ps2_data
);
	buzzer bze(clk, SW[15], Buzzer );
	wire [31:0] clk_div; 
	wire [15:0] btn_tmp;
	reg [15:0] btn_reg, btn_out;
	assign LED = 0;
	clkdiv2 m22(clk,1'b0,clk_div);
	 

	reg [7:0] map [0:255];
	
	parameter DIR_UP = 16'd5;
	parameter DIR_DOWN = 16'd2;
	parameter DIR_LEFT = 16'd3;
	parameter DIR_RIGHT = 16'd4;
	
	
	reg status_on_money=0, status_on_exp=0, status_on_title = 1, status_on_key=0, status_on_floor_write=0, status_on_floor_read = 1;
	reg[3:0] status_x = 5 + 2, status_y =9 + 2, status_key[0:2];
	reg[15:0] status_floor = 0;
	reg[15:0] status_hp = 1000, status_exp = 50, status_money = 50, status_atk = 15, status_def = 15;
	
	
	reg[15:0] enemy_hp = 0;
	reg[5:0] enemy_code;
	
	
	reg [11:0] frame[0:'h80000];
	initial begin
		$readmemh("frame.mif", frame);
	end
	reg[15:0] frame_hp [0:63];
	reg[15:0] frame_atk[0:63];
	reg[15:0] frame_def[0:63];
	reg[15:0] frame_money[0:63];
	reg[15:0] frame_exp[0:63];
    reg[3:0] frame_upstair_x[0:30];
    reg[3:0] frame_downstair_x[0:30];
    reg[3:0] frame_upstair_y[0:30];
    reg[3:0] frame_downstair_y[0:30];
	
	integer kk;
    initial begin 
        status_key[0] = 1;
        status_key[1] = 1;
        status_key[2] = 1;
		for(kk=0;kk<=255;kk=kk+1)begin
			if ( kk % 16 == 0 || kk % 16 == 14 || kk / 16 == 0 || kk / 16 == 14)begin
				map[kk] = 26;
			end else begin
				map[kk] = 1;
			end
		end
		frame_downstair_y[0]=0;frame_downstair_x[0]=1;frame_upstair_y[0]=9;frame_upstair_x[0]=5;
		frame_downstair_y[1]=9;frame_downstair_x[1]=0;frame_upstair_y[1]=1;frame_upstair_x[1]=0;
		frame_downstair_y[2]=9;frame_downstair_x[2]=10;frame_upstair_y[2]=10;frame_upstair_x[2]=1;
		frame_downstair_y[3]=9;frame_downstair_x[3]=0;frame_upstair_y[3]=9;frame_upstair_x[3]=10;
		frame_downstair_y[4]=9;frame_downstair_x[4]=9;frame_upstair_y[4]=9;frame_upstair_x[4]=0;
		frame_downstair_y[5]=9;frame_downstair_x[5]=4;frame_upstair_y[5]=9;frame_upstair_x[5]=9;
		frame_downstair_y[6]=0;frame_downstair_x[6]=1;frame_upstair_y[6]=10;frame_upstair_x[6]=5;
		frame_downstair_y[7]=4;frame_downstair_x[7]=7;frame_upstair_y[7]=1;frame_upstair_x[7]=0;
		frame_downstair_y[8]=7;frame_downstair_x[8]=6;frame_upstair_y[8]=3;frame_upstair_x[8]=6;
		frame_downstair_y[9]=9;frame_downstair_x[9]=0;frame_upstair_y[9]=6;frame_upstair_x[9]=4;
		frame_downstair_y[10]=10;frame_downstair_x[10]=9;frame_upstair_y[10]=10;frame_upstair_x[10]=1;
		frame_downstair_y[11]=10;frame_downstair_x[11]=1;frame_upstair_y[11]=10;frame_upstair_x[11]=9;
		frame_downstair_y[12]=10;frame_downstair_x[12]=4;frame_upstair_y[12]=10;frame_upstair_x[12]=1;
		frame_downstair_y[13]=0;frame_downstair_x[13]=5;frame_upstair_y[13]=9;frame_upstair_x[13]=5;
		frame_downstair_y[14]=0;frame_downstair_x[14]=7;frame_upstair_y[14]=0;frame_upstair_x[14]=3;
		frame_downstair_y[15]=6;frame_downstair_x[15]=5;frame_upstair_y[15]=0;frame_upstair_x[15]=5;
		frame_downstair_y[16]=10;frame_downstair_x[16]=1;frame_upstair_y[16]=8;frame_upstair_x[16]=5;
		frame_downstair_y[17]=10;frame_downstair_x[17]=9;frame_upstair_y[17]=10;frame_upstair_x[17]=1;
		frame_downstair_y[18]=5;frame_downstair_x[18]=4;frame_upstair_y[18]=10;frame_upstair_x[18]=9;
		frame_downstair_y[19]=5;frame_downstair_x[19]=6;frame_upstair_y[19]=5;frame_upstair_x[19]=4;
		frame_downstair_y[20]=0;frame_downstair_x[20]=0;frame_upstair_y[20]=7;frame_upstair_x[20]=5;
		frame_hp[0]=50;frame_atk[0]=20;frame_def[0]=1;frame_exp[0]=1;frame_money[0]=1;
		frame_hp[1]=70;frame_atk[1]=15;frame_def[1]=2;frame_exp[1]=2;frame_money[1]=2;
		frame_hp[2]=100;frame_atk[2]=20;frame_def[2]=5;frame_exp[2]=3;frame_money[2]=3;
		frame_hp[3]=110;frame_atk[3]=25;frame_def[3]=5;frame_exp[3]=5;frame_money[3]=4;
		frame_hp[4]=200;frame_atk[4]=35;frame_def[4]=10;frame_exp[4]=5;frame_money[4]=5;
		frame_hp[5]=150;frame_atk[5]=40;frame_def[5]=20;frame_exp[5]=8;frame_money[5]=6;
		frame_hp[6]=125;frame_atk[6]=50;frame_def[6]=25;frame_exp[6]=10;frame_money[6]=7;
		frame_hp[7]=150;frame_atk[7]=65;frame_def[7]=30;frame_exp[7]=10;frame_money[7]=8;
		frame_hp[8]=300;frame_atk[8]=75;frame_def[8]=45;frame_exp[8]=13;frame_money[8]=10;
		frame_hp[9]=400;frame_atk[9]=90;frame_def[9]=50;frame_exp[9]=15;frame_money[9]=12;
		frame_hp[10]=500;frame_atk[10]=115;frame_def[10]=65;frame_exp[10]=15;frame_money[10]=15;
		frame_hp[11]=250;frame_atk[11]=120;frame_def[11]=70;frame_exp[11]=20;frame_money[11]=17;
		frame_hp[12]=450;frame_atk[12]=150;frame_def[12]=90;frame_exp[12]=22;frame_money[12]=19;
		frame_hp[13]=550;frame_atk[13]=160;frame_def[13]=90;frame_exp[13]=25;frame_money[13]=20;
		frame_hp[14]=100;frame_atk[14]=200;frame_def[14]=110;frame_exp[14]=30;frame_money[14]=25;
		frame_hp[15]=700;frame_atk[15]=250;frame_def[15]=125;frame_exp[15]=32;frame_money[15]=30;
		frame_hp[16]=1300;frame_atk[16]=300;frame_def[16]=150;frame_exp[16]=40;frame_money[16]=35;
		frame_hp[17]=850;frame_atk[17]=350;frame_def[17]=200;frame_exp[17]=45;frame_money[17]=40;
		frame_hp[18]=500;frame_atk[18]=400;frame_def[18]=260;frame_exp[18]=47;frame_money[18]=45;
		frame_hp[19]=900;frame_atk[19]=450;frame_def[19]=330;frame_exp[19]=50;frame_money[19]=50;
		frame_hp[20]=1250;frame_atk[20]=500;frame_def[20]=400;frame_exp[20]=55;frame_money[20]=55;
		frame_hp[21]=1500;frame_atk[21]=560;frame_def[21]=460;frame_exp[21]=60;frame_money[21]=60;
		frame_hp[22]=1200;frame_atk[22]=620;frame_def[22]=520;frame_exp[22]=65;frame_money[22]=75;
		frame_hp[23]=2000;frame_atk[23]=680;frame_def[23]=590;frame_exp[23]=70;frame_money[23]=65;
		frame_hp[24]=900;frame_atk[24]=750;frame_def[24]=650;frame_exp[24]=77;frame_money[24]=70;
		frame_hp[25]=1500;frame_atk[25]=830;frame_def[25]=730;frame_exp[25]=80;frame_money[25]=70;
		frame_hp[26]=2500;frame_atk[26]=900;frame_def[26]=850;frame_exp[26]=84;frame_money[26]=75;
		frame_hp[27]=1200;frame_atk[27]=980;frame_def[27]=900;frame_exp[27]=88;frame_money[27]=75;
		frame_hp[28]=3100;frame_atk[28]=1150;frame_def[28]=1050;frame_exp[28]=92;frame_money[28]=80;
		frame_hp[29]=15000;frame_atk[29]=1000;frame_def[29]=1000;frame_exp[29]=100;frame_money[29]=100;
		frame_hp[30]=20000;frame_atk[30]=1333;frame_def[30]=1333;frame_exp[30]=133;frame_money[30]=133;
		frame_hp[31]=30000;frame_atk[31]=1700;frame_def[31]=1500;frame_exp[31]=250;frame_money[31]=220;
		frame_hp[32]=45000;frame_atk[32]=2550;frame_def[32]=2250;frame_exp[32]=312;frame_money[32]=275;
		frame_hp[33]=3333;frame_atk[33]=1200;frame_def[33]=1133;frame_exp[33]=112;frame_money[33]=100;
		frame_hp[34]=1800;frame_atk[34]=1306;frame_def[34]=1200;frame_exp[34]=117;frame_money[34]=100;
		frame_hp[35]=2400;frame_atk[35]=980;frame_def[35]=900;frame_exp[35]=88;frame_money[35]=75;
		frame_hp[36]=2000;frame_atk[36]=1106;frame_def[36]=730;frame_exp[36]=106;frame_money[36]=93;
		frame_hp[37]=1500;frame_atk[37]=830;frame_def[37]=730;frame_exp[37]=132;frame_money[37]=116;
		frame_hp[38]=60000;frame_atk[38]=3400;frame_def[38]=3000;frame_exp[38]=390;frame_money[38]=343;
		frame_hp[39]=99999;frame_atk[39]=5000;frame_def[39]=4000;frame_exp[39]=0;frame_money[39]=0;
		frame_hp[40]=99999;frame_atk[40]=9999;frame_def[40]=5000;frame_exp[40]=0;frame_money[40]=0;
    end

	 reg[15:0] input_on=0;
    wire[3:0] cycle_new_y = 
        input_on[0] == 1 && status_y != 0      ? status_y - 4'b1 :
        input_on[1] == 1 && status_y != 4'd14 ? status_y + 4'b1 :
        status_y;
        
    wire[3:0] cycle_new_x = 
        input_on[2] == 1 && status_x != 0      ? status_x - 4'b1 :
        input_on[3] == 1 && status_x != 4'd14 ? status_x + 4'b1 :
        status_x;
        	
    wire[7:0] tmp_move_target = map[{cycle_new_x,cycle_new_y}];   
    wire[15:0] cycle_direction = 
        input_on[0] == 1 ? DIR_UP :
        input_on[1] == 1 ? DIR_DOWN :
        input_on[2] == 1 ? DIR_LEFT :
        input_on[3] == 1 ? DIR_RIGHT :
         16'b0;

	wire tmp_move_able = 
		tmp_move_target == 8'h00 ? 1'b1 :
		tmp_move_target == 8'd24 ? 1'b1 :
		tmp_move_target >= 8'd28 && tmp_move_target <= 8'd32 ? 1'b1 :
		tmp_move_target >= 8'd44 && tmp_move_target <= 8'd55 ? 1'b1 :
		tmp_move_target >= 8'h06 && tmp_move_target <= 8'h08 ? 1'b1 :
		tmp_move_target >= 8'h09 && tmp_move_target <= 8'h0b      
		&& status_key[ tmp_move_target - 8'h09 ] > 4'b0     ? 1'b1 :
		1'b0;
		
	
	wire[15:0] enemy_atk, enemy_inj;
	
	assign enemy_atk = frame_atk[enemy_code] > status_def ? frame_atk[enemy_code] - status_def : 16'b0;
	assign enemy_inj = status_atk - frame_def[enemy_code];

	wire tmp_upstair_able = tmp_move_target == 8'd22 ? 1'd1 :1'd0;
	wire tmp_downstair_able = tmp_move_target == 8'd23 ? 1'd1 : 1'd0;
		

	                      
	reg[31:0] time_buffer = 0;
	reg[3:0] saved_x, saved_y, saved_direction;
	

	
   
    
    /** Memory Module begin **/
    reg[1:0] enable;
    reg[7:0] mem_in;
    wire[7:0] mem_out; 
    reg[12:0] mem_addr = 120;
		 
    wire[12:0] mem_addr_map = (mem_addr / 11 + 2) * 16 + mem_addr % 11 + 2;
    wire[12:0] mem_addr_map_next = ((mem_addr-13'd1) / 11 + 2) * 16 + (mem_addr-13'd1) % 11 + 2;
    wire[12:0] mem_addr_real = status_floor * 121 + mem_addr;      
    

                
	blk_mem_gen_0 blk_mem_gen_0_ins(
	   .clka(clk),
	   .wea(status_on_floor_write),
	   .addra(mem_addr_real),
	   .dina(mem_in),
	   .douta(mem_out)
	   );
    reg[3:0] tmp_target_floor;
	 /** Memory Module end **/
	
	
    /** input Module begin **/
	reg[15:0] input_old=0;
	
	wire[7:0] ps2_code;
    Keyboard kbd(clk,ps2_clk,ps2_data,AN,SEGMENT,ps2_code);
    assign btn_tmp[0] = ps2_code==8'h75;
    assign btn_tmp[1] = ps2_code==8'h72;
    assign btn_tmp[2] = ps2_code==8'h6B;
    assign btn_tmp[3] = ps2_code==8'h74;
    assign btn_tmp[4] = ps2_code==8'h29;
    assign btn_tmp[5] = ps2_code==8'h16;
    assign btn_tmp[6] = ps2_code==8'h1e;
    assign btn_tmp[7] = ps2_code==8'h26;
    reg[19:0] input_saved=0;
    reg[14:0] input_dedo=0;
    reg[15:0] input_tmp_on=0, input_on_real_saved=0;
   
   
   //The main logic cycle
    always @( posedge clk ) begin
			//the input status machine
			//from the sequential signal to the posedge trigger singal
            input_dedo <= {input_dedo[13:0],btn_tmp == 0}; 
            if(input_dedo == 0 || input_dedo == 15'b111_1111_1111_1111)input_old <= btn_tmp;
            input_saved <= input_old;
            
            input_tmp_on <= ~input_old & input_saved;
            if( input_tmp_on != 0) begin
                input_on_real_saved <= input_tmp_on;
                if( input_on_real_saved != input_tmp_on)begin
                    input_on <= input_tmp_on;
                end else begin 
                    input_on_real_saved <= 0;
                end
            end
            if( input_on != 0 ) input_on <= 0;
             /** input Module end **/
			 
    		time_buffer <= time_buffer + 32'b1; //use for battle
    	    if (status_on_floor_write) begin
			  //memory logic to store the current map from register to memory
    		  if( enable<=1 )begin
    		      enable <= enable +  1;
    		  end else if(mem_addr == 0)begin
				//change write to read
    		      status_on_floor_write <= 0;
    		      status_on_floor_read <= 1;
    		      mem_addr <= 13'd120;
    		      status_floor <= tmp_target_floor;
    		      enable <= 0;
    		  end else begin
    		      mem_in <= map [ mem_addr_map_next];
    		      mem_addr <= mem_addr - 13'd1;
    		      enable <= 0;
    		  end
    		end else if( status_on_floor_read) begin
			//memory logic for read the next map from the memory to register
    		  if( enable<=1 )begin
                  enable <= enable +  1;
               end else if(mem_addr == 0)begin
				  map [ mem_addr_map ] <= mem_out;
                  status_on_floor_read <= 0;
                  map[ { status_x, status_y } ] <= 2;
                  enable<=0;
               end else begin
                  map [ mem_addr_map ] <= mem_out;
                  mem_addr <= mem_addr - 13'd1;
                  enable <= 0;
               end
			end else if( enemy_hp != 16'b0 ) begin
			//the battle logic
				if (time_buffer == 32'h9AF080)begin
				    if( status_hp <= enemy_atk)begin
				        enemy_hp <= 0;
				    end else begin
					   status_hp <= status_hp - enemy_atk;
					end
				end else if (time_buffer == 32'h135e100) begin
					if( enemy_hp <= enemy_inj) begin
					//the battle end logic
						enemy_hp <= 0;
						status_exp <= status_exp + frame_exp[enemy_code];
						status_money <= status_money + frame_exp[enemy_code];
						status_y <= saved_y;
						status_x <= saved_x;
						map[ {status_x, status_y } ] <= 0;
						map[ {saved_x, saved_y} ] <= saved_direction;
					end else begin
						enemy_hp <= enemy_hp - enemy_inj;
					end
					time_buffer<=0;
				end
				//the money shop
			end else if(input_on != 16'b0 && status_on_money == 1'b1 ) begin
				if( input_on[4] == 1)begin
					status_on_money <= 1'b0;
				end else if( status_money >= 16'd25 )begin
					if( input_on[5] == 1)begin
						status_money <= status_money - 16'd25;
						status_hp <= status_hp + 16'd800;
						status_on_money <= 1'b0;
					end else if( input_on[6] == 1)begin
						status_money <= status_money - 16'd25;
						status_atk <= status_atk + 16'd4;
						status_on_money <= 1'b0;
					end else if( input_on[7] == 1)begin
						status_money <= status_money - 16'd25;
						status_def <= status_def + 16'd4;
						status_on_money <= 1'b0;
					end 
				end
				//the key shop
			end else if(input_on != 16'b0 && status_on_key == 1'b1 ) begin
                if( input_on[4] == 1)begin
                    status_on_key <= 1'b0;
                end else if( status_money >= 16'd25  && input_on[5] == 1)begin
                        status_money <= status_money - 16'd25;
                        status_key[0] <= status_key[0] + 16'd1;
                        status_on_key <= 1'b0;
                end else if( status_money >= 16'd50  && input_on[6] == 1)begin
                        status_money <= status_money - 16'd50;
                        status_key[1] <= status_key[1] + 16'd1;
                        status_on_key <= 1'b0;
                end else if( status_money >= 16'd100  && input_on[7] == 1)begin
                        status_money <= status_money - 16'd100;
                        status_key[2] <= status_key[2] + 16'd1;
                        status_on_key <= 1'b0;
                end
				//the exp shop
			end else if(input_on != 16'b0 && status_on_exp == 1'b1 ) begin
				if( input_on[4] == 1 ) begin
					status_on_exp <= 1'b0;
				end else if( status_on_exp >= 16'd30 )begin
					if( input_on[5] == 1)begin
						status_exp <= status_exp - 16'd30;
						status_hp <= status_hp + 16'd600;
						status_on_exp <= 1'b0;
					end else if( input_on[6] == 1)begin
						status_exp <= status_exp - 16'd30;
						status_atk <= status_atk + 16'd7;
						status_on_exp <= 1'b0;
					end else if( input_on[7] == 1)begin
						status_exp <= status_exp - 16'd30;
						status_def <= status_def + 16'd7;
						status_on_exp <= 1'b0;
					end 
				end
				//the upstair
			end else if(input_on != 16'b0 && tmp_upstair_able ) begin
				tmp_target_floor <= status_floor + 16'd1;
				map[ { status_x, status_y } ] <= 0;
				status_x <= frame_upstair_x[ status_floor + 16'd1 ] + 4'd2;
				status_y <= frame_upstair_y[ status_floor + 16'd1] + 4'd2;
				status_on_floor_write <= 1;
				enable <= 0;
				mem_addr <= 13'd120;
				mem_in <= map[  204 ];
				// the downstair
			end else if(input_on != 16'b0 && tmp_downstair_able ) begin
				tmp_target_floor <= status_floor - 16'd1;
				map[ { status_x, status_y } ] <= 0;
				status_x <= frame_downstair_x[ status_floor - 16'd1 ] + 4'd2;
				status_y <= frame_downstair_y[ status_floor - 16'd1 ] + 4'd2;
				status_on_floor_write <= 1;
				enable <= 0;
                mem_addr <= 13'd120;
                mem_in <= map[204];
				//the shop entry event
            end else if( input_on != 16'b0 && tmp_move_target == 8'd62) begin
				status_on_money <= 1'b1;
			end else if( input_on != 16'b0 && tmp_move_target == 8'd63) begin
                status_on_exp <= 1'b1;
            end else if( input_on != 16'b0 && tmp_move_target == 8'd58) begin
                status_on_key <= 1'b1;
				//battle entry logic
			end else if( input_on != 16'b0 && tmp_move_target >= 8'd64 
			&& frame_def[tmp_move_target - 64] < status_atk ) begin
				enemy_code <= tmp_move_target - 8'd64;
				enemy_hp <= frame_hp[tmp_move_target - 8'd64];
				saved_x <= cycle_new_x;
				saved_y <= cycle_new_y;
				saved_direction <= cycle_direction;
				time_buffer<=0;
				//move logic
			end else if( input_on != 16'b0 && tmp_move_able ) begin
				//CHEAT LOGIC
			    if( SW[12] )  status_hp <= status_hp + 500;
			    if( SW[11] )  status_atk <= status_atk + 50;
				//CHEAT LOGIC end
				time_buffer <= time_buffer + 32'b1;
				status_y <= cycle_new_y;
				status_x <= cycle_new_x;
				map[ { status_x, status_y } ] <= 0;
				map[ { cycle_new_x, cycle_new_y} ] <= cycle_direction;
				
				
				//cope with the special move event
				//like item or attribute change
				if( tmp_move_target >= 8'h06 && tmp_move_target <= 8'h08) begin
					status_key [ tmp_move_target - 8'h06 ] <= status_key [ tmp_move_target - 8'h06 ] + 4'h1; 
				end else if( tmp_move_target >= 8'h09 && tmp_move_target <= 8'h0b) begin
					status_key [ tmp_move_target - 8'h09 ] <= status_key [ tmp_move_target - 8'h09 ] - 4'h1; 
				end else if( tmp_move_target == 8'd28 ) begin
					status_atk <= status_atk + 16'h3;
				end else if( tmp_move_target == 8'd29 ) begin
					status_def <= status_def + 16'h3;
				end else if( tmp_move_target == 8'd30 ) begin
					status_hp <= status_hp + 16'd200;
				end else if( tmp_move_target == 8'd31 ) begin
					status_hp <= status_hp + 16'd500;
				end else if( tmp_move_target == 8'd44 ) begin
                   status_key [0] <= status_key [ 0 ] + 4'h1; 
                   status_key [1] <= status_key [ 1 ] + 4'h1; 
                   status_key [2] <= status_key [ 2 ] + 4'h1; 
                end else if( tmp_move_target == 8'd48 ) begin
                   status_def <= status_def + 16'd160;
                end else if( tmp_move_target == 8'd49 ) begin
                   status_def <= status_def + 16'd60;
                end else if( tmp_move_target == 8'd50 ) begin
                   status_def <= status_def + 16'd10;
                end else if( tmp_move_target == 8'd51 ) begin
                   status_atk <= status_atk + 16'd160;
                end else if( tmp_move_target == 8'd52 ) begin
                   status_atk <= status_atk + 16'd60;
                end else if( tmp_move_target == 8'd53 ) begin
                   status_atk <= status_atk + 16'd10;
                end else if( tmp_move_target == 8'd54 ) begin
                   status_money <= status_money + 16'd300;
                end else if( tmp_move_target == 8'd55 ) begin
                   status_atk <= status_atk + status_atk;
                   status_def <= status_def + status_def;
                end
                      
                
			end
	end
	
	
	/****** Display Module Begin ****/
	
	
	


	
	reg [8:0] docker [0:149] ; //5 * 15 7:0 + left/right
	

	
	integer j;

	//Module
	//Mapping the map to the screen
		/** display scan  Module **/
    wire clk25,vidon;
    clkdiv U0(.clk100(clk), .clk25(clk25));
    
	// the combination logic circuit about
	// the display position decision module
    wire [9:0] hc, vc;
    reg [11:0] data;
	wire[9:0] display_x = hc - 144; // from 0 to 639 [ 20 * 32 ]
	wire[9:0] display_y = vc - 31;  // from 0 to 478 [ 15 * 32 ]
	wire[7:0] display_block = map[ {display_x[8:5], display_y[8:5]} ];	//the number order of the block scaned now
    wire[9:0] display_x_docker = display_x - 10'd480;	//the right part of infomation display module
	wire[8:0] display_docker_block = docker [  display_x_docker[7:4]*15 + display_y[8:5] ];	

	
	//Display sync module
	//Foreach clk period (100MHZ), update the data register 
	//which is used for vga_sync module to update the scanning
	//infomation into the screen
   reg [31:0] animation_buffer = 0;
        wire [1:0] animation_status = 
           animation_buffer <= 32'd25000000 ? 2'd0 :
           animation_buffer <= 32'd50000000 ? 2'd1 :
           animation_buffer <= 32'd75000000 ? 2'd2 :
           2'd3;
        
        always @( posedge clk ) begin
            animation_buffer <= animation_buffer + 1;
            if(animation_buffer == 32'd100000000) animation_buffer <= 32'd0;
            if ( vidon == 0 ) begin
                data <= 12'b0;
            end else begin
                if(display_x[9:5] >= 5'hF )begin
                  data <= frame[ { display_docker_block[8:1],animation_status,display_y[4:0],display_docker_block[0],display_x[3:0]}];
                end else begin
                  data <= frame[ {display_block,animation_status,display_y[4:0],display_x[4:0]} ];
                end    
		  end	
	end  
	

	/** decoder  Module **/
	
	//from hex to BCD decoder module
	wire[3:0] display_atk[0:4];
	wire[3:0] display_def[0:4];
	wire[3:0] display_money[0:4];
	wire[3:0] display_exp[0:4];
	wire[3:0] display_floor[0:4];
	wire[3:0] display_hp[0:4];
	wire[3:0] display_enemy_hp[0:4];
	wire[3:0] display_enemy_atk[0:4];
	wire[3:0] display_enemy_def[0:4];
	wire[3:0] display_key_1[0:4];
	wire[3:0] display_key_2[0:4];
	wire[3:0] display_key_3[0:4];
	
	HEXtoBCD display_enemy_atk_bcd(
		frame_atk[enemy_code],
		display_enemy_atk[4],
		display_enemy_atk[3],
		display_enemy_atk[2],
		display_enemy_atk[1],
		display_enemy_atk[0]
	);
	HEXtoBCD display_defe_bcd(
		frame_def[enemy_code],
		display_enemy_def[4],
		display_enemy_def[3],
        display_enemy_def[2],
        display_enemy_def[1],
        display_enemy_def[0]
    );
	HEXtoBCD display_hp_bcd(
		status_hp,
		display_hp[4],
		display_hp[3],
		display_hp[2],
		display_hp[1],
		display_hp[0]
	);
	
	HEXtoBCD display_enemy_hp_bcd(
		enemy_hp,
		display_enemy_hp[4],
		display_enemy_hp[3],
		display_enemy_hp[2],
		display_enemy_hp[1],
		display_enemy_hp[0]
	);
	
	HEXtoBCD display_key_1_bcd(
		status_key[0],
		display_key_1[4],
		display_key_1[3],
		display_key_1[2],
		display_key_1[1],
		display_key_1[0]
	);
	
	HEXtoBCD display_key_2_bcd(
		status_key[1],
		display_key_2[4],
		display_key_2[3],
		display_key_2[2],
		display_key_2[1],
		display_key_2[0]
	);
	
	HEXtoBCD display_key_3_bcd(
		status_key[2],
		display_key_3[4],
		display_key_3[3],
		display_key_3[2],
		display_key_3[1],
		display_key_3[0]
	);
	HEXtoBCD display_floor_bcd(
		status_floor[11:0] + 1,
		display_floor[4],
		display_floor[3],
		display_floor[2],
		display_floor[1],
		display_floor[0]
	);

	HEXtoBCD display_atk_bcd(
		status_atk,
		display_atk[4],
		display_atk[3],
		display_atk[2],
		display_atk[1],
		display_atk[0]
	);

	HEXtoBCD display_def_bcd(
		status_def,
		display_def[4],
		display_def[3],
		display_def[2],
		display_def[1],
		display_def[0]
	);

	HEXtoBCD display_money_bcd(
		status_money,
		display_money[4],
		display_money[3],
		display_money[2],
		display_money[1],
		display_money[0]
	);

	HEXtoBCD display_exp_bcd(
		status_exp,
		display_exp[4],
		display_exp[3],
		display_exp[2],
		display_exp[1],
		display_exp[0]
	);

	initial begin
		docker[0] = 8'd2 + 8'd2 + 8'b0;
		docker[15] = 8'd2 + 8'd2 + 8'b1; // people

		docker[1] = 8'd18 + 8'd18 + 8'b0;
		docker[16] = 8'd18 + 8'd18 + 8'b1; //HP

		docker[2] = 8'd20 + 8'd20 + 8'b0;
		docker[17] = 8'd20 + 8'd20 + 8'b1;  //ATK

		docker[3] = 8'd21 + 8'd21 + 8'b0;
		docker[18] = 8'd21 + 8'd21 + 8'b1; 	//DEF

		docker[4] = 8'd17 + 8'd17 + 8'b0;
		docker[19] = 8'd17 + 8'd17 + 8'b1; //$
		
		docker[5] = 8'd19 + 8'd19 + 8'b0;
		docker[20] = 8'd19 + 8'd19 + 8'b1;	//EXP

		docker[6] = 8'd6 + 8'd6 + 8'b0;
		docker[21] = 8'd6 + 8'd6 + 8'b1;//YELLOW


		docker[36] = 8'd7 + 8'd7 + 8'b0; //blue
		docker[51] = 8'd7 + 8'd7 + 8'b1;		

		docker[66] = 8'd8 + 8'd8 + 8'b0; //red
		docker[81] = 8'd8 + 8'd8 + 8'b1;		

		docker[10] = 8'd18 + 8'd18 + 8'b0;
		docker[25] = 8'd18 + 8'd18 + 8'b1; //HP'

		docker[11] = 8'd20 + 8'd20 + 8'b0;
		docker[26] = 8'd20 + 8'd20 + 8'b1; //ATK'

		docker[12] = 8'd21 + 8'd21 + 8'b0;
		docker[27] = 8'd21 + 8'd21 + 8'b1;	//DEF'	
	end
	
	
	//sync the status infomation to the screen
	always @(posedge clk) begin 
	
	    docker[30] <= 8'd22 + 8'd22 + 8'b0;
	    docker[45] <= 8'd22 + 8'd22 + 8'b1;
        docker[60] <= {display_floor[1][3:1] + 8'd12, display_floor[1][0]};
        docker[75] <= {display_floor[0][3:1] + 8'd12, display_floor[0][0]};

		for(j = 0; j <= 4; j = j + 1)begin
			docker[92 - 15*j] <= {display_atk[j][3:1] + 8'd12, display_atk[j][0]};
		end
		for(j = 0; j <= 4; j = j + 1)begin
			docker[93 - 15*j] <= {display_def[j][3:1] + 8'd12, display_def[j][0]};
		end
		for(j = 0; j <= 4; j = j + 1)begin
			docker[94 - 15*j] <= {display_money[j][3:1] + 8'd12, display_money[j][0]};
		end
		for(j = 0; j <= 4; j = j + 1)begin
			docker[95 - 15*j] <= {display_exp[j][3:1] + 8'd12, display_exp[j][0]};
		end
		
		for(j = 0; j <= 1; j = j + 1)begin
			docker[22 - 15*j] <= {display_key_1[j][3:1] + 8'd12, display_key_1[j][0]};
		end
		for(j = 0; j <= 1; j = j + 1)begin
			docker[52 - 15*j] <= {display_key_2[j][3:1] + 8'd12, display_key_2[j][0]};
		end
		for(j = 0; j <= 1; j = j + 1)begin
			docker[82 - 15*j] <= {display_key_3[j][3:1] + 8'd12, display_key_3[j][0]};
		end

		for(j = 0; j <= 4; j = j + 1)begin
			docker[91 - 15*j] <= {display_hp[j][3:1] + 8'd12, display_hp[j][0]};
		end

		for(j = 0; j <= 4; j = j + 1)begin
			docker[91 - 15*j] <= {display_hp[j][3:1] + 8'd12, display_hp[j][0]};
		end

		for(j = 0; j <= 4; j = j + 1)begin
			docker[91 - 15*j] <= {display_hp[j][3:1] + 8'd12, display_hp[j][0]};
		end
		if(status_on_money) begin 
		
		    docker[10] <= 8'd18 + 8'd18 + 8'b0;
            docker[25] <= 8'd18 + 8'd18 + 8'b1; //HP'
    
            docker[11] <= 8'd20 + 8'd20 + 8'b0;
            docker[26] <= 8'd20 + 8'd20 + 8'b1; //ATK'
    
            docker[12] <= 8'd21 + 8'd21 + 8'b0;
            docker[27] <= 8'd21 + 8'd21 + 8'b1;    //DEF'
            
			docker[9] <= 8'd17 + 8'd17 + 8'b0;
			docker[24] <= 8'd17 + 8'd17 + 8'b1; 		//$

			docker[39] <= 8'd13 + 8'd13 + 8'b0;
			docker[54] <= 8'd14 + 8'd14 + 8'b1;  //25
			
			
			docker[40] <= 8'd14 + 8'd14 + 8'b1;
			docker[55] <= 8'd12 + 8'd12 + 8'b0; 
			docker[70] <= 8'd12 + 8'd12 + 8'b0;  //500
			docker[85] <= 8'b0;
			docker[100] <= 8'b0;
			
			docker[41] <= 8'd12 + 8'd12 + 8'b0;
			docker[56] <= 8'd12 + 8'd12 + 8'b0; 
			docker[71] <= 8'd14 + 8'd14 + 8'b0;  //4
			docker[86] <= 8'b0;
            docker[101] <= 8'b0;
			
			docker[42] <= 8'd12 + 8'd12 + 8'b0;
			docker[57] <= 8'd12 + 8'd12 + 8'b0; 
			docker[72] <= 8'd14 + 8'd14 + 8'b0;  //4
			docker[87] <= 8'b0;
            docker[102] <= 8'b0;
			
			
		end else if(status_on_exp) begin 
		    docker[10] <= 8'd18 + 8'd18 + 8'b0;
            docker[25] <= 8'd18 + 8'd18 + 8'b1; //HP'
    
            docker[11] <= 8'd20 + 8'd20 + 8'b0;
            docker[26] <= 8'd20 + 8'd20 + 8'b1; //ATK'
    
            docker[12] <= 8'd21 + 8'd21 + 8'b0;
            docker[27] <= 8'd21 + 8'd21 + 8'b1;    //DEF'
            
			docker[9] <= 8'd19 + 8'd19 + 8'b0;
			docker[24] <= 8'd19 + 8'd19 + 8'b1; 	// exp
		
			docker[39] <= 8'd13 + 8'd13 + 8'b1;
			docker[54] <= 8'd12 + 8'd12 + 8'b0;  //30
			
			docker[40] <= 8'd12 + 8'd12 + 8'b1;
			docker[55] <= 8'd12 + 8'd12 + 8'b0; 
			docker[70] <= 8'd12 + 8'd12 + 8'b0;  //1000
			docker[85] <= 8'd12 + 8'd12 + 8'b0;
			
			docker[41] <= 8'd12 + 8'd12 + 8'b0;
			docker[56] <= 8'd12 + 8'd12 + 8'b0; 
			docker[71] <= 8'd15 + 8'd15 + 8'b1;  //4
			
			docker[42] <= 8'd12 + 8'd12 + 8'b0;
			docker[57] <= 8'd12 + 8'd12 + 8'b0; 
			docker[72] <= 8'd15 + 8'd15 + 8'b1;  //4
		end else if(status_on_key) begin 
            docker[10] <= 8'd6 + 8'd6 + 8'b0;
            docker[25] <= 8'd6 + 8'd6 + 8'b1; 
            docker[40] <= 8'd17 + 8'd17 + 8'b0;
            docker[55] <= 8'd17 + 8'd17 + 8'b1; 
            docker[70] <= 8'd13 + 8'd13 + 8'b0;
            docker[85] <= 8'd14 + 8'd14 + 8'b1; 
      
            
            docker[11] <= 8'd7 + 8'd7 + 8'b0;
            docker[26] <= 8'd7 + 8'd7 + 8'b1; 
            docker[41] <= 8'd17 + 8'd17 + 8'b0;
            docker[56] <= 8'd17 + 8'd17 + 8'b1; 
            docker[71] <= 8'd14 + 8'd14 + 8'b1;
            docker[86] <= 8'd12 + 8'd12 + 8'b0; 
                        
            docker[12] <= 8'd8 + 8'd8 + 8'b0;
            docker[27] <= 8'd8 + 8'd8 + 8'b1; 
            docker[42] <= 8'd17 + 8'd17 + 8'b0;
            docker[57] <= 8'd17 + 8'd17 + 8'b1; 
            docker[72] <= 8'd12 + 8'd12 + 8'b1; 
            docker[87] <= 8'd12 + 8'd12 + 8'b0; 
            docker[102] <= 8'd12 + 8'd12 + 8'b0; 
        end else if(enemy_hp > 0) begin 
            docker[10] <= 8'd18 + 8'd18 + 8'b0;
            docker[25] <= 8'd18 + 8'd18 + 8'b1; //HP'
    
            docker[11] <= 8'd20 + 8'd20 + 8'b0;
            docker[26] <= 8'd20 + 8'd20 + 8'b1; //ATK'
    
            docker[12] <= 8'd21 + 8'd21 + 8'b0;
            docker[27] <= 8'd21 + 8'd21 + 8'b1;    //DEF'
			docker[9] <= {enemy_code[5:0] +64, 1'b0};
			docker[24] <={enemy_code[5:0]+64, 1'b1}; 	// the enemy

			for(j = 0; j <= 4; j = j + 1)begin
				docker[100 - 15*j] <= {display_enemy_hp[j][3:1] + 8'd12, display_enemy_hp[j][0]};
			end

			for(j = 0; j <= 4; j = j + 1)begin
				docker[101 - 15*j] <= {display_enemy_atk[j][3:1] + 8'd12, display_enemy_atk[j][0]};
			end
			
			for(j = 0; j <= 4; j = j + 1)begin
				docker[102 - 15*j] <= {display_enemy_def[j][3:1] + 8'd12, display_enemy_def[j][0]};
			end
		end  else begin
		    for(j = 0; j <= 6; j = j + 1)begin
                docker[99 - 15*j] <= 8'b0;
            end
            for(j = 0; j <= 6; j = j + 1)begin
                docker[100 - 15*j] <= 8'b0;
            end
            
            for(j = 0; j <= 6; j = j + 1)begin
                docker[101 - 15*j] <= 8'b0;
            end
            
            for(j = 0; j <= 6; j = j + 1)begin
                docker[102 - 15*j] <= 8'b0;
            end
		end 
		
	end
	//vga display module
	vga_sync vga_sync_ins(
			clk25,
			HSYNC,
			VSYNC,
			hc,
			vc,
			vidon
	);
	vga_display vga_display_ins(
			clk25,
			vidon,
			data,
			Red,
			Green,
			Blue
	);
endmodule

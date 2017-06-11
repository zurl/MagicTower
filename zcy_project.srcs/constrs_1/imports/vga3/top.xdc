set_property PACKAGE_PIN AC18 [get_ports clk]
set_property IOSTANDARD LVCMOS18 [get_ports clk]
create_clock -name clk_100mhz -period 10.000 [get_ports clk]
set_property PACKAGE_PIN AA10 [get_ports {SW[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[0]}]
set_property PACKAGE_PIN AB10 [get_ports {SW[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[1]}]
set_property PACKAGE_PIN AA13 [get_ports {SW[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[2]}]
set_property PACKAGE_PIN AA12 [get_ports {SW[3]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[3]}]
set_property PACKAGE_PIN Y13 [get_ports {SW[4]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[4]}]
set_property PACKAGE_PIN Y12 [get_ports {SW[5]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[5]}]
set_property PACKAGE_PIN AD11 [get_ports {SW[6]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[6]}]
set_property PACKAGE_PIN AD10 [get_ports {SW[7]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[7]}]
set_property PACKAGE_PIN AE10 [get_ports {SW[8]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[8]}]
set_property PACKAGE_PIN AE12 [get_ports {SW[9]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[9]}]
set_property PACKAGE_PIN AF12 [get_ports {SW[10]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[10]}]
set_property PACKAGE_PIN AE8 [get_ports {SW[11]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[11]}]
set_property PACKAGE_PIN AF8 [get_ports {SW[12]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[12]}]
set_property PACKAGE_PIN AE13 [get_ports {SW[13]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[13]}]
set_property PACKAGE_PIN AF13 [get_ports {SW[14]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[14]}]
set_property PACKAGE_PIN AF10 [get_ports {SW[15]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[15]}]

set_property PACKAGE_PIN T20 [get_ports { Blue[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports { Blue[0]}]
set_property SLEW FAST [get_ports { Blue[0]}]
set_property PACKAGE_PIN R20 [get_ports { Blue[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports { Blue[1]}]
set_property SLEW FAST [get_ports { Blue[1]}]
set_property PACKAGE_PIN T22 [get_ports { Blue[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports { Blue[2]}]
set_property SLEW FAST [get_ports { Blue[2]}]
set_property PACKAGE_PIN T23 [get_ports { Blue[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports { Blue[3]}]
set_property SLEW FAST [get_ports { Blue[3]}]
set_property PACKAGE_PIN R22 [get_ports {Green[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Green[0]}]
set_property SLEW FAST [get_ports {Green[0]}]
set_property PACKAGE_PIN R23 [get_ports {Green[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Green[1]}]
set_property SLEW FAST [get_ports {Green[1]}]
set_property PACKAGE_PIN T24 [get_ports {Green[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Green[2]}]
set_property SLEW FAST [get_ports {Green[2]}]
set_property PACKAGE_PIN T25 [get_ports {Green[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Green[3]}]
set_property SLEW FAST [get_ports {Green[3]}]
set_property PACKAGE_PIN N21 [get_ports {Red[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Red[0]}]
set_property SLEW FAST [get_ports {Red[0]}]
set_property PACKAGE_PIN N22 [get_ports {Red[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Red[1]}]
set_property SLEW FAST [get_ports {Red[1]}]
set_property PACKAGE_PIN R21 [get_ports {Red[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Red[2]}]
set_property SLEW FAST [get_ports {Red[2]}]
set_property PACKAGE_PIN P21 [get_ports {Red[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Red[3]}]
set_property SLEW FAST [get_ports {Red[3]}]
set_property PACKAGE_PIN M22 [get_ports HSYNC]
set_property IOSTANDARD LVCMOS33 [get_ports HSYNC]
set_property SLEW FAST [get_ports HSYNC]
set_property PACKAGE_PIN M21 [get_ports VSYNC]
set_property IOSTANDARD LVCMOS33 [get_ports VSYNC]
set_property SLEW FAST [get_ports VSYNC]

set_property PACKAGE_PIN N18 [get_ports ps2_clk]
set_property IOSTANDARD LVCMOS33 [get_ports ps2_clk]
set_property PULLUP true [get_ports ps2_clk]
set_property PACKAGE_PIN M19 [get_ports ps2_data]
set_property IOSTANDARD LVCMOS33 [get_ports ps2_data]
set_property PULLUP true [get_ports ps2_data]
set_property PACKAGE_PIN AF24 [get_ports Buzzer]
set_property IOSTANDARD LVCMOS33 [get_ports Buzzer]

#a
set_property PACKAGE_PIN AB22 [get_ports {SEGMENT[0]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:11
# The conversion of 'IOSTANDARD' constraint on 'net' object 'SEGMENT[0]' has been applied to the port object 'SEGMENT[0]'.
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[0]}]
#b
set_property PACKAGE_PIN AD24 [get_ports {SEGMENT[1]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:12
# The conversion of 'IOSTANDARD' constraint on 'net' object 'SEGMENT[1]' has been applied to the port object 'SEGMENT[1]'.
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[1]}]
set_property PACKAGE_PIN AD23 [get_ports {SEGMENT[2]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:13
# The conversion of 'IOSTANDARD' constraint on 'net' object 'SEGMENT[2]' has been applied to the port object 'SEGMENT[2]'.
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[2]}]
set_property PACKAGE_PIN Y21 [get_ports {SEGMENT[3]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:14
# The conversion of 'IOSTANDARD' constraint on 'net' object 'SEGMENT[3]' has been applied to the port object 'SEGMENT[3]'.
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[3]}]
set_property PACKAGE_PIN W20 [get_ports {SEGMENT[4]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:15
# The conversion of 'IOSTANDARD' constraint on 'net' object 'SEGMENT[4]' has been applied to the port object 'SEGMENT[4]'.
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[4]}]
set_property PACKAGE_PIN AC24 [get_ports {SEGMENT[5]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:16
# The conversion of 'IOSTANDARD' constraint on 'net' object 'SEGMENT[5]' has been applied to the port object 'SEGMENT[5]'.
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[5]}]
#g
set_property PACKAGE_PIN AC23 [get_ports {SEGMENT[6]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:17
# The conversion of 'IOSTANDARD' constraint on 'net' object 'SEGMENT[6]' has been applied to the port object 'SEGMENT[6]'.
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[6]}]
#point
set_property PACKAGE_PIN AA22 [get_ports {SEGMENT[7]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:18
# The conversion of 'IOSTANDARD' constraint on 'net' object 'SEGMENT[7]' has been applied to the port object 'SEGMENT[7]'.
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[7]}]

set_property PACKAGE_PIN AD21 [get_ports {AN[0]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:20
# The conversion of 'IOSTANDARD' constraint on 'net' object 'AN[0]' has been applied to the port object 'AN[0]'.
set_property IOSTANDARD LVCMOS33 [get_ports {AN[0]}]
set_property PACKAGE_PIN AC21 [get_ports {AN[1]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:21
# The conversion of 'IOSTANDARD' constraint on 'net' object 'AN[1]' has been applied to the port object 'AN[1]'.
set_property IOSTANDARD LVCMOS33 [get_ports {AN[1]}]
set_property PACKAGE_PIN AB21 [get_ports {AN[2]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:22
# The conversion of 'IOSTANDARD' constraint on 'net' object 'AN[2]' has been applied to the port object 'AN[2]'.
set_property IOSTANDARD LVCMOS33 [get_ports {AN[2]}]
set_property PACKAGE_PIN AC22 [get_ports {AN[3]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:23
# The conversion of 'IOSTANDARD' constraint on 'net' object 'AN[3]' has been applied to the port object 'AN[3]'.
set_property IOSTANDARD LVCMOS33 [get_ports {AN[3]}]

set_property PACKAGE_PIN AB26 [get_ports {LED[0]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:25
# The conversion of 'IOSTANDARD' constraint on 'net' object 'LED[0]' has been applied to the port object 'LED[0]'.
set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
set_property PACKAGE_PIN W24 [get_ports {LED[1]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:26
# The conversion of 'IOSTANDARD' constraint on 'net' object 'LED[1]' has been applied to the port object 'LED[1]'.
set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
set_property PACKAGE_PIN W23 [get_ports {LED[2]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:27
# The conversion of 'IOSTANDARD' constraint on 'net' object 'LED[2]' has been applied to the port object 'LED[2]'.
set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
set_property PACKAGE_PIN AB25 [get_ports {LED[3]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:28
# The conversion of 'IOSTANDARD' constraint on 'net' object 'LED[3]' has been applied to the port object 'LED[3]'.
set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
set_property PACKAGE_PIN AA25 [get_ports {LED[4]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:29
# The conversion of 'IOSTANDARD' constraint on 'net' object 'LED[4]' has been applied to the port object 'LED[4]'.
set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]
set_property PACKAGE_PIN W21 [get_ports {LED[5]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:30
# The conversion of 'IOSTANDARD' constraint on 'net' object 'LED[5]' has been applied to the port object 'LED[5]'.
set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
set_property PACKAGE_PIN V21 [get_ports {LED[6]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:31
# The conversion of 'IOSTANDARD' constraint on 'net' object 'LED[6]' has been applied to the port object 'LED[6]'.
set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
set_property PACKAGE_PIN W26 [get_ports {LED[7]}]
# D:/New File Location System/Course/2AW/Digtal Logic Design/ScoreBoardW9/top.ucf:32
# The conversion of 'IOSTANDARD' constraint on 'net' object 'LED[7]' has been applied to the port object 'LED[7]'.
set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]


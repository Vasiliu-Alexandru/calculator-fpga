project_new example1 -overwrite

set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE10E22C8

set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"

set_global_assignment -name VERILOG_FILE toplevel.v
set_global_assignment -name VERILOG_FILE hex2segments.v
set_global_assignment -name VERILOG_FILE PS2_receiver.v
set_global_assignment -name VERILOG_FILE formnumbers.v
set_global_assignment -name VERILOG_FILE clock_sync.v
set_global_assignment -name VERILOG_FILE produs.v
set_global_assignment -name VERILOG_FILE impartire.v
set_global_assignment -name VERILOG_FILE radical.v
set_global_assignment -name VERILOG_FILE pll_25.v
set_global_assignment -name VERILOG_FILE vga_display.v
set_global_assignment -name SDC_FILE example1.sdc


set_global_assignment -name TOP_LEVEL_ENTITY toplevel

set_location_assignment PIN_23  -to clk_50Mhz
set_location_assignment PIN_25  -to rst
set_location_assignment PIN_119  -to ps2_clk
set_location_assignment PIN_120  -to ps2_data

set_location_assignment PIN_133  -to digits[0]
set_location_assignment PIN_135  -to digits[1]
set_location_assignment PIN_136  -to digits[2]
set_location_assignment PIN_137  -to digits[3]



set_location_assignment PIN_128 -to segments[0]
set_location_assignment PIN_121 -to segments[1]
set_location_assignment PIN_125 -to segments[2]
set_location_assignment PIN_129 -to segments[3]
set_location_assignment PIN_132 -to segments[4]
set_location_assignment PIN_126 -to segments[5]
set_location_assignment PIN_124 -to segments[6]
set_location_assignment PIN_127 -to segments[7]


set_location_assignment PIN_84 -to a_t[3]
set_location_assignment PIN_85 -to a_t[2]
set_location_assignment PIN_86 -to a_t[1]
set_location_assignment PIN_87 -to sign_out

set_location_assignment PIN_101 -to hsync
set_location_assignment PIN_103 -to vsync
set_location_assignment PIN_106 -to red
set_location_assignment PIN_105 -to green
set_location_assignment PIN_104 -to blue


load_package flow
execute_flow -compile

project_close


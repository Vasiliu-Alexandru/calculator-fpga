project_new example1 -overwrite

set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE10E22C8

set_global_assignment -name VERILOG_FILE hex2segments.v
set_global_assignment -name VERILOG_FILE PS2_receiver.v
set_global_assignment -name VERILOG_FILE formnumbers.v
set_global_assignment -name VERILOG_FILE clock_sync.v
set_global_assignment -name VERILOG_FILE produs.v
set_global_assignment -name VERILOG_FILE impartire.v
set_global_assignment -name VERILOG_FILE radical.v

set_global_assignment -name TOP_LEVEL_ENTITY toplevel


set_location_assignment PIN_23  -to clk_50Mhz
set_location_assignment PIN_25  -to rst
set_location_assignment PIN_119  -to ps2_clk
set_location_assignment PIN_120  -to ps2_data

set_location_assignment PIN_133  -to digits[0]
set_location_assignment PIN_135  -to digits[1]
set_location_assignment PIN_136  -to digits[2]
set_location_assignment PIN_137  -to digits[3]


set_location_assignment PIN_65  -to digits2[0]
set_location_assignment PIN_58  -to digits2[1]
set_location_assignment PIN_52  -to digits2[2]
set_location_assignment PIN_30  -to digits2[3]



set_location_assignment PIN_128 -to segments[0]
set_location_assignment PIN_121 -to segments[1]
set_location_assignment PIN_125 -to segments[2]
set_location_assignment PIN_129 -to segments[3]
set_location_assignment PIN_132 -to segments[4]
set_location_assignment PIN_126 -to segments[5]
set_location_assignment PIN_124 -to segments[6]
set_location_assignment PIN_127 -to segments[7]


set_location_assignment PIN_39 -to segments2[0]
set_location_assignment PIN_32 -to segments2[1]
set_location_assignment PIN_54 -to segments2[2]
set_location_assignment PIN_46 -to segments2[3]
set_location_assignment PIN_43 -to segments2[4]
set_location_assignment PIN_34 -to segments2[5]
set_location_assignment PIN_50 -to segments2[6]
set_location_assignment PIN_60 -to segments2[7]




set_location_assignment PIN_84 -to a_t[3]
set_location_assignment PIN_85 -to a_t[2]
set_location_assignment PIN_86 -to a_t[1]
set_location_assignment PIN_87 -to sign_out


load_package flow
execute_flow -compile

project_close


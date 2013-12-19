# TCL File Generated by Component Editor 13.0
# Wed Jul 31 06:53:59 JST 2013
# DO NOT MODIFY


# 
# backlight_controller "backlight_controller" v1.0
# S.OSAFUNE / J-7SYSTEM Works 2013.07.31.06:53:59
# LCD Backlight Controller
# 

# 
# request TCL package from ACDS 13.0
# 
package require -exact qsys 13.0


# 
# module backlight_controller
# 
set_module_property DESCRIPTION "LCD Backlight Controller"
set_module_property NAME backlight_controller
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP Peripherals
set_module_property AUTHOR "S.OSAFUNE / J-7SYSTEM Works"
set_module_property DISPLAY_NAME backlight_controller
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL backlight_control
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file backlight_control.vhd VHDL PATH backlight_control.vhd TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point s1
# 
add_interface s1 avalon end
set_interface_property s1 addressUnits WORDS
set_interface_property s1 associatedClock clock
set_interface_property s1 associatedReset reset
set_interface_property s1 bitsPerSymbol 8
set_interface_property s1 burstOnBurstBoundariesOnly false
set_interface_property s1 burstcountUnits WORDS
set_interface_property s1 explicitAddressSpan 0
set_interface_property s1 holdTime 0
set_interface_property s1 linewrapBursts false
set_interface_property s1 maximumPendingReadTransactions 0
set_interface_property s1 readLatency 0
set_interface_property s1 readWaitTime 1
set_interface_property s1 setupTime 0
set_interface_property s1 timingUnits Cycles
set_interface_property s1 writeWaitTime 0
set_interface_property s1 ENABLED true
set_interface_property s1 EXPORT_OF ""
set_interface_property s1 PORT_NAME_MAP ""
set_interface_property s1 SVD_ADDRESS_GROUP ""

add_interface_port s1 readdata readdata Output 32
add_interface_port s1 write write Input 1
add_interface_port s1 writedata writedata Input 32
add_interface_port s1 read read Input 1
set_interface_assignment s1 embeddedsw.configuration.isFlash 0
set_interface_assignment s1 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s1 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s1 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point ext
# 
add_interface ext conduit end
set_interface_property ext associatedClock clock
set_interface_property ext associatedReset reset
set_interface_property ext ENABLED true
set_interface_property ext EXPORT_OF ""
set_interface_property ext PORT_NAME_MAP ""
set_interface_property ext SVD_ADDRESS_GROUP ""

add_interface_port ext backlight_on export Output 1
add_interface_port ext backlight_pwm export Output 1

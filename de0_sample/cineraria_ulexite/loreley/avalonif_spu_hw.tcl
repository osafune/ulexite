# TCL File Generated by Component Editor 13.0
# Tue Jul 09 10:00:18 JST 2013
# DO NOT MODIFY


# 
# avalonif_spu "avalonif_spu" v1.0
#  2013.07.09.10:00:18
# 
# 

# 
# request TCL package from ACDS 13.0
# 
package require -exact qsys 13.0


# 
# module avalonif_spu
# 
set_module_property DESCRIPTION ""
set_module_property NAME avalonif_spu
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP Peripherals
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME avalonif_spu
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset quartus_synth QUARTUS_SYNTH "" "Quartus Synthesis"
set_fileset_property quartus_synth TOP_LEVEL avalonif_spu
set_fileset_property quartus_synth ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file avalonif_spu.vhd VHDL PATH avalonif_spu.vhd TOP_LEVEL_FILE
add_fileset_file loreley_businterface.vhd VHDL PATH loreley_businterface.vhd
add_fileset_file loreley_cacheram.vhd VHDL PATH loreley_cacheram.vhd
add_fileset_file loreley_core.vhd VHDL PATH loreley_core.vhd
add_fileset_file loreley_dacif_bu9480f_ds.vhd VHDL PATH loreley_dacif_bu9480f_ds.vhd
add_fileset_file loreley_decoder.vhd VHDL PATH loreley_decoder.vhd
add_fileset_file loreley_dpram.vhd VHDL PATH loreley_dpram.vhd
add_fileset_file loreley_envram.vhd VHDL PATH loreley_envram.vhd
add_fileset_file loreley_irqencode.vhd VHDL PATH loreley_irqencode.vhd
add_fileset_file loreley_lfsr.vhd VHDL PATH loreley_lfsr.vhd
add_fileset_file loreley_slotengine.vhd VHDL PATH loreley_slotengine.vhd
add_fileset_file loreley_waveadder.vhd VHDL PATH loreley_waveadder.vhd
add_fileset_file loreley_wromcache.vhd VHDL PATH loreley_wromcache.vhd
add_fileset_file multiple_16x16.vhd VHDL PATH multiple_16x16.vhd
add_fileset_file multiple_16x9.vhd VHDL PATH multiple_16x9.vhd
add_fileset_file STARROSE_SPU.vhd VHDL PATH STARROSE_SPU.vhd
add_fileset_file wavebuffer.vhd VHDL PATH wavebuffer.vhd
add_fileset_file wsg_dsdac8.vhd VHDL PATH wsg_dsdac8.vhd
add_fileset_file wsg_spdif.vhd VHDL PATH wsg_spdif.vhd
add_fileset_file loreley_envram.mif OTHER PATH loreley_envram.mif

add_fileset sim_vhdl SIM_VHDL "" "VHDL Simulation"
set_fileset_property sim_vhdl ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file avalonif_spu.vhd VHDL PATH avalonif_spu.vhd
add_fileset_file loreley_businterface.vhd VHDL PATH loreley_businterface.vhd
add_fileset_file loreley_cacheram.vhd VHDL PATH loreley_cacheram.vhd
add_fileset_file loreley_core.vhd VHDL PATH loreley_core.vhd
add_fileset_file loreley_dacif_bu9480f_ds.vhd VHDL PATH loreley_dacif_bu9480f_ds.vhd
add_fileset_file loreley_decoder.vhd VHDL PATH loreley_decoder.vhd
add_fileset_file loreley_dpram.vhd VHDL PATH loreley_dpram.vhd
add_fileset_file loreley_envram.vhd VHDL PATH loreley_envram.vhd
add_fileset_file loreley_irqencode.vhd VHDL PATH loreley_irqencode.vhd
add_fileset_file loreley_lfsr.vhd VHDL PATH loreley_lfsr.vhd
add_fileset_file loreley_slotengine.vhd VHDL PATH loreley_slotengine.vhd
add_fileset_file loreley_waveadder.vhd VHDL PATH loreley_waveadder.vhd
add_fileset_file loreley_wromcache.vhd VHDL PATH loreley_wromcache.vhd
add_fileset_file multiple_16x16.vhd VHDL PATH multiple_16x16.vhd
add_fileset_file multiple_16x9.vhd VHDL PATH multiple_16x9.vhd
add_fileset_file STARROSE_SPU.vhd VHDL PATH STARROSE_SPU.vhd
add_fileset_file wavebuffer.vhd VHDL PATH wavebuffer.vhd
add_fileset_file wsg_dsdac8.vhd VHDL PATH wsg_dsdac8.vhd
add_fileset_file wsg_spdif.vhd VHDL PATH wsg_spdif.vhd


# 
# parameters
# 


# 
# display items
# 


# 
# connection point global
# 
add_interface global clock end
set_interface_property global clockRate 0
set_interface_property global ENABLED true
set_interface_property global EXPORT_OF ""
set_interface_property global PORT_NAME_MAP ""
set_interface_property global SVD_ADDRESS_GROUP ""

add_interface_port global csi_global_clock clk Input 1


# 
# connection point global_reset
# 
add_interface global_reset reset end
set_interface_property global_reset associatedClock global
set_interface_property global_reset synchronousEdges DEASSERT
set_interface_property global_reset ENABLED true
set_interface_property global_reset EXPORT_OF ""
set_interface_property global_reset PORT_NAME_MAP ""
set_interface_property global_reset SVD_ADDRESS_GROUP ""

add_interface_port global_reset csi_global_reset reset Input 1


# 
# connection point m1_clock
# 
add_interface m1_clock clock end
set_interface_property m1_clock clockRate 0
set_interface_property m1_clock ENABLED true
set_interface_property m1_clock EXPORT_OF ""
set_interface_property m1_clock PORT_NAME_MAP ""
set_interface_property m1_clock SVD_ADDRESS_GROUP ""

add_interface_port m1_clock csi_m1_clock clk Input 1


# 
# connection point m1
# 
add_interface m1 avalon start
set_interface_property m1 addressUnits SYMBOLS
set_interface_property m1 associatedClock m1_clock
set_interface_property m1 associatedReset global_reset
set_interface_property m1 bitsPerSymbol 8
set_interface_property m1 burstOnBurstBoundariesOnly true
set_interface_property m1 burstcountUnits WORDS
set_interface_property m1 doStreamReads false
set_interface_property m1 doStreamWrites false
set_interface_property m1 holdTime 0
set_interface_property m1 linewrapBursts false
set_interface_property m1 maximumPendingReadTransactions 0
set_interface_property m1 readLatency 0
set_interface_property m1 readWaitTime 1
set_interface_property m1 setupTime 0
set_interface_property m1 timingUnits Cycles
set_interface_property m1 writeWaitTime 0
set_interface_property m1 ENABLED true
set_interface_property m1 EXPORT_OF ""
set_interface_property m1 PORT_NAME_MAP ""
set_interface_property m1 SVD_ADDRESS_GROUP ""

add_interface_port m1 avm_m1_address address Output 25
add_interface_port m1 avm_m1_burstcount burstcount Output 3
add_interface_port m1 avm_m1_read read Output 1
add_interface_port m1 avm_m1_readdata readdata Input 16
add_interface_port m1 avm_m1_readdatavalid readdatavalid Input 1
add_interface_port m1 avm_m1_waitrequest waitrequest Input 1


# 
# connection point s1
# 
add_interface s1 avalon end
set_interface_property s1 addressUnits WORDS
set_interface_property s1 associatedClock global
set_interface_property s1 associatedReset global_reset
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

add_interface_port s1 avs_s1_address address Input 9
add_interface_port s1 avs_s1_chipselect chipselect Input 1
add_interface_port s1 avs_s1_read read Input 1
add_interface_port s1 avs_s1_write write Input 1
add_interface_port s1 avs_s1_byteenable byteenable Input 4
add_interface_port s1 avs_s1_readdata readdata Output 32
add_interface_port s1 avs_s1_writedata writedata Input 32
add_interface_port s1 avs_s1_waitrequest waitrequest Output 1
set_interface_assignment s1 embeddedsw.configuration.isFlash 0
set_interface_assignment s1 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s1 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s1 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point irq_s1
# 
add_interface irq_s1 interrupt end
set_interface_property irq_s1 associatedAddressablePoint s1
set_interface_property irq_s1 associatedClock global
set_interface_property irq_s1 associatedReset global_reset
set_interface_property irq_s1 ENABLED true
set_interface_property irq_s1 EXPORT_OF ""
set_interface_property irq_s1 PORT_NAME_MAP ""
set_interface_property irq_s1 SVD_ADDRESS_GROUP ""

add_interface_port irq_s1 avs_s1_irq irq Output 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock global
set_interface_property conduit_end associatedReset global_reset
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end clk_128fs export Input 1
add_interface_port conduit_end DAC_BCLK export Output 1
add_interface_port conduit_end DAC_LRCK export Output 1
add_interface_port conduit_end DAC_DATA export Output 1
add_interface_port conduit_end AUD_L export Output 1
add_interface_port conduit_end AUD_R export Output 1
add_interface_port conduit_end SPDIF export Output 1

# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    set ::env(RT_TMP) "./.Xil/Vivado-2368-DESKTOP-4M9UVAB/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7z010clg400-1

    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_vhdl -lib xil_defaultlib {
      C:/Users/Superminiala/Documents/VLSI/Lab_3/Lab_3.srcs/sources_1/new/mlab_rom.vhd
      C:/Users/Superminiala/Documents/VLSI/Lab_3/Lab_3.srcs/sources_1/new/MAC.vhd
      C:/Users/Superminiala/Documents/VLSI/Lab_3/Lab_3.srcs/sources_1/new/mlab_ram.vhd
      C:/Users/Superminiala/Documents/VLSI/Lab_3/Lab_3.srcs/sources_1/new/Control_Unit.vhd
      C:/Users/Superminiala/Documents/VLSI/Lab_3/Lab_3.srcs/sources_1/new/FIR.vhd
      C:/Users/Superminiala/Documents/VLSI/Lab_3/Lab_3.srcs/sources_1/new/FIR_pipe.vhd
      C:/Users/Superminiala/Documents/VLSI/Lab_3/Lab_3.srcs/sources_1/new/MUL_unit.vhd
      C:/Users/Superminiala/Documents/VLSI/Lab_3/Lab_3.srcs/sources_1/new/ADD_unit.vhd
      C:/Users/Superminiala/Documents/VLSI/Lab_3/Lab_3.srcs/sources_1/new/FIR_paral.vhd
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top FIR
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
    rt::set_parameter enableSplitFlowPath "./.Xil/Vivado-2368-DESKTOP-4M9UVAB/"
    if {$rt::useElabCache == false} {
      rt::run_rtlelab -module $rt::top
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
    }


    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  return -code "error" $rt::result
}

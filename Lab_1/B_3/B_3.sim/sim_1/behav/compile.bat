@echo off
rem  Vivado(TM)
rem  compile.bat: a Vivado-generated XSim simulation Script
rem  Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.

set PATH=%XILINX%\lib\%PLATFORM%;%XILINX%\bin\%PLATFORM%;C:/Xilinx/SDK/2014.2/bin;C:/Xilinx/Vivado/2014.2/ids_lite/ISE/bin/nt64;C:/Xilinx/Vivado/2014.2/ids_lite/ISE/lib/nt64;C:/Xilinx/Vivado/2014.2/bin;%PATH%
set XILINX_PLANAHEAD=C:/Xilinx/Vivado/2014.2

xelab -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot Up_Counter_With_Upper_Limit_tb_behav --prj C:/Users/Superminiala/Downloads/B_3/B_3.sim/sim_1/behav/Up_Counter_With_Upper_Limit_tb.prj   xil_defaultlib.Up_Counter_With_Upper_Limit_tb
if errorlevel 1 (
   cmd /c exit /b %errorlevel%
)

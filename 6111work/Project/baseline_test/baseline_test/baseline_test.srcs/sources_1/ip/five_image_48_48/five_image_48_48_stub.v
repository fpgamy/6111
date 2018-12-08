// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Thu Dec  6 16:58:10 2018
// Host        : eecs-digital-18 running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/five_image_48_48/five_image_48_48_stub.v
// Design      : five_image_48_48
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_3,Vivado 2016.2" *)
module five_image_48_48(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[11:0],douta[0:0]" */;
  input clka;
  input [11:0]addra;
  output [0:0]douta;
endmodule

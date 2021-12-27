// Code your testbench here
// or browse Examples
module test();
  reg clk,wr_1,wr_2,reset;
  reg [11:0]a0,a1,a2,a3,a4,a5,a6,a7;
  wire signed[11:0]b0,b1,b2,b3,b4,b5,b6,b7;
  
  Full_DCT uut(clk,wr_1,wr_2,reset,a0,a1,a2,a3,a4,a5,a6,a7,b0,b1,b2,b3,b4,b5,b6,b7);
  
  initial begin
    $monitor($time,"Output= %d %d %d %d %d %d %d %d",b0,b1,b2,b3,b4,b5,b6,b7);
  end
  
  always
    begin
      #5; clk = !clk;
    end
  
  initial begin
    clk=0;reset=1;wr_1=0;wr_2=0;
   #10reset=0;wr_1=1;a0=154;a1=123;a2=123;a3=723;a4=123;a5=123;a6=123;a7=136;
  #10a0=192;a1=180;a2=136;a3=154;a4=154;a5=154;a6=136;a7=110;
  #10a0=254;a1=198;a2=154;a3=154;a4=180;a5=154;a6=123;a7=123;
  #10a0=239;a1=180;a2=136;a3=180;a4=180;a5=166;a6=123;a7=123;
  #10a0=180;a1=154;a2=136;a3=167;a4=166;a5=149;a6=136;a7=136;
  #10a0=128;a1=136;a2=123;a3=136;a4=154;a5=180;a6=198;a7=154;
  #10a0=123;a1=105;a2=110;a3=149;a4=136;a5=136;a6=180;a7=166;
  #10a0=110;a1=136;a2=123;a3=123;a4=123;a5=136;a6=154;a7=136;
  #10wr_1=0;wr_2=1;
    #200;
    $finish();
  end
endmodule
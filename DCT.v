module DCT(input clk,
           input signed[11:0]a0,a1,a2,a3,a4,a5,a6,a7,
           output reg signed[11:0]b0,b1,b2,b3,b4,b5,b6,b7);
  
  wire [11:0] c1 = 12'b011111011000;
  wire [11:0] c2 = 12'b011101100100;
  wire [11:0] c3 = 12'b011010100110;
  wire [11:0] c4 = 12'b010110101000;
  wire [11:0] c5 = 12'b010001110001;
  wire [11:0] c6 = 12'b001100001111;
  wire [11:0] c7 = 12'b000110001111;
  
  wire signed [11:0] f07,f0_7,f16,f1_6,f25,f2_5,f34,f3_4;
  wire signed [11:0] f0734,f07_34,f1625,f16_25;
  wire signed [11:0] sum,diff;
  wire signed [11:0] x0,x1,x2,x3,x4,x5,x6,x7;
  wire signed[23:0]m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18,m19,m20,m21,m22,m23,m24,m25,m26,m27;
  wire signed [23:0] m0,m1,m2,m3,m4,m5,m6,m7;
  reg [11:0] r0[7:0],r1[7:0],r2[7:0],r3[7:0],r4[7:0],r5[7:0],r6[7:0],r7 [7:0];
  wire [2:0] count = 0;
  
  add_sub B1(f07,f0_7,a0,a7);
  add_sub B2(f16,f1_6,a1,a6);
  add_sub B3(f25,f2_5,a2,a5);
  add_sub B4(f34,f3_4,a3,a4);
  
  add_sub B5(f0734,f07_34,f07,f34);
  add_sub B6(f1625,f16_25,f16,f25);
  
  add_sub B7(sum,diff,f0734,f1625);
  
  multiplier M1(m0,sum,c4);
  multiplier M2(m4,diff,c4);
  
  multiplier M3(m8,f07_34,c2);
  multiplier M4(m9,f16_25,c6);
  assign m2 = m8+m9;
  
  multiplier M5(m10,f07_34,c6);
  multiplier M6(m11,f16_25,c2);
  assign m6 = m10-m11;
  
  multiplier M7(m12,f0_7,c1);
  multiplier M8(m13,f0_7,c3);
  multiplier M9(m14,f0_7,c5);
  multiplier M10(m15,f0_7,c7);
  
  multiplier M11(m16,f1_6,c1);
  multiplier M12(m17,f1_6,c3);
  multiplier M13(m18,f1_6,c5);
  multiplier M14(m19,f1_6,c7);
  
  multiplier M15(m20,f2_5,c1);
  multiplier M16(m21,f2_5,c3);
  multiplier M17(m22,f2_5,c5);
  multiplier M18(m23,f2_5,c7);
  
  multiplier M19(m24,f3_4,c1);
  multiplier M20(m25,f3_4,c3);
  multiplier M21(m26,f3_4,c5);
  multiplier M22(m27,f3_4,c7);
  
  assign m1 = m12+m17+m22+m27;
  assign m3 = m13-m19-m20-m26;
  assign m5 = m14-m16+m23+m25;
  assign m7 = m15-m18+m21-m24;
  /*assign out0 = (a0+a7+a1+a6+a2+a5+a3+a4)*c4;
  assign out1 = (a0-a7)*c1 + (a1-a6)*c3 + (a2-a5)*c5 + (a3-a4)*c7;
  assign out2 = (a0+a7-a3-a4)*c2 + (a1+a6-a2-a5)*c6;
  assign out3 = (a0-a7)*c3 - (a1-a6)*c7 - (a2-a5)*c1 - (a3-a4)*c5;
  assign out4 = (a0+a7+a3+a4-a1-a6-a2-a5)*c4;
  assign out5 = (a0-a7)*c5 - (a1-a6)*c1 + (a2-a5)*c7 + (a3-a4)*c3;
  assign out6 = (a0+a7-a3-a4)*c6 - (a1+a6-a2-a5)*c2;
  assign out7 = (a0-a7)*c7 - (a1-a6)*c5 + (a2-a5)*c3 - (a3-a4)*c1;
  
  assign out = out0*c4;*/
  
  assign x0 = m0>>12;
  assign x1 = m1>>12;
  assign x2 = m2>>12;
  assign x3 = m3>>12;  
  assign x4 = m4>>12;
  assign x5 = m5>>12;
  assign x6 = m6>>12;
  assign x7 = m7>>12;
    
  always @(posedge clk)begin
    {b0,b1,b2,b3,b4,b5,b6,b7} <= {x0,x1,x2,x3,x4,x5,x6,x7};
  end
  
endmodule

//#############################################################################
module add_sub(
  output reg [11:0] sum,diff,                                           
  input [11:0] x,y                                                      
    );

always @(x or y)
begin
  sum=x+y;
  diff=x-y;
end
endmodule


module multiplier(
  output reg [23:0]out,
  input signed[11:0] x,y
);
  
  always @(x,y)begin
    out = x*y;
  end
endmodule
//Booth Multiplier
/*module multiplier(Z,X, Y);
  input signed [11:0] X, Y;
  output signed [23:0] Z;
  reg signed [23:0] Z;
reg [1:0] temp;
integer i;
reg E1;
  reg [11:0] Y1;
always @ (X, Y)
begin
Z = 24'd0;
E1 = 1'd0;
Y1 = - Y;
  Z[11:0]=X;
  for (i = 0; i < 12; i = i + 1)
begin
temp = {X[i], E1};
case (temp)
  2'd2 : Z [23 : 12] = Z [23 : 12] + Y1;
  2'd1 : Z [23 : 12] = Z [23 : 12] + Y;
default : begin end
endcase
Z = Z >> 1;
  Z[23] = Z[22];
E1 = X[i];
end

end
endmodule*/
//######################################################################################
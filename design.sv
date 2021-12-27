// Code your design here
`include "DCT.v"
`include "register_file.v"
module Full_DCT(input clk,wr_1,wr_2,reset,
           input [11:0]a0,a1,a2,a3,a4,a5,a6,a7,
           output signed[11:0]b0,b1,b2,b3,b4,b5,b6,b7);
  
  wire [11:0] r0,r1,r2,r3,r4,r5,r6,r7;
  DCT uut(clk,a0,a1,a2,a3,a4,a5,a6,a7,r0,r1,r2,r3,r4,r5,r6,r7);
  
  reg [11:0] R0,R1,R2,R3,R4,R5,R6,R7;
  
  wire [11:0] m10,m11,m12,m13,m14,m15,m16,m17;
  wire [11:0] m20,m21,m22,m23,m24,m25,m26,m27;
  reg dwr_1,dwr_2;
  
  always @(posedge clk)begin
    dwr_1 <= wr_1;
  end
  
  block_mem M1(clk,reset,dwr_1,
               r0,r1,r2,r3,r4,r5,r6,r7,
		       m10,m11,m12,m13,m14,m15,m16,m17
		      );

  always @(*) begin
    case(dwr_1)
      1'b0 : begin
            R0 = m10;
            R1 = m11;
            R2 = m12;
            R3 = m13;
            R4 = m14;
            R5 = m15;
            R6 = m16;
            R7 = m17;
      end
      default :begin
            R0 = 0;
            R1 = 0;
            R2 = 0;
            R3 = 0;
            R4 = 0;
            R5 = 0;
            R6 = 0;
            R7 = 0;
      end
      endcase
  end
  DCT uut1(clk,R0,R1,R2,R3,R4,R5,R6,R7,b0,b1,b2,b3,b4,b5,b6,b7);
  
endmodule



  
  
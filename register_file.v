module block_mem(input clk,reset,wr,
		 input [11:0] in1,in2,in3,in4,in5,in6,in7,in8,
                 output reg [11:0] out0,out1,out2,out3,out4,out5,out6,out7
		);
  reg [11:0] mem_block[63:0];

reg [2:0] x,y;
	
  always@(posedge clk)
begin
	if(reset)
	begin
		x=0;
		y=0;
	end
	else if(wr==1)
	begin
		
      mem_block[(x*8)+0]<= in1;
      mem_block[(x*8)+1]<= in2;
      mem_block[(x*8)+2]<= in3;
      mem_block[(x*8)+3]<= in4;
      mem_block[(x*8)+4]<= in5;
      mem_block[(x*8)+5]<= in6;
      mem_block[(x*8)+6]<= in7;
      mem_block[(x*8)+7]<= in8;
		x<=x+1;
	end
  else if(wr==1'b0)
	begin
		out0 <=mem_block[y];
      out1 <=mem_block[8+y];
      out2 <=mem_block[16+y];
      out3 <=mem_block[24+y];
      out4 <=mem_block[32+y];
      out5 <=mem_block[40+y];
      out6 <=mem_block[48+y];
      out7 <=mem_block[56+y];
		y<= y+1;
	end

end
endmodule

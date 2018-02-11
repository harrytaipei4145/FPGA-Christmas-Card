`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:52:11 12/23/2015 
// Design Name: 
// Module Name:    Xmas 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Xmas(input reset,output hsync,output vsync,output reg red,output reg blue,output reg green,input clk);


wire rec,tria1,tria2,tria3;
reg [15:0]col,row;
wire visible;


//assign region = (pixel_col >=center_x) & (pixel_col < center_x+128) & (pixel_row >=center_y) & (pixel_row < center_y+128)
assign hsync  =~((col>=919) & (col<1039));
assign vsync  =~((row>=659) & (row<665));
assign visible  =((col>=104) & (col<904) & (row>=23) & (row<623));
assign tria1=((row <473) & (row-col>-206) & (row+col>802));
assign tria2=((row <298) & (row-col>-331) & (row+col>677)) ;
assign tria3=((row <173) & (row-col>-406) & (row+col>602)) ;
assign rec=((col >=469) & (col <539) & (row >=588) & (row < 623));


always @(posedge clk or posedge reset)begin
if(reset)
col<=0;
else if(col==1039)
col<=0; 
else
col<=col+1;
end


always @(posedge clk or posedge reset)begin
if(reset)
row<=0;
else if(row==665)
row<=0;
else if(col==1039)
row<=row+1; 
else
row<=row;
end


always @(posedge clk or posedge reset)begin
if(reset)begin
blue<=0;
green<=0;
red<=0;
end
else if(rec && visible)begin
blue<=0;
green<=0;
red<=0;
end
else if(tria1&& visible)begin
blue<=0;
green<=1;
red<=0;
end
else if(tria2&& visible)begin
blue<=0;
green<=1;
red<=0;
end

else if(tria3&& visible)begin
blue<=0;
green<=1;
red<=0;
end
else if(visible&& !rec)begin
blue<=1;
green<=0;
red<=0;
end
else
begin
blue<=blue;
green<=green;
red<=red;
end
end







endmodule

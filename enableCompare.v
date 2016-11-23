`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2016 12:56:34 AM
// Design Name: 
// Module Name: enableCompare
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module enableCompare(
    input upEnable[3:0][5:0],
    input downEnable[3:0][5:0],
    input leftEnable[3:0][5:0],
    input rightEnable[3:0][5:0],
    
    output reg upEnable_o,
    output reg downEnable_o,
    output  leftEnable_o,
    output  rightEnable_o

);

//assign up_Enable=1'b1;
//assign down_Enable=1'b1;
assign leftEnable_o=1'b1;
assign rightEnable_o=1'b1;

reg [23:0] upEnable_all; 
reg [23:0] downEnable_all;

always@(*) begin
//DOWN ENABLE
//scroll 0
downEnable_all[0]<=downEnable[0][0];
downEnable_all[1]<=downEnable[1][0];
downEnable_all[2]<=downEnable[2][0];
downEnable_all[3]<=downEnable[3][0];
//scroll 1
downEnable_all[4]<=downEnable[0][1];
downEnable_all[5]<=downEnable[1][1];
downEnable_all[6]<=downEnable[2][1];
downEnable_all[7]<=downEnable[3][1];
//scroll 2
 downEnable_all[8]<=downEnable[0][2];    
 downEnable_all[9]<=downEnable[1][2];
downEnable_all[10]<=downEnable[2][2];
downEnable_all[11]<=downEnable[3][2];
//scroll 3
downEnable_all[12]<=downEnable[0][3];
downEnable_all[13]<=downEnable[1][3];
downEnable_all[14]<=downEnable[2][3];
downEnable_all[15]<=downEnable[3][3];
//scroll 4
downEnable_all[16]<=downEnable[0][4];    
downEnable_all[17]<=downEnable[1][4];
downEnable_all[18]<=downEnable[2][4];
downEnable_all[19]<=downEnable[3][4];

//scroll 5
downEnable_all[20]<=downEnable[0][5];
downEnable_all[21]<=downEnable[1][5];
downEnable_all[22]<=downEnable[2][5];
downEnable_all[23]<=downEnable[3][5];  
    // UP ENABLE 
  //scroll 0
  upEnable_all[0]<=upEnable[0][0];
  upEnable_all[1]<=upEnable[1][0];
  upEnable_all[2]<=upEnable[2][0];
  upEnable_all[3]<=upEnable[3][0];
  //scroll 1
  upEnable_all[4]<=upEnable[0][1];
  upEnable_all[5]<=upEnable[1][1];
  upEnable_all[6]<=upEnable[2][1];
  upEnable_all[7]<=upEnable[3][1];
  //scroll 2
   upEnable_all[8]<=upEnable[0][2];    
   upEnable_all[9]<=upEnable[1][2];
  upEnable_all[10]<=upEnable[2][2];
  upEnable_all[11]<=upEnable[3][2];
  //scroll 3
  upEnable_all[12]<=upEnable[0][3];
  upEnable_all[13]<=upEnable[1][3];
  upEnable_all[14]<=upEnable[2][3];
  upEnable_all[15]<=upEnable[3][3];
  //scroll 4
  upEnable_all[16]<=upEnable[0][4];    
  upEnable_all[17]<=upEnable[1][4];
  upEnable_all[18]<=upEnable[2][4];
  upEnable_all[19]<=upEnable[3][4];

  //scroll 5
  upEnable_all[20]<=upEnable[0][5];
  upEnable_all[21]<=upEnable[1][5];
  upEnable_all[22]<=upEnable[2][5];
  upEnable_all[23]<=upEnable[3][5];   
  
//enable/disable down    
    if(downEnable_all == 24'hFFFFFF)        downEnable_o <= 1;
    else        downEnable_o <= 0;
//enable/disable up    
  if(upEnable_all == 24'hFFFFFF)      upEnable_o <= 1;
  else      upEnable_o <= 0;
end

endmodule
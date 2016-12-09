`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2016 10:56:34 AM
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
    //wall
    input wall_upEnable[23:0][5:0],
    input wall_downEnable[23:0][5:0],
    input wall_leftEnable[23:0][5:0],
    input wall_rightEnable[23:0][5:0],
    
    output reg upEnable_o,
    output reg downEnable_o,
    output  reg leftEnable_o,
    output   reg rightEnable_o

);

//assign up_Enable=1'b1;
//assign down_Enable=1'b1;
//assign leftEnable_o=1'b1;
//assign rightEnable_o=1'b1;

reg [23:0] upEnable_all; 
reg [23:0] downEnable_all;
reg [23:0] leftEnable_all;
reg [23:0] rightEnable_all;

//WALL ENABLES - each collection of walls has own register
//Wall0
reg [23:0] wall_upEnable_all; 
reg [23:0] wall_downEnable_all;
reg [23:0] wall_leftEnable_all;
reg [23:0] wall_rightEnable_all;
//Wall1
reg [23:0] wall_upEnable_all_1; 
reg [23:0] wall_downEnable_all_1;
reg [23:0] wall_leftEnable_all_1;
reg [23:0] wall_rightEnable_all_1;
//Wall12
reg [23:0]    wall_upEnable_all_2; 
reg [23:0]  wall_downEnable_all_2;
reg [23:0]  wall_leftEnable_all_2;
reg [23:0] wall_rightEnable_all_2;
//Wall13                          
reg [23:0]    wall_upEnable_all_3;
reg [23:0]  wall_downEnable_all_3;
reg [23:0]  wall_leftEnable_all_3;
reg [23:0] wall_rightEnable_all_3;
//Wall14                         
reg [23:0]    wall_upEnable_all_4;
reg [23:0]  wall_downEnable_all_4;
reg [23:0]  wall_leftEnable_all_4;
reg [23:0] wall_rightEnable_all_4;
//Wall15                         
reg [23:0]    wall_upEnable_all_5;
reg [23:0]  wall_downEnable_all_5;
reg [23:0]  wall_leftEnable_all_5;
reg [23:0] wall_rightEnable_all_5;

//All WALLS -- ORing this register with each of the others gets a single register with all info
reg [23:0]    wall_upEnable_all_OR;
reg [23:0]  wall_downEnable_all_OR;
reg [23:0]  wall_leftEnable_all_OR;
reg [23:0] wall_rightEnable_all_OR;









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



// LEFT ENABLE 
    //scroll 0
    leftEnable_all[0]<=leftEnable[0][0];
    leftEnable_all[1]<=leftEnable[1][0];
    leftEnable_all[2]<=leftEnable[2][0];
    leftEnable_all[3]<=leftEnable[3][0];
    //scroll 1
    leftEnable_all[4]<=leftEnable[0][1];
    leftEnable_all[5]<=leftEnable[1][1];
    leftEnable_all[6]<=leftEnable[2][1];
    leftEnable_all[7]<=leftEnable[3][1];
    //scroll 2
    leftEnable_all [8]<=leftEnable[0][2];    
    leftEnable_all [9]<=leftEnable[1][2];
    leftEnable_all[10]<=leftEnable[2][2];
    leftEnable_all[11]<=leftEnable[3][2];
    //scroll 3
    leftEnable_all[12]<=leftEnable[0][3];
    leftEnable_all[13]<=leftEnable[1][3];
    leftEnable_all[14]<=leftEnable[2][3];
    leftEnable_all[15]<=leftEnable[3][3];
    //scroll 4
    leftEnable_all[16]<=leftEnable[0][4];    
    leftEnable_all[17]<=leftEnable[1][4];
    leftEnable_all[18]<=leftEnable[2][4];
    leftEnable_all[19]<=leftEnable[3][4];
    //scroll 5
    leftEnable_all[20]<=leftEnable[0][5];
    leftEnable_all[21]<=leftEnable[1][5];
    leftEnable_all[22]<=leftEnable[2][5];
    leftEnable_all[23]<=leftEnable[3][5];  
  
// RIGHT ENABLE 
    //scroll 0
    rightEnable_all[0]<=rightEnable[0][0];
    rightEnable_all[1]<=rightEnable[1][0];
    rightEnable_all[2]<=rightEnable[2][0];
    rightEnable_all[3]<=rightEnable[3][0];
    //scroll 1
    rightEnable_all[4]<=rightEnable[0][1];
    rightEnable_all[5]<=rightEnable[1][1];
    rightEnable_all[6]<=rightEnable[2][1];
    rightEnable_all[7]<=rightEnable[3][1];
    //scroll 2
    rightEnable_all [8]<=rightEnable[0][2];    
    rightEnable_all [9]<=rightEnable[1][2];
    rightEnable_all[10]<=rightEnable[2][2];
    rightEnable_all[11]<=rightEnable[3][2];
    //scroll 3
    rightEnable_all[12]<=rightEnable[0][3];
    rightEnable_all[13]<=rightEnable[1][3];
    rightEnable_all[14]<=rightEnable[2][3];
    rightEnable_all[15]<=rightEnable[3][3];
    //scroll 4
    rightEnable_all[16]<=rightEnable[0][4];    
    rightEnable_all[17]<=rightEnable[1][4];
    rightEnable_all[18]<=rightEnable[2][4];
    rightEnable_all[19]<=rightEnable[3][4];
    //scroll 5
    rightEnable_all[20]<=rightEnable[0][5];
    rightEnable_all[21]<=rightEnable[1][5];
    rightEnable_all[22]<=rightEnable[2][5];
    rightEnable_all[23]<=rightEnable[3][5];  

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

//==============================================
//WALL
//==============================================
//DOWN ENABLE
//wall 0
wall_downEnable_all[0]<=wall_downEnable  [0][0];
wall_downEnable_all[1]<=wall_downEnable  [1][0];
wall_downEnable_all[2]<=wall_downEnable  [2][0];
wall_downEnable_all[3]<=wall_downEnable  [3][0];
wall_downEnable_all[4]<=wall_downEnable  [4][0];
wall_downEnable_all[5]<=wall_downEnable  [5][0];
wall_downEnable_all[6]<=wall_downEnable  [6][0];
wall_downEnable_all[7]<=wall_downEnable  [7][0];
wall_downEnable_all[8]<=wall_downEnable  [8][0];
wall_downEnable_all[9]<=wall_downEnable  [9][0];
wall_downEnable_all[10]<=wall_downEnable[10][0];
wall_downEnable_all[11]<=wall_downEnable[11][0];
wall_downEnable_all[12]<=wall_downEnable[12][0];
wall_downEnable_all[13]<=wall_downEnable[13][0];
wall_downEnable_all[14]<=wall_downEnable[14][0];
wall_downEnable_all[15]<=wall_downEnable[15][0];
wall_downEnable_all[16]<=wall_downEnable[16][0];    
wall_downEnable_all[17]<=wall_downEnable[17][0];
wall_downEnable_all[18]<=wall_downEnable[18][0];
wall_downEnable_all[19]<=wall_downEnable[19][0];
wall_downEnable_all[20]<=wall_downEnable[20][0];
wall_downEnable_all[21]<=wall_downEnable[21][0];
wall_downEnable_all[22]<=wall_downEnable[22][0];
wall_downEnable_all[23]<=wall_downEnable[23][0];  

//wall 1 
wall_downEnable_all_1[0]<=wall_downEnable  [0][1];
wall_downEnable_all_1[1]<=wall_downEnable  [1][1];
wall_downEnable_all_1[2]<=wall_downEnable  [2][1];
wall_downEnable_all_1[3]<=wall_downEnable  [3][1];
wall_downEnable_all_1[4]<=wall_downEnable  [4][1];
wall_downEnable_all_1[5]<=wall_downEnable  [5][1];
wall_downEnable_all_1[6]<=wall_downEnable  [6][1];
wall_downEnable_all_1[7]<=wall_downEnable  [7][1];
wall_downEnable_all_1[8]<=wall_downEnable  [8][1];
wall_downEnable_all_1[9]<=wall_downEnable  [9][1];
wall_downEnable_all_1[10]<=wall_downEnable[10][1];
wall_downEnable_all_1[11]<=wall_downEnable[11][1];
wall_downEnable_all_1[12]<=wall_downEnable[12][1];
wall_downEnable_all_1[13]<=wall_downEnable[13][1];
wall_downEnable_all_1[14]<=wall_downEnable[14][1];
wall_downEnable_all_1[15]<=wall_downEnable[15][1];
wall_downEnable_all_1[16]<=wall_downEnable[16][1];    
wall_downEnable_all_1[17]<=wall_downEnable[17][1];
wall_downEnable_all_1[18]<=wall_downEnable[18][1];
wall_downEnable_all_1[19]<=wall_downEnable[19][1];
wall_downEnable_all_1[20]<=wall_downEnable[20][1];
wall_downEnable_all_1[21]<=wall_downEnable[21][1];
wall_downEnable_all_1[22]<=wall_downEnable[22][1];
wall_downEnable_all_1[23]<=wall_downEnable[23][1]; 
//wall 2
wall_downEnable_all_2[0]<=wall_downEnable  [0][2]; 
wall_downEnable_all_2[1]<=wall_downEnable  [1][2]; 
wall_downEnable_all_2[2]<=wall_downEnable  [2][2]; 
wall_downEnable_all_2[3]<=wall_downEnable  [3][2]; 
wall_downEnable_all_2[4]<=wall_downEnable  [4][2]; 
wall_downEnable_all_2[5]<=wall_downEnable  [5][2]; 
wall_downEnable_all_2[6]<=wall_downEnable  [6][2]; 
wall_downEnable_all_2[7]<=wall_downEnable  [7][2]; 
wall_downEnable_all_2[8]<=wall_downEnable  [8][2]; 
wall_downEnable_all_2[9]<=wall_downEnable  [9][2]; 
wall_downEnable_all_2[10]<=wall_downEnable[10][2]; 
wall_downEnable_all_2[11]<=wall_downEnable[11][2]; 
wall_downEnable_all_2[12]<=wall_downEnable[12][2]; 
wall_downEnable_all_2[13]<=wall_downEnable[13][2]; 
wall_downEnable_all_2[14]<=wall_downEnable[14][2]; 
wall_downEnable_all_2[15]<=wall_downEnable[15][2]; 
wall_downEnable_all_2[16]<=wall_downEnable[16][2]; 
wall_downEnable_all_2[17]<=wall_downEnable[17][2]; 
wall_downEnable_all_2[18]<=wall_downEnable[18][2]; 
wall_downEnable_all_2[19]<=wall_downEnable[19][2]; 
wall_downEnable_all_2[20]<=wall_downEnable[20][2]; 
wall_downEnable_all_2[21]<=wall_downEnable[21][2]; 
wall_downEnable_all_2[22]<=wall_downEnable[22][2]; 
wall_downEnable_all_2[23]<=wall_downEnable[23][2]; 
//wall 3
wall_downEnable_all_3[0]<=wall_downEnable  [0][3]; 
wall_downEnable_all_3[1]<=wall_downEnable  [1][3]; 
wall_downEnable_all_3[2]<=wall_downEnable  [2][3]; 
wall_downEnable_all_3[3]<=wall_downEnable  [3][3]; 
wall_downEnable_all_3[4]<=wall_downEnable  [4][3]; 
wall_downEnable_all_3[5]<=wall_downEnable  [5][3]; 
wall_downEnable_all_3[6]<=wall_downEnable  [6][3]; 
wall_downEnable_all_3[7]<=wall_downEnable  [7][3]; 
wall_downEnable_all_3[8]<=wall_downEnable  [8][3]; 
wall_downEnable_all_3[9]<=wall_downEnable  [9][3]; 
wall_downEnable_all_3[10]<=wall_downEnable[10][3]; 
wall_downEnable_all_3[11]<=wall_downEnable[11][3]; 
wall_downEnable_all_3[12]<=wall_downEnable[12][3]; 
wall_downEnable_all_3[13]<=wall_downEnable[13][3]; 
wall_downEnable_all_3[14]<=wall_downEnable[14][3]; 
wall_downEnable_all_3[15]<=wall_downEnable[15][3]; 
wall_downEnable_all_3[16]<=wall_downEnable[16][3]; 
wall_downEnable_all_3[17]<=wall_downEnable[17][3]; 
wall_downEnable_all_3[18]<=wall_downEnable[18][3]; 
wall_downEnable_all_3[19]<=wall_downEnable[19][3]; 
wall_downEnable_all_3[20]<=wall_downEnable[20][3]; 
wall_downEnable_all_3[21]<=wall_downEnable[21][3]; 
wall_downEnable_all_3[22]<=wall_downEnable[22][3]; 
wall_downEnable_all_3[23]<=wall_downEnable[23][3]; 
//wall 4
wall_downEnable_all_4[0]<=wall_downEnable  [0][4]; 
wall_downEnable_all_4[1]<=wall_downEnable  [1][4]; 
wall_downEnable_all_4[2]<=wall_downEnable  [2][4]; 
wall_downEnable_all_4[3]<=wall_downEnable  [3][4]; 
wall_downEnable_all_4[4]<=wall_downEnable  [4][4]; 
wall_downEnable_all_4[5]<=wall_downEnable  [5][4]; 
wall_downEnable_all_4[6]<=wall_downEnable  [6][4]; 
wall_downEnable_all_4[7]<=wall_downEnable  [7][4]; 
wall_downEnable_all_4[8]<=wall_downEnable  [8][4]; 
wall_downEnable_all_4[9]<=wall_downEnable  [9][4]; 
wall_downEnable_all_4[10]<=wall_downEnable[10][4]; 
wall_downEnable_all_4[11]<=wall_downEnable[11][4]; 
wall_downEnable_all_4[12]<=wall_downEnable[12][4]; 
wall_downEnable_all_4[13]<=wall_downEnable[13][4]; 
wall_downEnable_all_4[14]<=wall_downEnable[14][4]; 
wall_downEnable_all_4[15]<=wall_downEnable[15][4]; 
wall_downEnable_all_4[16]<=wall_downEnable[16][4]; 
wall_downEnable_all_4[17]<=wall_downEnable[17][4]; 
wall_downEnable_all_4[18]<=wall_downEnable[18][4]; 
wall_downEnable_all_4[19]<=wall_downEnable[19][4]; 
wall_downEnable_all_4[20]<=wall_downEnable[20][4]; 
wall_downEnable_all_4[21]<=wall_downEnable[21][4]; 
wall_downEnable_all_4[22]<=wall_downEnable[22][4]; 
wall_downEnable_all_4[23]<=wall_downEnable[23][4]; 

//wall 5
wall_downEnable_all_5[0]<=wall_downEnable  [0][5]; 
wall_downEnable_all_5[1]<=wall_downEnable  [1][5]; 
wall_downEnable_all_5[2]<=wall_downEnable  [2][5]; 
wall_downEnable_all_5[3]<=wall_downEnable  [3][5]; 
wall_downEnable_all_5[4]<=wall_downEnable  [4][5]; 
wall_downEnable_all_5[5]<=wall_downEnable  [5][5]; 
wall_downEnable_all_5[6]<=wall_downEnable  [6][5]; 
wall_downEnable_all_5[7]<=wall_downEnable  [7][5]; 
wall_downEnable_all_5[8]<=wall_downEnable  [8][5]; 
wall_downEnable_all_5[9]<=wall_downEnable  [9][5]; 
wall_downEnable_all_5[10]<=wall_downEnable[10][5]; 
wall_downEnable_all_5[11]<=wall_downEnable[11][5]; 
wall_downEnable_all_5[12]<=wall_downEnable[12][5]; 
wall_downEnable_all_5[13]<=wall_downEnable[13][5]; 
wall_downEnable_all_5[14]<=wall_downEnable[14][5]; 
wall_downEnable_all_5[15]<=wall_downEnable[15][5]; 
wall_downEnable_all_5[16]<=wall_downEnable[16][5]; 
wall_downEnable_all_5[17]<=wall_downEnable[17][5]; 
wall_downEnable_all_5[18]<=wall_downEnable[18][5]; 
wall_downEnable_all_5[19]<=wall_downEnable[19][5]; 
wall_downEnable_all_5[20]<=wall_downEnable[20][5]; 
wall_downEnable_all_5[21]<=wall_downEnable[21][5]; 
wall_downEnable_all_5[22]<=wall_downEnable[22][5]; 
wall_downEnable_all_5[23]<=wall_downEnable[23][5];  
    // UP ENABLE 
//wall 0
wall_upEnable_all[0]<=wall_upEnable  [0][0];
wall_upEnable_all[1]<=wall_upEnable  [1][0];
wall_upEnable_all[2]<=wall_upEnable  [2][0];
wall_upEnable_all[3]<=wall_upEnable  [3][0];
wall_upEnable_all[4]<=wall_upEnable  [4][0];
wall_upEnable_all[5]<=wall_upEnable  [5][0];
wall_upEnable_all[6]<=wall_upEnable  [6][0];
wall_upEnable_all[7]<=wall_upEnable  [7][0];
wall_upEnable_all[8]<=wall_upEnable  [8][0];
wall_upEnable_all[9]<=wall_upEnable  [9][0];
wall_upEnable_all[10]<=wall_upEnable[10][0];
wall_upEnable_all[11]<=wall_upEnable[11][0];
wall_upEnable_all[12]<=wall_upEnable[12][0];
wall_upEnable_all[13]<=wall_upEnable[13][0];
wall_upEnable_all[14]<=wall_upEnable[14][0];
wall_upEnable_all[15]<=wall_upEnable[15][0];
wall_upEnable_all[16]<=wall_upEnable[16][0];    
wall_upEnable_all[17]<=wall_upEnable[17][0];
wall_upEnable_all[18]<=wall_upEnable[18][0];
wall_upEnable_all[19]<=wall_upEnable[19][0];
wall_upEnable_all[20]<=wall_upEnable[20][0];
wall_upEnable_all[21]<=wall_upEnable[21][0];
wall_upEnable_all[22]<=wall_upEnable[22][0];
wall_upEnable_all[23]<=wall_upEnable[23][0];  

//wall 1 
wall_upEnable_all_1[0]<=wall_upEnable  [0][1];
wall_upEnable_all_1[1]<=wall_upEnable  [1][1];
wall_upEnable_all_1[2]<=wall_upEnable  [2][1];
wall_upEnable_all_1[3]<=wall_upEnable  [3][1];
wall_upEnable_all_1[4]<=wall_upEnable  [4][1];
wall_upEnable_all_1[5]<=wall_upEnable  [5][1];
wall_upEnable_all_1[6]<=wall_upEnable  [6][1];
wall_upEnable_all_1[7]<=wall_upEnable  [7][1];
wall_upEnable_all_1[8]<=wall_upEnable  [8][1];
wall_upEnable_all_1[9]<=wall_upEnable  [9][1];
wall_upEnable_all_1[10]<=wall_upEnable[10][1];
wall_upEnable_all_1[11]<=wall_upEnable[11][1];
wall_upEnable_all_1[12]<=wall_upEnable[12][1];
wall_upEnable_all_1[13]<=wall_upEnable[13][1];
wall_upEnable_all_1[14]<=wall_upEnable[14][1];
wall_upEnable_all_1[15]<=wall_upEnable[15][1];
wall_upEnable_all_1[16]<=wall_upEnable[16][1];    
wall_upEnable_all_1[17]<=wall_upEnable[17][1];
wall_upEnable_all_1[18]<=wall_upEnable[18][1];
wall_upEnable_all_1[19]<=wall_upEnable[19][1];
wall_upEnable_all_1[20]<=wall_upEnable[20][1];
wall_upEnable_all_1[21]<=wall_upEnable[21][1];
wall_upEnable_all_1[22]<=wall_upEnable[22][1];
wall_upEnable_all_1[23]<=wall_upEnable[23][1]; 
//wall 2
wall_upEnable_all_2[0]<=wall_upEnable  [0][2]; 
wall_upEnable_all_2[1]<=wall_upEnable  [1][2]; 
wall_upEnable_all_2[2]<=wall_upEnable  [2][2]; 
wall_upEnable_all_2[3]<=wall_upEnable  [3][2]; 
wall_upEnable_all_2[4]<=wall_upEnable  [4][2]; 
wall_upEnable_all_2[5]<=wall_upEnable  [5][2]; 
wall_upEnable_all_2[6]<=wall_upEnable  [6][2]; 
wall_upEnable_all_2[7]<=wall_upEnable  [7][2]; 
wall_upEnable_all_2[8]<=wall_upEnable  [8][2]; 
wall_upEnable_all_2[9]<=wall_upEnable  [9][2]; 
wall_upEnable_all_2[10]<=wall_upEnable[10][2]; 
wall_upEnable_all_2[11]<=wall_upEnable[11][2]; 
wall_upEnable_all_2[12]<=wall_upEnable[12][2]; 
wall_upEnable_all_2[13]<=wall_upEnable[13][2]; 
wall_upEnable_all_2[14]<=wall_upEnable[14][2]; 
wall_upEnable_all_2[15]<=wall_upEnable[15][2]; 
wall_upEnable_all_2[16]<=wall_upEnable[16][2]; 
wall_upEnable_all_2[17]<=wall_upEnable[17][2]; 
wall_upEnable_all_2[18]<=wall_upEnable[18][2]; 
wall_upEnable_all_2[19]<=wall_upEnable[19][2]; 
wall_upEnable_all_2[20]<=wall_upEnable[20][2]; 
wall_upEnable_all_2[21]<=wall_upEnable[21][2]; 
wall_upEnable_all_2[22]<=wall_upEnable[22][2]; 
wall_upEnable_all_2[23]<=wall_upEnable[23][2]; 
//wall 3
wall_upEnable_all_3[0]<=wall_upEnable  [0][3]; 
wall_upEnable_all_3[1]<=wall_upEnable  [1][3]; 
wall_upEnable_all_3[2]<=wall_upEnable  [2][3]; 
wall_upEnable_all_3[3]<=wall_upEnable  [3][3]; 
wall_upEnable_all_3[4]<=wall_upEnable  [4][3]; 
wall_upEnable_all_3[5]<=wall_upEnable  [5][3]; 
wall_upEnable_all_3[6]<=wall_upEnable  [6][3]; 
wall_upEnable_all_3[7]<=wall_upEnable  [7][3]; 
wall_upEnable_all_3[8]<=wall_upEnable  [8][3]; 
wall_upEnable_all_3[9]<=wall_upEnable  [9][3]; 
wall_upEnable_all_3[10]<=wall_upEnable[10][3]; 
wall_upEnable_all_3[11]<=wall_upEnable[11][3]; 
wall_upEnable_all_3[12]<=wall_upEnable[12][3]; 
wall_upEnable_all_3[13]<=wall_upEnable[13][3]; 
wall_upEnable_all_3[14]<=wall_upEnable[14][3]; 
wall_upEnable_all_3[15]<=wall_upEnable[15][3]; 
wall_upEnable_all_3[16]<=wall_upEnable[16][3]; 
wall_upEnable_all_3[17]<=wall_upEnable[17][3]; 
wall_upEnable_all_3[18]<=wall_upEnable[18][3]; 
wall_upEnable_all_3[19]<=wall_upEnable[19][3]; 
wall_upEnable_all_3[20]<=wall_upEnable[20][3]; 
wall_upEnable_all_3[21]<=wall_upEnable[21][3]; 
wall_upEnable_all_3[22]<=wall_upEnable[22][3]; 
wall_upEnable_all_3[23]<=wall_upEnable[23][3]; 
//wall 4
wall_upEnable_all_4[0]<=wall_upEnable  [0][4]; 
wall_upEnable_all_4[1]<=wall_upEnable  [1][4]; 
wall_upEnable_all_4[2]<=wall_upEnable  [2][4]; 
wall_upEnable_all_4[3]<=wall_upEnable  [3][4]; 
wall_upEnable_all_4[4]<=wall_upEnable  [4][4]; 
wall_upEnable_all_4[5]<=wall_upEnable  [5][4]; 
wall_upEnable_all_4[6]<=wall_upEnable  [6][4]; 
wall_upEnable_all_4[7]<=wall_upEnable  [7][4]; 
wall_upEnable_all_4[8]<=wall_upEnable  [8][4]; 
wall_upEnable_all_4[9]<=wall_upEnable  [9][4]; 
wall_upEnable_all_4[10]<=wall_upEnable[10][4]; 
wall_upEnable_all_4[11]<=wall_upEnable[11][4]; 
wall_upEnable_all_4[12]<=wall_upEnable[12][4]; 
wall_upEnable_all_4[13]<=wall_upEnable[13][4]; 
wall_upEnable_all_4[14]<=wall_upEnable[14][4]; 
wall_upEnable_all_4[15]<=wall_upEnable[15][4]; 
wall_upEnable_all_4[16]<=wall_upEnable[16][4]; 
wall_upEnable_all_4[17]<=wall_upEnable[17][4]; 
wall_upEnable_all_4[18]<=wall_upEnable[18][4]; 
wall_upEnable_all_4[19]<=wall_upEnable[19][4]; 
wall_upEnable_all_4[20]<=wall_upEnable[20][4]; 
wall_upEnable_all_4[21]<=wall_upEnable[21][4]; 
wall_upEnable_all_4[22]<=wall_upEnable[22][4]; 
wall_upEnable_all_4[23]<=wall_upEnable[23][4]; 

//wall 5
wall_upEnable_all_5[0]<=wall_upEnable  [0][5]; 
wall_upEnable_all_5[1]<=wall_upEnable  [1][5]; 
wall_upEnable_all_5[2]<=wall_upEnable  [2][5]; 
wall_upEnable_all_5[3]<=wall_upEnable  [3][5]; 
wall_upEnable_all_5[4]<=wall_upEnable  [4][5]; 
wall_upEnable_all_5[5]<=wall_upEnable  [5][5]; 
wall_upEnable_all_5[6]<=wall_upEnable  [6][5]; 
wall_upEnable_all_5[7]<=wall_upEnable  [7][5]; 
wall_upEnable_all_5[8]<=wall_upEnable  [8][5]; 
wall_upEnable_all_5[9]<=wall_upEnable  [9][5]; 
wall_upEnable_all_5[10]<=wall_upEnable[10][5]; 
wall_upEnable_all_5[11]<=wall_upEnable[11][5]; 
wall_upEnable_all_5[12]<=wall_upEnable[12][5]; 
wall_upEnable_all_5[13]<=wall_upEnable[13][5]; 
wall_upEnable_all_5[14]<=wall_upEnable[14][5]; 
wall_upEnable_all_5[15]<=wall_upEnable[15][5]; 
wall_upEnable_all_5[16]<=wall_upEnable[16][5]; 
wall_upEnable_all_5[17]<=wall_upEnable[17][5]; 
wall_upEnable_all_5[18]<=wall_upEnable[18][5]; 
wall_upEnable_all_5[19]<=wall_upEnable[19][5]; 
wall_upEnable_all_5[20]<=wall_upEnable[20][5]; 
wall_upEnable_all_5[21]<=wall_upEnable[21][5]; 
wall_upEnable_all_5[22]<=wall_upEnable[22][5]; 
wall_upEnable_all_5[23]<=wall_upEnable[23][5];  
// RIGHT ENABLE 
//wall 0
wall_rightEnable_all[0]<=wall_rightEnable  [0][0];
wall_rightEnable_all[1]<=wall_rightEnable  [1][0];
wall_rightEnable_all[2]<=wall_rightEnable  [2][0];
wall_rightEnable_all[3]<=wall_rightEnable  [3][0];
wall_rightEnable_all[4]<=wall_rightEnable  [4][0];
wall_rightEnable_all[5]<=wall_rightEnable  [5][0];
wall_rightEnable_all[6]<=wall_rightEnable  [6][0];
wall_rightEnable_all[7]<=wall_rightEnable  [7][0];
wall_rightEnable_all[8]<=wall_rightEnable  [8][0];
wall_rightEnable_all[9]<=wall_rightEnable  [9][0];
wall_rightEnable_all[10]<=wall_rightEnable[10][0];
wall_rightEnable_all[11]<=wall_rightEnable[11][0];
wall_rightEnable_all[12]<=wall_rightEnable[12][0];
wall_rightEnable_all[13]<=wall_rightEnable[13][0];
wall_rightEnable_all[14]<=wall_rightEnable[14][0];
wall_rightEnable_all[15]<=wall_rightEnable[15][0];
wall_rightEnable_all[16]<=wall_rightEnable[16][0];    
wall_rightEnable_all[17]<=wall_rightEnable[17][0];
wall_rightEnable_all[18]<=wall_rightEnable[18][0];
wall_rightEnable_all[19]<=wall_rightEnable[19][0];
wall_rightEnable_all[20]<=wall_rightEnable[20][0];
wall_rightEnable_all[21]<=wall_rightEnable[21][0];
wall_rightEnable_all[22]<=wall_rightEnable[22][0];
wall_rightEnable_all[23]<=wall_rightEnable[23][0];  

//wall 1 
wall_rightEnable_all_1[0]<=wall_rightEnable  [0][1];
wall_rightEnable_all_1[1]<=wall_rightEnable  [1][1];
wall_rightEnable_all_1[2]<=wall_rightEnable  [2][1];
wall_rightEnable_all_1[3]<=wall_rightEnable  [3][1];
wall_rightEnable_all_1[4]<=wall_rightEnable  [4][1];
wall_rightEnable_all_1[5]<=wall_rightEnable  [5][1];
wall_rightEnable_all_1[6]<=wall_rightEnable  [6][1];
wall_rightEnable_all_1[7]<=wall_rightEnable  [7][1];
wall_rightEnable_all_1[8]<=wall_rightEnable  [8][1];
wall_rightEnable_all_1[9]<=wall_rightEnable  [9][1];
wall_rightEnable_all_1[10]<=wall_rightEnable[10][1];
wall_rightEnable_all_1[11]<=wall_rightEnable[11][1];
wall_rightEnable_all_1[12]<=wall_rightEnable[12][1];
wall_rightEnable_all_1[13]<=wall_rightEnable[13][1];
wall_rightEnable_all_1[14]<=wall_rightEnable[14][1];
wall_rightEnable_all_1[15]<=wall_rightEnable[15][1];
wall_rightEnable_all_1[16]<=wall_rightEnable[16][1];    
wall_rightEnable_all_1[17]<=wall_rightEnable[17][1];
wall_rightEnable_all_1[18]<=wall_rightEnable[18][1];
wall_rightEnable_all_1[19]<=wall_rightEnable[19][1];
wall_rightEnable_all_1[20]<=wall_rightEnable[20][1];
wall_rightEnable_all_1[21]<=wall_rightEnable[21][1];
wall_rightEnable_all_1[22]<=wall_rightEnable[22][1];
wall_rightEnable_all_1[23]<=wall_rightEnable[23][1]; 
//wall 2
wall_rightEnable_all_2[0]<=wall_rightEnable  [0][2]; 
wall_rightEnable_all_2[1]<=wall_rightEnable  [1][2]; 
wall_rightEnable_all_2[2]<=wall_rightEnable  [2][2]; 
wall_rightEnable_all_2[3]<=wall_rightEnable  [3][2]; 
wall_rightEnable_all_2[4]<=wall_rightEnable  [4][2]; 
wall_rightEnable_all_2[5]<=wall_rightEnable  [5][2]; 
wall_rightEnable_all_2[6]<=wall_rightEnable  [6][2]; 
wall_rightEnable_all_2[7]<=wall_rightEnable  [7][2]; 
wall_rightEnable_all_2[8]<=wall_rightEnable  [8][2]; 
wall_rightEnable_all_2[9]<=wall_rightEnable  [9][2]; 
wall_rightEnable_all_2[10]<=wall_rightEnable[10][2]; 
wall_rightEnable_all_2[11]<=wall_rightEnable[11][2]; 
wall_rightEnable_all_2[12]<=wall_rightEnable[12][2]; 
wall_rightEnable_all_2[13]<=wall_rightEnable[13][2]; 
wall_rightEnable_all_2[14]<=wall_rightEnable[14][2]; 
wall_rightEnable_all_2[15]<=wall_rightEnable[15][2]; 
wall_rightEnable_all_2[16]<=wall_rightEnable[16][2]; 
wall_rightEnable_all_2[17]<=wall_rightEnable[17][2]; 
wall_rightEnable_all_2[18]<=wall_rightEnable[18][2]; 
wall_rightEnable_all_2[19]<=wall_rightEnable[19][2]; 
wall_rightEnable_all_2[20]<=wall_rightEnable[20][2]; 
wall_rightEnable_all_2[21]<=wall_rightEnable[21][2]; 
wall_rightEnable_all_2[22]<=wall_rightEnable[22][2]; 
wall_rightEnable_all_2[23]<=wall_rightEnable[23][2]; 
//wall 3
wall_rightEnable_all_3[0]<=wall_rightEnable  [0][3]; 
wall_rightEnable_all_3[1]<=wall_rightEnable  [1][3]; 
wall_rightEnable_all_3[2]<=wall_rightEnable  [2][3]; 
wall_rightEnable_all_3[3]<=wall_rightEnable  [3][3]; 
wall_rightEnable_all_3[4]<=wall_rightEnable  [4][3]; 
wall_rightEnable_all_3[5]<=wall_rightEnable  [5][3]; 
wall_rightEnable_all_3[6]<=wall_rightEnable  [6][3]; 
wall_rightEnable_all_3[7]<=wall_rightEnable  [7][3]; 
wall_rightEnable_all_3[8]<=wall_rightEnable  [8][3]; 
wall_rightEnable_all_3[9]<=wall_rightEnable  [9][3]; 
wall_rightEnable_all_3[10]<=wall_rightEnable[10][3]; 
wall_rightEnable_all_3[11]<=wall_rightEnable[11][3]; 
wall_rightEnable_all_3[12]<=wall_rightEnable[12][3]; 
wall_rightEnable_all_3[13]<=wall_rightEnable[13][3]; 
wall_rightEnable_all_3[14]<=wall_rightEnable[14][3]; 
wall_rightEnable_all_3[15]<=wall_rightEnable[15][3]; 
wall_rightEnable_all_3[16]<=wall_rightEnable[16][3]; 
wall_rightEnable_all_3[17]<=wall_rightEnable[17][3]; 
wall_rightEnable_all_3[18]<=wall_rightEnable[18][3]; 
wall_rightEnable_all_3[19]<=wall_rightEnable[19][3]; 
wall_rightEnable_all_3[20]<=wall_rightEnable[20][3]; 
wall_rightEnable_all_3[21]<=wall_rightEnable[21][3]; 
wall_rightEnable_all_3[22]<=wall_rightEnable[22][3]; 
wall_rightEnable_all_3[23]<=wall_rightEnable[23][3]; 
//wall 4
wall_rightEnable_all_4[0]<=wall_rightEnable  [0][4]; 
wall_rightEnable_all_4[1]<=wall_rightEnable  [1][4]; 
wall_rightEnable_all_4[2]<=wall_rightEnable  [2][4]; 
wall_rightEnable_all_4[3]<=wall_rightEnable  [3][4]; 
wall_rightEnable_all_4[4]<=wall_rightEnable  [4][4]; 
wall_rightEnable_all_4[5]<=wall_rightEnable  [5][4]; 
wall_rightEnable_all_4[6]<=wall_rightEnable  [6][4]; 
wall_rightEnable_all_4[7]<=wall_rightEnable  [7][4]; 
wall_rightEnable_all_4[8]<=wall_rightEnable  [8][4]; 
wall_rightEnable_all_4[9]<=wall_rightEnable  [9][4]; 
wall_rightEnable_all_4[10]<=wall_rightEnable[10][4]; 
wall_rightEnable_all_4[11]<=wall_rightEnable[11][4]; 
wall_rightEnable_all_4[12]<=wall_rightEnable[12][4]; 
wall_rightEnable_all_4[13]<=wall_rightEnable[13][4]; 
wall_rightEnable_all_4[14]<=wall_rightEnable[14][4]; 
wall_rightEnable_all_4[15]<=wall_rightEnable[15][4]; 
wall_rightEnable_all_4[16]<=wall_rightEnable[16][4]; 
wall_rightEnable_all_4[17]<=wall_rightEnable[17][4]; 
wall_rightEnable_all_4[18]<=wall_rightEnable[18][4]; 
wall_rightEnable_all_4[19]<=wall_rightEnable[19][4]; 
wall_rightEnable_all_4[20]<=wall_rightEnable[20][4]; 
wall_rightEnable_all_4[21]<=wall_rightEnable[21][4]; 
wall_rightEnable_all_4[22]<=wall_rightEnable[22][4]; 
wall_rightEnable_all_4[23]<=wall_rightEnable[23][4]; 

//wall 5
wall_rightEnable_all_5[0]<=wall_rightEnable  [0][5]; 
wall_rightEnable_all_5[1]<=wall_rightEnable  [1][5]; 
wall_rightEnable_all_5[2]<=wall_rightEnable  [2][5]; 
wall_rightEnable_all_5[3]<=wall_rightEnable  [3][5]; 
wall_rightEnable_all_5[4]<=wall_rightEnable  [4][5]; 
wall_rightEnable_all_5[5]<=wall_rightEnable  [5][5]; 
wall_rightEnable_all_5[6]<=wall_rightEnable  [6][5]; 
wall_rightEnable_all_5[7]<=wall_rightEnable  [7][5]; 
wall_rightEnable_all_5[8]<=wall_rightEnable  [8][5]; 
wall_rightEnable_all_5[9]<=wall_rightEnable  [9][5]; 
wall_rightEnable_all_5[10]<=wall_rightEnable[10][5]; 
wall_rightEnable_all_5[11]<=wall_rightEnable[11][5]; 
wall_rightEnable_all_5[12]<=wall_rightEnable[12][5]; 
wall_rightEnable_all_5[13]<=wall_rightEnable[13][5]; 
wall_rightEnable_all_5[14]<=wall_rightEnable[14][5]; 
wall_rightEnable_all_5[15]<=wall_rightEnable[15][5]; 
wall_rightEnable_all_5[16]<=wall_rightEnable[16][5]; 
wall_rightEnable_all_5[17]<=wall_rightEnable[17][5]; 
wall_rightEnable_all_5[18]<=wall_rightEnable[18][5]; 
wall_rightEnable_all_5[19]<=wall_rightEnable[19][5]; 
wall_rightEnable_all_5[20]<=wall_rightEnable[20][5]; 
wall_rightEnable_all_5[21]<=wall_rightEnable[21][5]; 
wall_rightEnable_all_5[22]<=wall_rightEnable[22][5]; 
wall_rightEnable_all_5[23]<=wall_rightEnable[23][5];  
//LEFT ENABLE
wall_leftEnable_all[0]<=wall_leftEnable  [0][0];
wall_leftEnable_all[1]<=wall_leftEnable  [1][0];
wall_leftEnable_all[2]<=wall_leftEnable  [2][0];
wall_leftEnable_all[3]<=wall_leftEnable  [3][0];
wall_leftEnable_all[4]<=wall_leftEnable  [4][0];
wall_leftEnable_all[5]<=wall_leftEnable  [5][0];
wall_leftEnable_all[6]<=wall_leftEnable  [6][0];
wall_leftEnable_all[7]<=wall_leftEnable  [7][0];
wall_leftEnable_all[8]<=wall_leftEnable  [8][0];
wall_leftEnable_all[9]<=wall_leftEnable  [9][0];
wall_leftEnable_all[10]<=wall_leftEnable[10][0];
wall_leftEnable_all[11]<=wall_leftEnable[11][0];
wall_leftEnable_all[12]<=wall_leftEnable[12][0];
wall_leftEnable_all[13]<=wall_leftEnable[13][0];
wall_leftEnable_all[14]<=wall_leftEnable[14][0];
wall_leftEnable_all[15]<=wall_leftEnable[15][0];
wall_leftEnable_all[16]<=wall_leftEnable[16][0];    
wall_leftEnable_all[17]<=wall_leftEnable[17][0];
wall_leftEnable_all[18]<=wall_leftEnable[18][0];
wall_leftEnable_all[19]<=wall_leftEnable[19][0];
wall_leftEnable_all[20]<=wall_leftEnable[20][0];
wall_leftEnable_all[21]<=wall_leftEnable[21][0];
wall_leftEnable_all[22]<=wall_leftEnable[22][0];
wall_leftEnable_all[23]<=wall_leftEnable[23][0];  

//wall 1 
wall_leftEnable_all_1[0]<=wall_leftEnable  [0][1];
wall_leftEnable_all_1[1]<=wall_leftEnable  [1][1];
wall_leftEnable_all_1[2]<=wall_leftEnable  [2][1];
wall_leftEnable_all_1[3]<=wall_leftEnable  [3][1];
wall_leftEnable_all_1[4]<=wall_leftEnable  [4][1];
wall_leftEnable_all_1[5]<=wall_leftEnable  [5][1];
wall_leftEnable_all_1[6]<=wall_leftEnable  [6][1];
wall_leftEnable_all_1[7]<=wall_leftEnable  [7][1];
wall_leftEnable_all_1[8]<=wall_leftEnable  [8][1];
wall_leftEnable_all_1[9]<=wall_leftEnable  [9][1];
wall_leftEnable_all_1[10]<=wall_leftEnable[10][1];
wall_leftEnable_all_1[11]<=wall_leftEnable[11][1];
wall_leftEnable_all_1[12]<=wall_leftEnable[12][1];
wall_leftEnable_all_1[13]<=wall_leftEnable[13][1];
wall_leftEnable_all_1[14]<=wall_leftEnable[14][1];
wall_leftEnable_all_1[15]<=wall_leftEnable[15][1];
wall_leftEnable_all_1[16]<=wall_leftEnable[16][1];    
wall_leftEnable_all_1[17]<=wall_leftEnable[17][1];
wall_leftEnable_all_1[18]<=wall_leftEnable[18][1];
wall_leftEnable_all_1[19]<=wall_leftEnable[19][1];
wall_leftEnable_all_1[20]<=wall_leftEnable[20][1];
wall_leftEnable_all_1[21]<=wall_leftEnable[21][1];
wall_leftEnable_all_1[22]<=wall_leftEnable[22][1];
wall_leftEnable_all_1[23]<=wall_leftEnable[23][1]; 
//wall 2
wall_leftEnable_all_2[0]<=wall_leftEnable  [0][2]; 
wall_leftEnable_all_2[1]<=wall_leftEnable  [1][2]; 
wall_leftEnable_all_2[2]<=wall_leftEnable  [2][2]; 
wall_leftEnable_all_2[3]<=wall_leftEnable  [3][2]; 
wall_leftEnable_all_2[4]<=wall_leftEnable  [4][2]; 
wall_leftEnable_all_2[5]<=wall_leftEnable  [5][2]; 
wall_leftEnable_all_2[6]<=wall_leftEnable  [6][2]; 
wall_leftEnable_all_2[7]<=wall_leftEnable  [7][2]; 
wall_leftEnable_all_2[8]<=wall_leftEnable  [8][2]; 
wall_leftEnable_all_2[9]<=wall_leftEnable  [9][2]; 
wall_leftEnable_all_2[10]<=wall_leftEnable[10][2]; 
wall_leftEnable_all_2[11]<=wall_leftEnable[11][2]; 
wall_leftEnable_all_2[12]<=wall_leftEnable[12][2]; 
wall_leftEnable_all_2[13]<=wall_leftEnable[13][2]; 
wall_leftEnable_all_2[14]<=wall_leftEnable[14][2]; 
wall_leftEnable_all_2[15]<=wall_leftEnable[15][2]; 
wall_leftEnable_all_2[16]<=wall_leftEnable[16][2]; 
wall_leftEnable_all_2[17]<=wall_leftEnable[17][2]; 
wall_leftEnable_all_2[18]<=wall_leftEnable[18][2]; 
wall_leftEnable_all_2[19]<=wall_leftEnable[19][2]; 
wall_leftEnable_all_2[20]<=wall_leftEnable[20][2]; 
wall_leftEnable_all_2[21]<=wall_leftEnable[21][2]; 
wall_leftEnable_all_2[22]<=wall_leftEnable[22][2]; 
wall_leftEnable_all_2[23]<=wall_leftEnable[23][2]; 
//wall 3
wall_leftEnable_all_3[0]<=wall_leftEnable  [0][3]; 
wall_leftEnable_all_3[1]<=wall_leftEnable  [1][3]; 
wall_leftEnable_all_3[2]<=wall_leftEnable  [2][3]; 
wall_leftEnable_all_3[3]<=wall_leftEnable  [3][3]; 
wall_leftEnable_all_3[4]<=wall_leftEnable  [4][3]; 
wall_leftEnable_all_3[5]<=wall_leftEnable  [5][3]; 
wall_leftEnable_all_3[6]<=wall_leftEnable  [6][3]; 
wall_leftEnable_all_3[7]<=wall_leftEnable  [7][3]; 
wall_leftEnable_all_3[8]<=wall_leftEnable  [8][3]; 
wall_leftEnable_all_3[9]<=wall_leftEnable  [9][3]; 
wall_leftEnable_all_3[10]<=wall_leftEnable[10][3]; 
wall_leftEnable_all_3[11]<=wall_leftEnable[11][3]; 
wall_leftEnable_all_3[12]<=wall_leftEnable[12][3]; 
wall_leftEnable_all_3[13]<=wall_leftEnable[13][3]; 
wall_leftEnable_all_3[14]<=wall_leftEnable[14][3]; 
wall_leftEnable_all_3[15]<=wall_leftEnable[15][3]; 
wall_leftEnable_all_3[16]<=wall_leftEnable[16][3]; 
wall_leftEnable_all_3[17]<=wall_leftEnable[17][3]; 
wall_leftEnable_all_3[18]<=wall_leftEnable[18][3]; 
wall_leftEnable_all_3[19]<=wall_leftEnable[19][3]; 
wall_leftEnable_all_3[20]<=wall_leftEnable[20][3]; 
wall_leftEnable_all_3[21]<=wall_leftEnable[21][3]; 
wall_leftEnable_all_3[22]<=wall_leftEnable[22][3]; 
wall_leftEnable_all_3[23]<=wall_leftEnable[23][3]; 
//wall 4
wall_leftEnable_all_4[0]<=wall_leftEnable  [0][4]; 
wall_leftEnable_all_4[1]<=wall_leftEnable  [1][4]; 
wall_leftEnable_all_4[2]<=wall_leftEnable  [2][4]; 
wall_leftEnable_all_4[3]<=wall_leftEnable  [3][4]; 
wall_leftEnable_all_4[4]<=wall_leftEnable  [4][4]; 
wall_leftEnable_all_4[5]<=wall_leftEnable  [5][4]; 
wall_leftEnable_all_4[6]<=wall_leftEnable  [6][4]; 
wall_leftEnable_all_4[7]<=wall_leftEnable  [7][4]; 
wall_leftEnable_all_4[8]<=wall_leftEnable  [8][4]; 
wall_leftEnable_all_4[9]<=wall_leftEnable  [9][4]; 
wall_leftEnable_all_4[10]<=wall_leftEnable[10][4]; 
wall_leftEnable_all_4[11]<=wall_leftEnable[11][4]; 
wall_leftEnable_all_4[12]<=wall_leftEnable[12][4]; 
wall_leftEnable_all_4[13]<=wall_leftEnable[13][4]; 
wall_leftEnable_all_4[14]<=wall_leftEnable[14][4]; 
wall_leftEnable_all_4[15]<=wall_leftEnable[15][4]; 
wall_leftEnable_all_4[16]<=wall_leftEnable[16][4]; 
wall_leftEnable_all_4[17]<=wall_leftEnable[17][4]; 
wall_leftEnable_all_4[18]<=wall_leftEnable[18][4]; 
wall_leftEnable_all_4[19]<=wall_leftEnable[19][4]; 
wall_leftEnable_all_4[20]<=wall_leftEnable[20][4]; 
wall_leftEnable_all_4[21]<=wall_leftEnable[21][4]; 
wall_leftEnable_all_4[22]<=wall_leftEnable[22][4]; 
wall_leftEnable_all_4[23]<=wall_leftEnable[23][4]; 

//wall 5
wall_leftEnable_all_5[0]<=wall_leftEnable  [0][5]; 
wall_leftEnable_all_5[1]<=wall_leftEnable  [1][5]; 
wall_leftEnable_all_5[2]<=wall_leftEnable  [2][5]; 
wall_leftEnable_all_5[3]<=wall_leftEnable  [3][5]; 
wall_leftEnable_all_5[4]<=wall_leftEnable  [4][5]; 
wall_leftEnable_all_5[5]<=wall_leftEnable  [5][5]; 
wall_leftEnable_all_5[6]<=wall_leftEnable  [6][5]; 
wall_leftEnable_all_5[7]<=wall_leftEnable  [7][5]; 
wall_leftEnable_all_5[8]<=wall_leftEnable  [8][5]; 
wall_leftEnable_all_5[9]<=wall_leftEnable  [9][5]; 
wall_leftEnable_all_5[10]<=wall_leftEnable[10][5]; 
wall_leftEnable_all_5[11]<=wall_leftEnable[11][5]; 
wall_leftEnable_all_5[12]<=wall_leftEnable[12][5]; 
wall_leftEnable_all_5[13]<=wall_leftEnable[13][5]; 
wall_leftEnable_all_5[14]<=wall_leftEnable[14][5]; 
wall_leftEnable_all_5[15]<=wall_leftEnable[15][5]; 
wall_leftEnable_all_5[16]<=wall_leftEnable[16][5]; 
wall_leftEnable_all_5[17]<=wall_leftEnable[17][5]; 
wall_leftEnable_all_5[18]<=wall_leftEnable[18][5]; 
wall_leftEnable_all_5[19]<=wall_leftEnable[19][5]; 
wall_leftEnable_all_5[20]<=wall_leftEnable[20][5]; 
wall_leftEnable_all_5[21]<=wall_leftEnable[21][5]; 
wall_leftEnable_all_5[22]<=wall_leftEnable[22][5]; 
wall_leftEnable_all_5[23]<=wall_leftEnable[23][5];  

//OR ALL WALL ENABLES
wall_upEnable_all_OR<=wall_upEnable_all||wall_upEnable_all_1||wall_upEnable_all_2||wall_upEnable_all_3||wall_upEnable_all_4||wall_upEnable_all_5;
wall_downEnable_all_OR<=wall_downEnable_all||wall_downEnable_all_1||wall_downEnable_all_2||wall_downEnable_all_3||wall_downEnable_all_4||wall_downEnable_all_5;
wall_leftEnable_all_OR<=wall_leftEnable_all||wall_leftEnable_all_1||wall_leftEnable_all_2||wall_leftEnable_all_3||wall_leftEnable_all_4||wall_leftEnable_all_5;
wall_rightEnable_all_OR<=wall_rightEnable_all||wall_rightEnable_all_1||wall_rightEnable_all_2||wall_rightEnable_all_3||wall_rightEnable_all_4||wall_rightEnable_all_5;

//enable/disable down    
    if(downEnable_all == 24'h0&&wall_downEnable_all_OR == 24'h0)        downEnable_o <= 1;
    else        downEnable_o <= 0;
//enable/disable up    
    if(upEnable_all == 24'h0&&wall_upEnable_all_OR == 24'h0)      upEnable_o <= 1;
    else      upEnable_o <= 0;
//enable/disable down    
    if(leftEnable_all == 24'h0&&wall_leftEnable_all_OR == 24'h0)        leftEnable_o <= 1;
    else        leftEnable_o <= 0;
//enable/disable up    
    if(rightEnable_all == 24'h0&&wall_rightEnable_all_OR == 24'h0)      rightEnable_o <= 1;
    else      rightEnable_o <= 0;
    
end
endmodule

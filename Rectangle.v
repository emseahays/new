`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2016 07:48:07 PM
// Design Name: 
// Module Name: Rectangle
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


module Rectangle(
    input [3:0] player_color,
    input [3:0] rect_color,
    input passable,
    input [31:0] player_hPos,
    input [31:0] player_vPos,
    input rst,
    input btnClk,
    input [3:0] btns,
    input  [31:0] vStartPos,
    input  [31:0] hStartPos,
    input  [31:0] objWidth,
    input  [31:0] objHeight,
    output  [31:0] vStartPos_o,
    output  [31:0] hStartPos_o,
    output  [31:0] objWidth_o,
    output  [31:0] objHeight_o,
    output reg [31:0] vOffset,
    output reg [31:0] hOffset,
    output [3:0] rect_color_o,
    output reg upEnable,
    output reg downEnable,
    output  leftEnable,
    output  rightEnable
);


assign rect_color_o = rect_color; 

assign vStartPos_o=vStartPos;
assign hStartPos_o=hStartPos;
assign objWidth_o=objWidth;
assign objHeight_o=objHeight;

//update objects location

always@(posedge btnClk, posedge rst) begin

    if(rst==1)
    begin
        vOffset<=0;
        hOffset<=0;
    end
    else begin
    case(btns)
    8: //btnU
        begin 
            if(vOffset+vStartPos>0) vOffset<=vOffset-1;
            else vOffset<=480-objHeight-vStartPos;
        end
    4://btnD
        begin
            if(!(vOffset+vStartPos>=480)) vOffset<=vOffset+1;
            else vOffset<=0-vStartPos;
        end
    2://btnR
        begin 
            if(!(hStartPos>=640-objWidth-hOffset)) hOffset<=hOffset+1;
            else  hOffset<=0-hStartPos;
        end
    1://btnL
        begin 
            if(hStartPos+hOffset>0)  hOffset<=hOffset-1;
            else hOffset<=640-objWidth-hStartPos;
        end
    default: //else do nothing
        begin 
        
        end
        
    endcase   
        
    // DOWN ENABLE/DISABLE
    if((player_hPos>=hStartPos+hOffset&&player_hPos+12<=hStartPos+hOffset+128)    // player is between left and right edges of this rectangle
    &&  (player_vPos+12==vStartPos+vOffset)                                      //player is on top border of rectangle 
    && (rect_color!=player_color) )                                             //not color match 
    begin
        downEnable <= 1'b0; //disable downButton
    end 
    else if(((player_hPos<hStartPos+hOffset&&player_hPos+12>hStartPos+hOffset)        //player is on left edge of rectangle
    ||(player_hPos<hStartPos+hOffset+128&&player_hPos+12>hStartPos+hOffset+128))      // is on right edge of rectangle
        &&  (player_vPos+12==vStartPos+vOffset)                                      //player is on top border of rectangle 
         )                                                  
    begin
        downEnable <= 1'b0; //disable downButton
    end
    else
    begin  
        downEnable <= 1'b1;  //enable downButton
    end
    
     //UP ENABLE/DISABLE
    if((player_hPos>=hStartPos+hOffset&&player_hPos+12<=hStartPos+hOffset+128)      // player is between left and right edges of this rectangle
    && (player_vPos==vStartPos+vOffset+12)                                          //player is on bottom border of rectangle       
    && (rect_color!=player_color) )                                                  //not color match 
    begin
        upEnable <= 1'b0; //disable upButton
    end
    else if(((player_hPos<hStartPos+hOffset&&player_hPos+12>hStartPos+hOffset)        //player is on left edge of rectangle
    ||(player_hPos<hStartPos+hOffset+128&&player_hPos+12>hStartPos+hOffset+128))      // is on right edge of rectangle
        && (player_vPos==vStartPos+vOffset+12)                                         //player is on bottom border of rectangle  
         )                                                 
    begin
        upEnable <= 1'b0; //disable upButton
    end    
    else 
    begin 
        upEnable <= 1'b1;  //enable upButton      
    end
end
end

endmodule

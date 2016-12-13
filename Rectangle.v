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
    input  visible, 
input [3:0] player_color,
input [3:0] rect_color,
input passable,
input [9:0] player_hPos,
input [9:0] player_vPos,
input rst,
input btnClk,
input [3:0] btns,
input  [9:0] vStartPos,
input  [9:0] hStartPos,
input  [9:0] objWidth,
input  [9:0] objHeight,
output  [9:0] vStartPos_o,
output  [9:0] hStartPos_o,
output  [9:0] objWidth_o,
output  [9:0] objHeight_o,
output reg [31:0] vOffset,
output reg [31:0] hOffset,
output [3:0] rect_color_o,
output reg upEnable,
output reg downEnable,
output  reg leftEnable,
output  reg rightEnable,
output visible_o
);

parameter pWidth=12;
parameter pHeight=12;

assign rect_color_o = rect_color; 

assign vStartPos_o=vStartPos;
assign hStartPos_o=hStartPos;
assign objWidth_o=objWidth;
assign objHeight_o=objHeight;
assign visible_o=visible;

//update objects location


always@(posedge btnClk, posedge rst) begin

    if(rst==1)
    begin
        vOffset<=0;
        hOffset<=0;
    
    
        upEnable<=0;
        downEnable<=0;
        leftEnable<=0;
        rightEnable<=0;
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

//NOT PASSABLE CONTROL DISABLE
        if(visible==1)begin 
//                if(passable==0)begin      
                // DOWN DISABLE
                    if((player_hPos>=hStartPos+hOffset&&player_hPos+pWidth<=hStartPos+hOffset+objWidth)    // player is between left and right edges of this rectangle
                    &&  (player_vPos+pHeight==vStartPos+vOffset)                                      //player is on top border of rectangle 
                    && (rect_color!=player_color) )                                             //not color match 
                    begin
                        if(passable==0)downEnable <= 1'b1; //disable downButton
                    end 
                    else if(((player_hPos<hStartPos+hOffset&&player_hPos+pWidth>hStartPos+hOffset)        //player is on left edge of rectangle
                    ||(player_hPos<hStartPos+hOffset+objWidth&&player_hPos+pWidth>hStartPos+hOffset+objWidth))      // is on right edge of rectangle
                        &&  (player_vPos+pHeight==vStartPos+vOffset)                                      //player is on top border of rectangle 
                         )                                                  
                    begin
                        if(passable==0)downEnable <= 1'b1; //disable downButton
                    end
                    else
                    begin  
                        downEnable <= 1'b0;  //enable downButton
                    end
                     //UP DISABLE
                    if((player_hPos>=hStartPos+hOffset&&player_hPos+pHeight<=hStartPos+hOffset+objWidth)      // player is between left and right edges of this rectangle
                    && (player_vPos==vStartPos+vOffset+objHeight)                                          //player is on bottom border of rectangle       
                    && (rect_color!=player_color) )                                                  //not color match 
                    begin
                        if(passable==0)upEnable <= 1'b1; //disable upButton
                    end
                    else if(((player_hPos<hStartPos+hOffset&&player_hPos+pWidth>hStartPos+hOffset)        //player is on left edge of rectangle
                    ||(player_hPos<hStartPos+hOffset+objWidth&&player_hPos+pWidth>hStartPos+hOffset+objWidth))      // is on right edge of rectangle
                        && (player_vPos==vStartPos+vOffset+objHeight)                                         //player is on bottom border of rectangle  
                         )                                                 
                    begin
                        if(passable==0)upEnable <= 1'b1; //disable upButton
                    end    
                    else 
                    begin 
                        upEnable <= 1'b0;  //enable upButton      
                    end
                    //Left Disable
                    if((player_hPos==hStartPos+objWidth)            //player left edge is on rectangles right edge
                    &&(player_vPos>=vStartPos+vOffset)             //player top edge is not above rectangle top edge
                    &&(player_vPos+pHeight<=vStartPos+vOffset+objHeight)           //player bottom edge is not below rectangle top edge
                    &&(rect_color!=player_color)                             //disable only if colors dont match
                    ) 
                    begin 
                        if(passable==0)leftEnable<=1'b1;
                    end
                    else leftEnable<=1'b0;
                        //right Disable
                    if((player_hPos+pWidth==hStartPos)                    //player right edge is on rectangles left edge
                    &&(player_vPos>=vStartPos+vOffset)                      //player top edge is not above rectangle top edge
                    &&(player_vPos+pWidth<=vStartPos+vOffset+objHeight)           //player bottom edge is not below rectangle top edge
                    &&(rect_color!=player_color)                             //disable only if colors dont match
                    ) 
                    begin 
                        if(passable==0)rightEnable<=1'b1;
                    end
                    else rightEnable<=1'b0;
 //               end
            
        //IF PASSABLE
 //               else begin   
                     // LEFT/RIGHT ENABLE/DISABLE -- "if inside a scroll"
                    if((player_hPos>=hStartPos+hOffset&&player_hPos+pHeight<=hStartPos+hOffset+objWidth)      // player is between left and right edges of this rectangle
                    && ((player_vPos == vStartPos + vOffset)&&(player_vPos+pHeight==vStartPos+objHeight))       // top and bottom edges are the same as this rectangle                                    
                    )
                    begin
                       if((rect_color != player_color)) begin
                       // Disable Controls
                           if(passable==0)downEnable <= 1'b1;
                           if(passable==0)upEnable <= 1'b1;
                           if(passable==0)leftEnable <= 1'b1;
                           if(passable==0)rightEnable <= 1'b1; 
                       end
                       else begin
                           downEnable <= 1'b0;
                           upEnable <= 1'b0;
                           leftEnable <= 1'b0;
                           rightEnable <= 1'b0; 
                       end
                    end 
                end
//        end
    end
end


endmodule

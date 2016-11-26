`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2016 12:26:40 AM
// Design Name: 
// Module Name: CompareDisp
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


module CompareDisp(    	
    input [31:0] hCount,
input [31:0] vCount,
input [3:0] btns,
input rst,    
input clk,
//input btnClk,
input  [31:0] vStartPos [3:0][5:0],
input  [31:0] hStartPos [3:0][5:0],
input  [31:0] objWidth [3:0][5:0],
input  [31:0] objHeight [3:0][5:0],
input [31:0] vOffset [3:0][5:0],
input [31:0] hOffset [3:0][5:0],
//stuff for player obj
input  [31:0] player_vStartPos ,
input  [31:0] player_hStartPos ,
input  [31:0] player_objWidth ,
input  [31:0] player_objHeight ,
input  [31:0] player_vOffset ,
input  [31:0] player_hOffset ,


input [3:0] player_color,

output reg [2:0] Sel
);

//Offsets (from VGA border)
parameter h=144;
parameter v=35;

//Display
always@( hCount, vCount) 
begin
    
    //code to make sure in display range
    if( (hCount<h||hCount>784)  ||  (vCount<v||vCount>515) ) 
    begin
        Sel<=0; //outside of display range, so dont display anything
    end
    //CODE FOR BORDERS
    else if((hCount>=h&&hCount<=h+objWidth[0][0]||hCount<=784&&hCount>=784-objWidth[0][0])||(vCount>=v&&vCount<=v+objHeight[0][0]||vCount<=515&&vCount>=515-objHeight[0][0]))
    begin 
        Sel<=6;
    end
    //CODE FOR WALLS - WORLD 1
    //game display region
    else if((hCount>=h&&hCount<=h+objWidth[0][0]||hCount<=784&&hCount>=784-objWidth[0][0])||(vCount>=v&&vCount<=v+objHeight[0][0]||vCount<=515&&vCount>=515-objHeight[0][0]))
    begin 
        Sel<=6;
    end
    //playerObj player_
    else if(hCount<=player_hStartPos+h+player_hOffset+player_objWidth&&hCount>=player_hStartPos+h+player_hOffset&&vCount<=player_vStartPos+v+player_vOffset+player_objHeight&&vCount>=player_vStartPos+v+player_vOffset)
     begin
        Sel<=player_color; //wild
    end 
//SCROLL 0
            //object 1 
    else if(hCount<=hStartPos[0][0]+h+hOffset[0][0]+objWidth[0][0]&&hCount>=hStartPos[0][0]+h+hOffset[0][0]&&vCount<=vStartPos[0][0]+v+vOffset[0][0]+objHeight[0][0]&&vCount>=vStartPos[0][0]+v+vOffset[0][0])
     begin
        Sel<=2; //red
    end 
    //object 2
    else if(hCount<=hStartPos[1][0]+h+hOffset[1][0]+objWidth[1][0]&&hCount>=hStartPos[1][0]+h+hOffset[1][0]&&vCount<=vStartPos[1][0]+v+vOffset[1][0]+objHeight[1][0]&&vCount>=vStartPos[1][0]+v+vOffset[1][0])
        begin
            Sel<=3; //cyan
        end 
//        //object 3
    else if(hCount<=hStartPos[2][0]+h+hOffset[2][0]+objWidth[2][0]&&hCount>=hStartPos[2][0]+h+hOffset[2][0]&&vCount<=vStartPos[2][0]+v+vOffset[2][0]+objHeight[2][0]&&vCount>=vStartPos[2][0]+v+vOffset[2][0])
        begin
            Sel<=4; //yellow
        end 
//        //object 4
    else if(hCount<=hStartPos[3][0]+h+hOffset[3][0]+objWidth[3][0]&&hCount>=hStartPos[3][0]+h+hOffset[3][0]&&vCount<=vStartPos[3][0]+v+vOffset[3][0]+objHeight[3][0]&&vCount>=vStartPos[3][0]+v+vOffset[3][0])
        begin
            Sel<=5; //magenta
        end 






//SCROLL1
    else if(hCount<=hStartPos[0][1]+h+hOffset[0][1]+objWidth[0][1]&&hCount>=hStartPos[0][1]+h+hOffset[0][1]&&vCount<=vStartPos[0][1]+v+vOffset[0][1]+objHeight[0][1]&&vCount>=vStartPos[0][1]+v+vOffset[0][1])
     begin
        Sel<=2; //red
    end 
    //object 2
    else if(hCount<=hStartPos[1][1]+h+hOffset[1][1]+objWidth[1][1]&&hCount>=hStartPos[1][1]+h+hOffset[1][1]&&vCount<=vStartPos[1][1]+v+vOffset[1][1]+objHeight[1][1]&&vCount>=vStartPos[1][1]+v+vOffset[1][1])
        begin
            Sel<=3; //cyan
        end 
//        //object 3
    else if(hCount<=hStartPos[2][1]+h+hOffset[2][1]+objWidth[2][1]&&hCount>=hStartPos[2][1]+h+hOffset[2][1]&&vCount<=vStartPos[2][1]+v+vOffset[2][1]+objHeight[2][1]&&vCount>=vStartPos[2][1]+v+vOffset[2][1])
        begin
            Sel<=4; //yellow
        end 
//        //object 4
    else if(hCount<=hStartPos[3][1]+h+hOffset[3][1]+objWidth[3][1]&&hCount>=hStartPos[3][1]+h+hOffset[3][1]&&vCount<=vStartPos[3][1]+v+vOffset[3][1]+objHeight[3][1]&&vCount>=vStartPos[3][1]+v+vOffset[3][1])
        begin
            Sel<=5; //magenta
        end 






//SCROLL 2
    else if(hCount<=hStartPos[0][2]+h+hOffset[0][2]+objWidth[0][2]&&hCount>=hStartPos[0][2]+h+hOffset[0][2]&&vCount<=vStartPos[0][2]+v+vOffset[0][2]+objHeight[0][2]&&vCount>=vStartPos[0][2]+v+vOffset[0][2])
     begin
        Sel<=2; //red
    end 
    //object 2
    else if(hCount<=hStartPos[1][2]+h+hOffset[1][2]+objWidth[1][2]&&hCount>=hStartPos[1][2]+h+hOffset[1][2]&&vCount<=vStartPos[1][2]+v+vOffset[1][2]+objHeight[1][2]&&vCount>=vStartPos[1][2]+v+vOffset[1][2])
        begin
            Sel<=3; //cyan
        end 
//        //object 3
    else if(hCount<=hStartPos[2][2]+h+hOffset[2][2]+objWidth[2][2]&&hCount>=hStartPos[2][2]+h+hOffset[2][2]&&vCount<=vStartPos[2][2]+v+vOffset[2][2]+objHeight[2][2]&&vCount>=vStartPos[2][2]+v+vOffset[2][2])
        begin
            Sel<=4; //yellow
        end 
//        //object 4
    else if(hCount<=hStartPos[3][2]+h+hOffset[3][2]+objWidth[3][2]&&hCount>=hStartPos[3][2]+h+hOffset[3][2]&&vCount<=vStartPos[3][2]+v+vOffset[3][2]+objHeight[3][2]&&vCount>=vStartPos[3][2]+v+vOffset[3][2])
        begin
            Sel<=5; //magenta
        end 

// SCROLL 3
    else if(hCount<=hStartPos[0][3]+h+hOffset[0][3]+objWidth[0][3]&&hCount>=hStartPos[0][3]+h+hOffset[0][3]&&vCount<=vStartPos[0][3]+v+vOffset[0][3]+objHeight[0][3]&&vCount>=vStartPos[0][3]+v+vOffset[0][3])
     begin
        Sel<=2; //red
    end 
    //object 2
    else if(hCount<=hStartPos[1][3]+h+hOffset[1][3]+objWidth[1][3]&&hCount>=hStartPos[1][3]+h+hOffset[1][3]&&vCount<=vStartPos[1][3]+v+vOffset[1][3]+objHeight[1][3]&&vCount>=vStartPos[1][3]+v+vOffset[1][3])
        begin
            Sel<=3; //cyan
        end 
//        //object 3
    else if(hCount<=hStartPos[2][3]+h+hOffset[2][3]+objWidth[2][3]&&hCount>=hStartPos[2][3]+h+hOffset[2][3]&&vCount<=vStartPos[2][3]+v+vOffset[2][3]+objHeight[2][3]&&vCount>=vStartPos[2][3]+v+vOffset[2][3])
        begin
            Sel<=4; //yellow
        end 
//        //object 4
    else if(hCount<=hStartPos[3][3]+h+hOffset[3][3]+objWidth[3][3]&&hCount>=hStartPos[3][3]+h+hOffset[3][3]&&vCount<=vStartPos[3][3]+v+vOffset[3][3]+objHeight[3][3]&&vCount>=vStartPos[3][3]+v+vOffset[3][3])
        begin
            Sel<=5; //magenta
        end 
        
// SCROLL 4
                else if(hCount<=hStartPos[0][4]+h+hOffset[0][4]+objWidth[0][4]&&hCount>=hStartPos[0][4]+h+hOffset[0][4]&&vCount<=vStartPos[0][4]+v+vOffset[0][4]+objHeight[0][4]&&vCount>=vStartPos[0][4]+v+vOffset[0][4])
                 begin
                    Sel<=2; //red
                end 
                //object 2
                else if(hCount<=hStartPos[1][4]+h+hOffset[1][4]+objWidth[1][4]&&hCount>=hStartPos[1][4]+h+hOffset[1][4]&&vCount<=vStartPos[1][4]+v+vOffset[1][4]+objHeight[1][4]&&vCount>=vStartPos[1][4]+v+vOffset[1][4])
                    begin
                        Sel<=3; //cyan
                    end 
        //        //object 3
                else if(hCount<=hStartPos[2][4]+h+hOffset[2][4]+objWidth[2][4]&&hCount>=hStartPos[2][4]+h+hOffset[2][4]&&vCount<=vStartPos[2][4]+v+vOffset[2][4]+objHeight[2][4]&&vCount>=vStartPos[2][4]+v+vOffset[2][4])
                    begin
                        Sel<=4; //yellow
                    end 
        //        //object 4
                else if(hCount<=hStartPos[3][4]+h+hOffset[3][4]+objWidth[3][4]&&hCount>=hStartPos[3][4]+h+hOffset[3][4]&&vCount<=vStartPos[3][4]+v+vOffset[3][4]+objHeight[3][4]&&vCount>=vStartPos[3][4]+v+vOffset[3][4])
                    begin
                        Sel<=5; //magenta
                    end 
// SCROLL 5
                else if(hCount<=hStartPos[0][5]+h+hOffset[0][5]+objWidth[0][5]&&hCount>=hStartPos[0][5]+h+hOffset[0][5]&&vCount<=vStartPos[0][5]+v+vOffset[0][5]+objHeight[0][5]&&vCount>=vStartPos[0][5]+v+vOffset[0][5])
                 begin
                    Sel<=2; //red
                end 
                //object 2
                else if(hCount<=hStartPos[1][5]+h+hOffset[1][5]+objWidth[1][5]&&hCount>=hStartPos[1][5]+h+hOffset[1][5]&&vCount<=vStartPos[1][5]+v+vOffset[1][5]+objHeight[1][5]&&vCount>=vStartPos[1][5]+v+vOffset[1][5])
                    begin
                        Sel<=3; //cyan
                    end 
        //        //object 3
                else if(hCount<=hStartPos[2][5]+h+hOffset[2][5]+objWidth[2][5]&&hCount>=hStartPos[2][5]+h+hOffset[2][5]&&vCount<=vStartPos[2][5]+v+vOffset[2][5]+objHeight[2][5]&&vCount>=vStartPos[2][5]+v+vOffset[2][5])
                    begin
                        Sel<=4; //yellow
                    end 
        //        //object 4
                else if(hCount<=hStartPos[3][5]+h+hOffset[3][5]+objWidth[3][5]&&hCount>=hStartPos[3][5]+h+hOffset[3][5]&&vCount<=vStartPos[3][5]+v+vOffset[3][5]+objHeight[3][5]&&vCount>=vStartPos[3][5]+v+vOffset[3][5])
                    begin
                        Sel<=5; //magenta
                    end 
// SCROLL 6
                else if(hCount<=hStartPos[0][6]+h+hOffset[0][6]+objWidth[0][6]&&hCount>=hStartPos[0][6]+h+hOffset[0][6]&&vCount<=vStartPos[0][6]+v+vOffset[0][6]+objHeight[0][6]&&vCount>=vStartPos[0][6]+v+vOffset[0][6])
                 begin                                                                                                                                       
                    Sel<=2; //red                                                                                                                            
                end                                                                                                                                          
                //object 2                                                                                                                                   
                else if(hCount<=hStartPos[1][6]+h+hOffset[1][6]+objWidth[1][6]&&hCount>=hStartPos[1][6]+h+hOffset[1][6]&&vCount<=vStartPos[1][6]+v+vOffset[1][6]+objHeight[1][6]&&vCount>=vStartPos[1][6]+v+vOffset[1][6])
                    begin                                                                                                                                     
                        Sel<=3; //cyan                                                                                                                        
                    end                                                                                                                                       
        //        //object 3                                                                                                                                  
                else if(hCount<=hStartPos[2][6]+h+hOffset[2][6]+objWidth[2][6]&&hCount>=hStartPos[2][6]+h+hOffset[2][6]&&vCount<=vStartPos[2][6]+v+vOffset[2][6]+objHeight[2][6]&&vCount>=vStartPos[2][6]+v+vOffset[2][6])
                    begin                                                                                                                                     
                        Sel<=4; //yellow                                                                                                                      
                    end                                                                                                                                       
        //        //object 4                                                                                                                                  
                else if(hCount<=hStartPos[3][6]+h+hOffset[3][6]+objWidth[3][6]&&hCount>=hStartPos[3][6]+h+hOffset[3][6]&&vCount<=vStartPos[3][6]+v+vOffset[3][6]+objHeight[3][6]&&vCount>=vStartPos[3][6]+v+vOffset[3][6])
                    begin
                        Sel<=5; //magenta
                    end 

   else
    begin
        Sel<=0;
    end
    
end
endmodule

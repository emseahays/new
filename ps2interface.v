`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2016 10:30:01 PM
// Design Name: 
// Module Name: ps2interface
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


module ps2interface(
input clk,
input PS2_CLK,
input PS2_DATA,
input rst,
output reg [3:0] buttons_out
);
 
 reg [7:0] data;
 reg [3:0] bitCount;
 reg [31:0] cantGet;
 reg [7:0] key_code;
 
 reg [3:0] btns;
 
     // State Variables
    reg [1:0] currentState;
    reg [1:0] nextState;
    
    parameter   waitState   = 0;
    parameter   buttonPress = 1;
    parameter   buttonHold  = 2;
                
    // 
    reg [3:0] buttons_temp;
    
//=============================================================
//FINITE STATE MACHINE
//=============================================================
     //State Register
     always @(posedge clk, posedge rst) begin
         if(rst) currentState <= waitState;
         else currentState <=  nextState;
     end
    //State Logic
     always @ (*) begin
           nextState <=  currentState;
           case(currentState) 
               waitState: begin
                   if(btns != 4'd0) begin             // If button is pressed go to next state
                       nextState <= buttonPress;
                   end
               end
               buttonPress: begin
                   buttons_out <= btns;             // Output last saved button input until time is up.
                   nextState <=  buttonHold;
               end
               buttonHold: begin
                   buttons_out <= 4'd0;               // Return output to 0 after 1 clk cycle 
                   if(btns==4'd0) begin                 // When there are no button presses, return to wait state
                       nextState <= waitState;
                   end
                   else nextState<=buttonHold;
                                                 
               end            
           endcase
       end
 
 
     //Datapath
     
     // This block waits for keyboard data input
     // key_code represents the 8-bit encoded value of keyboard button press
     always @(negedge PS2_CLK, posedge rst)
     begin
        if (rst == 1) begin
            data <= 0;
            bitCount <= 0;
            key_code <= 0;
            cantGet<=0;
        end
        else begin
            bitCount <= bitCount + 1;
            if (bitCount >= 1 && bitCount <= 8)
                data[bitCount-1] <= PS2_DATA; // Look at structure of PS2 keyboard protocol, ignore start bit, parity, stop bit, ...
            if (bitCount == 10) begin     
                bitCount <= 0;  // When we are at the stop bit of the key press, reset and store the key_code data
                   if(!(key_code==8'hF0))        
                        key_code<=data;                  
                   else key_code<=8'h00;
            end 
    
        end
     end
     
     always@(key_code)
     begin
     //DECODER
     case(key_code)
     8'h1D: //w - up
     begin         
         btns<=4'b1000;

     end
     8'h1C: //a - left
     begin 
          btns<=4'b0001;
          
     end
     8'h1B: //s - down
     begin 
        btns<=4'b0100;
        
     end
     8'h23: //d - right
     begin 
         btns<=4'b0010;
         
     end
     8'h00: //zero
     begin 
         btns<=4'h0;
     end
     default: 
     begin 
         btns<=4'h0;
     end
    endcase
     end
    
endmodule

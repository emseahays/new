`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2016 12:02:51 AM
// Design Name: 
// Module Name: audioSequence
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


module audioSequence(
    input clk,
    input reset,
    input enable,
    input [2:0] audioSelect,
    output reg [3:0] noteSelect,
    output reg seqEnd
    );
    
    // 0000 = A
    // 0001 = B
    // 0010 = C
    // 0011 = D
    // 0100 = E
    // 0101 = F
    // 0110 = G
    // 0111 = rest
    // 1000 = end Sequence
    
    reg[31:0] song;
    
    reg [31:0] play             = 4'b1000;                          //0,1
    reg [31:0] levelInc         = 12'b100000100001;         // 2
    reg [31:0] worldInc         = 20'b10000101001000110011;         // 3
    reg [31:0] lifeDecr         = 8'b10000011;                 // 4
    reg [31:0] win_display      = 28'b1000011001010110010101000010; // 5
    reg [31:0] lose_display     = 24'b100000100011011001010110;     // 6
    
    reg [3:0] note;
    reg [5:0] index;
    reg [5:0] indexTemp;
    
    parameter  A = 0;
    parameter  B = 1;
    parameter  C = 2;
    parameter  D = 3;
    parameter  E = 4;
    parameter  F = 5;
    parameter  G = 6;
    parameter  mute = 7;
    parameter  endSeqence = 8;
    
    
    // States
    parameter initialState = 0;
    parameter loadNoteState = 1;
    parameter playNoteState = 2;
    parameter incrementState = 3;
    
    reg [2:0] currentState;
    reg [2:0] nextState;
    
    reg timerEnable;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            currentState <= initialState;
        end 
        else begin
            currentState <= nextState;
            indexTemp <= index;
        end
    end
    
    always@(*) begin
        nextState <= currentState;
        seqEnd <= 0;
        noteSelect <= 7;
        index <= indexTemp;
        case(currentState)
            initialState: begin
                index <= 0;
                // song <= 0;
                if(enable) begin                    
                    if(audioSelect == 2) song <= levelInc;
                    else if (audioSelect == 3) song <= worldInc;
                    else if (audioSelect == 4) song <= lifeDecr;
                    else if (audioSelect == 5) song <= win_display;
                    else if (audioSelect == 6) song <= lose_display;
                    else song <= play;
                    nextState <= loadNoteState;
                end
            end
            loadNoteState: begin
                note <= song >> index;
                nextState <= playNoteState;
            end
            playNoteState: begin
                timerEnable <= 1;
                case(note)
                    0: noteSelect <= A;
                    1: noteSelect <= B;
                    2: noteSelect <= C;
                    3: noteSelect <= D;
                    4: noteSelect <= E;
                    5: noteSelect <= F;
                    6: noteSelect <= G;
                    7: noteSelect <= mute; 
                    8: noteSelect <= mute; 
                endcase
                if(timeEnd) begin
                    timerEnable <= 0;
                    if(note == 8)begin 
                        nextState <= initialState; 
                        seqEnd <= 1; 
                    end
                    else nextState <= incrementState;
                end
            end
            incrementState: begin
                index <= indexTemp + 4;
                nextState <= loadNoteState;
            end
        endcase
        
    end
    
    noteTimer NT1 (clk, reset, timerEnable, timeEnd);
    
endmodule

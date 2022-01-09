`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Peter Marrone 
// Company: SDSU 
// Design Name: Lane Assist
// Create Date: 10/25/2021
//////////////////////////////////////////////////////////////////////////////////

module lane_assist(input CLK, RST, assist_right, assist_left, assist_disable, output reg [2:0] lane);
parameter ENABLE_LANE_ASSIST = 3'b010,              // Parameters to represent lane departure correction.
          DISABLE_LANE_ASSIST = 3'b000,
          ASSIST_RIGHT = 3'b001,
          ASSIST_LEFT = 3'b100;
          
always @(posedge CLK or posedge RST)
begin
if(RST == 1'b1)
    lane <= ENABLE_LANE_ASSIST;                     // Initially the lane assist will be enabled.
    case(lane)
        ENABLE_LANE_ASSIST: if(assist_right) lane <= ASSIST_RIGHT;                  // If car is unexpectedly departing right side of lane.
                            else if(assist_left) lane <= ASSIST_LEFT;               // If car is unexpectedly departing left side of lane
                            else if(assist_disable) lane <= DISABLE_LANE_ASSIST;    // If the lane assist is disabled.
                            else lane <= ENABLE_LANE_ASSIST;                        // If lane assist is enabled but not departing lane.
        
        ASSIST_RIGHT: if(assist_right) lane <= ASSIST_RIGHT;                        // If car is still unexpectedly departing right side of lane.
                      else lane <= ENABLE_LANE_ASSIST;                              // If car is back in lane return to starting state.
                      
        ASSIST_LEFT: if(assist_left) lane <= ASSIST_LEFT;                           // If car is still unexpectedly departing left side of lane.
                     else lane <= ENABLE_LANE_ASSIST;                               // If car is back in lane return to starting state.
                     
        DISABLE_LANE_ASSIST: if(assist_disable) lane <= DISABLE_LANE_ASSIST;        // If lane assiste is disabled, keep it disabled.
                             else lane <= ENABLE_LANE_ASSIST;                       // If lane assist is enabled. 
    endcase
end
endmodule


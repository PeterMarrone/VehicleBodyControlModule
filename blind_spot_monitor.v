`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Peter Marrone 
// Company: SDSU 
// Design Name: Blind Spot Monitoring
// Create Date: 10/25/2021
//////////////////////////////////////////////////////////////////////////////////

module blind_spot(input CLK, RST, right_side, left_side, output reg [1:0] blind);
parameter OFF = 2'b00,                  // Parameters that represent lights on side mirrors.
          RIGHT = 2'b01,
          LEFT = 2'b10,
          RIGHT_LEFT = 2'b11;

always @(posedge CLK or posedge RST)
begin
if(RST == 1'b1)
    blind <= OFF;                       // Initially the blind spot monitor is off since there are no cars in the blind spot.
    case(blind)
        OFF: if(right_side && left_side) blind <= RIGHT_LEFT;           // If cars are within the right and left blind spot of the car.
             else if(right_side) blind <= RIGHT;                        // If a car is within the right blind spot of the car.
             else if(left_side) blind <= LEFT;                          // If a car is within the left blind spot of the car.
             else blind <= OFF;                                         // If nothing detected, blind spot indicators off.
             
        RIGHT: if(right_side) blind <= RIGHT;                           // If the car is still within the right blind spot of the car.
               else blind <= OFF;                                       // If no car is in the right blind spot of the car, turn off the light.
        
        LEFT: if(left_side) blind <= LEFT;                              // If the car is still within the left blind spot of the car.
              else blind <= OFF;                                        // If no car is in the left blind spot of the car, turn off the light.
              
        RIGHT_LEFT: if(right_side && left_side) blind <= RIGHT_LEFT;    // If the cars are still within the left and right blind spot of the car.
                    else blind <= OFF;                                  // No cars are within the left and right blind spot, turn off the lights.
     endcase
end      
endmodule


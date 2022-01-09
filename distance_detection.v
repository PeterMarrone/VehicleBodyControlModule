`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Peter Marrone 
// Company: SDSU 
// Design Name: Distance Detection
// Create Date: 11/14/2021
//////////////////////////////////////////////////////////////////////////////////

module distance_detection(input CLK, RST, rear, front, input [4:0] distance, output reg [4:0] front_distance, rear_distance);
parameter TWENTY_FEET = 5'b10100,               // Parameters that represent different distances.
          FIFTEEN_FEET = 5'b01111,
          TEN_FEET = 5'b01010,
          FIVE_FEET = 5'b00101,
          FOUR_FEET = 5'b00100,
          THREE_FEET = 5'b00011,
          TWO_FEET = 5'b00010,
          ONE_FOOT = 5'b00001,
          OFF = 5'b00000;
          
always @(posedge CLK or posedge RST)
begin
if(RST == 1'b1)
begin 
    front_distance <= OFF;          // Initially the distance detection is OFF.
    rear_distance <= OFF;
end
    case(front_distance)
        OFF: if(front) front_distance <= TWENTY_FEET;                                   // If something is within 20 feet of the front.
             else front_distance <= OFF;                                                // If nothing is within 20 feet of the front.
        
        TWENTY_FEET: if(distance == 5'b01111) front_distance <= FIFTEEN_FEET;           // If something is within 15 feet of the front.
                     else if(front == 1'b0) front_distance <= OFF;                      // If nothing is within 20 feet of the front.
                     else front_distance <= TWENTY_FEET;                                // If something is still within 20 feet of the front.
        
        FIFTEEN_FEET: if(distance == 5'b01010) front_distance <= TEN_FEET;              // If something is within 10 feet of the front.
                      else if(distance == 5'b10100) front_distance <= TWENTY_FEET;      // If something is within 20 feet of the front again.
                      else front_distance <= FIFTEEN_FEET;                              // If something is still within 15 feet of the front.
        
        TEN_FEET: if(distance == 5'b00101) front_distance <= FIVE_FEET;                 // If something is within 5 feet of the front.
                  else if(distance == 5'b01111) front_distance <= FIFTEEN_FEET;         // If something is within 15 feet of the front again.
                  else front_distance <= TEN_FEET;                                      // If something is still within 10 feet of the front.
                             
        FIVE_FEET: if(distance == 5'b00100) front_distance <= FOUR_FEET;                // If something is within 4 feet of the front.
                   else if(distance == 5'b01010) front_distance <= TEN_FEET;            // If something is within 10 feet of the front again.
                   else front_distance <= FIVE_FEET;                                    // If something is still within 5 feet of the front.
        
        FOUR_FEET: if(distance == 5'b00011) front_distance <= THREE_FEET;               // If something is within 3 feet of the front.
                   else if(distance == 5'b00101) front_distance <= FIVE_FEET;           // If something is within 5 feet of the front again.
                   else front_distance <= FOUR_FEET;                                    // If something is still within 4 feet of the front.
                                                
        THREE_FEET: if(distance == 5'b00010) front_distance <= TWO_FEET;                // If something is within 2 feet of the front.
                    else if(distance == 5'b00100) front_distance <= FOUR_FEET;          // If something is within 4 feet of the front again.
                    else front_distance <= THREE_FEET;                                  // If something is still within 3 feet of the front.
                    
        TWO_FEET: if(distance == 5'b00001) front_distance <= ONE_FOOT;                  // If something is within 1 foot of the front.
                  else if(distance == 5'b00011) front_distance <= THREE_FEET;           // If something is within 3 feet of the front again.
                  else front_distance <= TWO_FEET;                                      // If something is still within 2 feet of the front.
         
        ONE_FOOT: if(distance == 5'b00000) front_distance <= OFF;                       // If the car hits something in front, turn the detection off.
                  else if(distance == 5'b00010) front_distance <= TWO_FEET;             // If something is within 2 feet of the front again.
                  else front_distance <= ONE_FOOT;                                      // If something is still within 1 foot of the front.
         
        default: front_distance <= OFF;                                                 // Default the distance detection system is off.
    endcase
    
    case(rear_distance)
        OFF: if(rear) rear_distance <= TWENTY_FEET;                                     // If something is within 20 feet of the rear.
             else rear_distance <= OFF;                                                 // If nothing is within 20 feet of the rear.
        
        TWENTY_FEET: if(distance == 5'b01111) rear_distance <= FIFTEEN_FEET;            // If something is within 15 feet of the rear.
                     else if(rear == 1'b0) rear_distance <= OFF;                        // If nothing is within 20 feet of the rear.
                     else rear_distance <= TWENTY_FEET;                                 // If something is still within 20 feet of the front.
        
        FIFTEEN_FEET: if(distance == 5'b01010) rear_distance <= TEN_FEET;               // If something is within 10 feet of the rear.
                      else if(distance == 5'b10100) rear_distance <= TWENTY_FEET;       // If something is within 20 feet of the rear again.
                      else rear_distance <= FIFTEEN_FEET;                               // If something is still within 15 feet of the rear.
        
        TEN_FEET: if(distance == 5'b00101) rear_distance <= FIVE_FEET;                  // If something is within 5 feet of the rear.
                  else if(distance == 5'b01111) rear_distance <= FIFTEEN_FEET;          // If something is within 15 feet of the rear again.
                  else rear_distance <= TEN_FEET;                                       // If something is still within 10 feet of the rear.
                             
        FIVE_FEET: if(distance == 5'b00100) rear_distance <= FOUR_FEET;                 // If something is within 4 feet of the rear.
                   else if(distance == 5'b01010) rear_distance <= TEN_FEET;             // If something is within 10 feet of the rear again.
                   else rear_distance <= FIVE_FEET;                                     // If something is still within 5 feet of the rear.
        
        FOUR_FEET: if(distance == 5'b00011) rear_distance <= THREE_FEET;                // If something is within 3 feet of the rear.
                   else if(distance == 5'b00101) rear_distance <= FIVE_FEET;            // If something is within 5 feet of the rear again.
                   else rear_distance <= FOUR_FEET;                                     // If something is still within 4 feet of the rear.
                                                
        THREE_FEET: if(distance == 5'b00010) rear_distance <= TWO_FEET;                 // If something is within 2 feet of the rear.
                    else if(distance == 5'b00100) rear_distance <= FOUR_FEET;           // If something is within 4 feet of the rear again.
                    else rear_distance <= THREE_FEET;                                   // If something is still within 3 feet of the rear.
                    
        TWO_FEET: if(distance == 5'b00001) rear_distance <= ONE_FOOT;                   // If something is within 1 foot of the rear.
                  else if(distance == 5'b00011) rear_distance <= THREE_FEET;            // If something is within 3 feet of the rear again.
                  else rear_distance <= TWO_FEET;                                       // If something is still within 2 feet of the rear.
        
        ONE_FOOT: if(distance == 5'b00000) rear_distance <= OFF;                        // If the car hits something in rear, turn the detection off.
                  else if(distance == 5'b00010) rear_distance <= TWO_FEET;              // If something is within 2 feet of the rear again.
                  else rear_distance <= ONE_FOOT;                                       // If something is still within 1 foot of the rear.
         
        default: rear_distance <= OFF;                                                  // Default the distance detection system is off.
    endcase                                                                                                                                                                                                                   
end
endmodule

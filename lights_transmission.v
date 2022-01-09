`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Peter Marrone 
// Company: SDSU 
// Design Name: Lighting system and transmission
// Create Date: 11/14/2021
//////////////////////////////////////////////////////////////////////////////////

module lights_transmission(input CLK, RST, right, left, brake, d_time, l_beam, h_beam, park, reverse, drive, input [3:0] rpm, 
                           output reg [9:0] rear_lights ,rear_blinkers, front_blinkers, front_headlights, output reg [2:0] transmission);
parameter OFF = 10'b0000000000,                 // Binary representation of lights.
          BRAKES_ON = 10'b0110000110,
          FRONT_HAZARD = 10'b1000000001,
          REAR_HAZARD = 10'b1111001111,
          REVERSE = 10'b0000110000,
          LEFT_1 = 10'b0001000000,
          LEFT_2 = 10'b0011000000,
          LEFT_3 = 10'b0111000000,
          LEFT_4 = 10'b1111000000,
          RIGHT_1 = 10'b0000001000,
          RIGHT_2 = 10'b0000001100,
          RIGHT_3 = 10'b0000001110,
          RIGHT_4 = 10'b0000001111,
          D_TIME_ON = 10'b0000100000,
          L_BEAM_ON = 10'b0000010000,
          H_BEAM_ON = 10'b0001001000;

parameter GEAR_PARK = 3'b000,                   // Binary representation of each gear in the transmission.
          GEAR_REVERSE = 3'b111,
          GEAR_ONE = 3'b001,
          GEAR_TWO = 3'b010,
          GEAR_THREE = 3'b011,
          GEAR_FOUR = 3'b100,
          GEAR_FIVE = 3'b101,
          GEAR_SIX = 3'b110;

always @(posedge CLK or posedge RST or posedge park)
begin
if(RST == 1'b1)                                 // Initial conditions will be OFF for all lights.
begin
    rear_lights <= OFF;
    rear_blinkers <= OFF;                    
    front_blinkers <= OFF;          
    front_headlights <= OFF;
end
if(park == 1'b1)                               // Transmission initially in park.
    transmission <= GEAR_PARK;
    
    case(rear_lights)
        OFF: if(brake) rear_lights <= BRAKES_ON;        // If brake sensor is enabled turn the brake lights on.
             else if(reverse) rear_lights <= REVERSE;   // If transmission is placed into reverse, turn on reverse lights.
             else rear_lights <= OFF;                   // If nothing selected, keep lights off.
        
        BRAKES_ON: if(brake) rear_lights <= BRAKES_ON;  // If brake sensor is still enabled, keep the brake lights on.
                   else rear_lights <= OFF;             // If brake sensor is disabled, turn the brake lights off.
        
        REVERSE: if(reverse) rear_lights <= REVERSE;  // If transmission remains in reverse, keep reverse lights on.
                 else rear_lights <= OFF;             // If transmission is not in reverse, turn reverse lights off.
        
        default: rear_lights <= OFF;                    // Default rear lights to off.
    endcase
    
    case(rear_blinkers)
        OFF: if(right && left) rear_blinkers <= REAR_HAZARD;    // If the hazard lights are enabled, turn on hazard lights.
             else if(right) rear_blinkers <= RIGHT_1;           // If right blinker enabled, turn on right sequential blinker.
             else if(left) rear_blinkers <= LEFT_1;             // If left blinker enabled, turn on left sequential blinker.
             else rear_blinkers <= OFF;                         // If nothing selected, keep blinkers off.
        
        RIGHT_1: if(right) rear_blinkers <= RIGHT_2;            // If right blinker enabled, turn on next light in sequential line.
                 else rear_blinkers <= OFF;                     // If right blinker disabled, turn off right blinker.
        RIGHT_2: if(right) rear_blinkers <= RIGHT_3;            // If right blinker enabled, turn on next light in sequential line.
                 else rear_blinkers <= OFF;                     // If right blinker disabled, turn off right blinker.
        RIGHT_3: if(right) rear_blinkers <= RIGHT_4;            // If right blinker enabled, turn on next light in sequential line.
                 else rear_blinkers <= OFF;                     // If right blinker disabled, turn off right blinker.
        RIGHT_4: if(right) rear_blinkers <= RIGHT_1;            // If right blinker enabled, turn on original light in sequential line.
                 else rear_blinkers <= OFF;                     // If right blinker disabled, turn off right blinker.
                 
        LEFT_1: if(left) rear_blinkers <= LEFT_2;               // If left blinker enabled, turn on next light in sequential line.
                else rear_blinkers <= OFF;                      // If left blinker disabled, turn off left blinker.
        LEFT_2: if(left) rear_blinkers <= LEFT_3;               // If left blinker enabled, turn on next light in sequential line.
                else rear_blinkers <= OFF;                      // If left blinker disabled, turn off left blinker.
        LEFT_3: if(left) rear_blinkers <= LEFT_4;               // If left blinker enabled, turn on next light in sequential line.
                else rear_blinkers <= OFF;                      // If left blinker disabled, turn off left blinker.
        LEFT_4: if(left) rear_blinkers <= LEFT_1;               // If left blinker enabled, turn on original light in sequential line.
                else rear_blinkers <= OFF;                      // If left blinker disabled, turn off left blinker.
        
        REAR_HAZARD: if(right && left) rear_blinkers <= OFF;  // If hazard lights are enabled, flash them by turning off and on.
                      else rear_blinkers <= OFF;               // If hazard lights are disabled, turn them off.
        
        default: rear_blinkers <= OFF;                          // Default turn the rear blinkers off.
    endcase
    
    case(front_blinkers)
        OFF: if(right && left) front_blinkers <= FRONT_HAZARD;  // If the hazard lights are enabled, turn on hazard lights.
             else if(right) front_blinkers <= RIGHT_4;          // If right blinker enabled, turn on right blinker.
             else if(left) front_blinkers <= LEFT_4;            // If left blinker enabled, turn on left blinker.
             else front_blinkers <= OFF;                        // If nothing selected, keep blinkers off.
        
        RIGHT_4: if(right) front_blinkers <= OFF;               // If right blinker enabled, turn right blinker off to flash.
                 else front_blinkers <= OFF;                    // If right blinker disabled, turn right blinker off.
        
        LEFT_4: if(left) front_blinkers <= OFF;                 // If left blinker enabled, turn left blinker off to flash.
                else front_blinkers <= OFF;                     // If left blinker disabled, turn left blinker off.
        
        FRONT_HAZARD: if(right && left) front_blinkers <= OFF;  // If hazard lights are enabled, flash them by turning off and on.
                      else front_blinkers <= OFF;               // If hazard lights are disabled, turn them off.
                      
        default: front_blinkers <= OFF;                         // Default turn the front blinkers off.
    endcase 
    
    case(front_headlights)
        OFF: if(d_time) front_headlights <= D_TIME_ON;          // If day time running lights are enabled, turn them on.
             else if(l_beam) front_headlights <= L_BEAM_ON;     // If low beam lights are enabled, turn them on.
             else if(h_beam) front_headlights <= H_BEAM_ON;     // If high beam lights are enabled, turn them on.
             else front_headlights <= OFF;                      // If nothing selected, keep headlights off.
        
        D_TIME_ON: if(d_time) front_headlights <= D_TIME_ON;    // If day time lights are enabled, keep them on.
                   else front_headlights <= OFF;                // If day time lights are disabled, turn them off. 
        
        L_BEAM_ON: if(l_beam) front_headlights <= L_BEAM_ON;    // If low beams are enabled, keep them on.
                   else front_headlights <= OFF;                // If low beams are disabled, turn them off.
        
        H_BEAM_ON: if(h_beam) front_headlights <= H_BEAM_ON;    // If high beams are enabled, keep them on.
                   else front_headlights <= OFF;                // If high beams are disabled, turn them off.
        
        default: front_headlights <= OFF;                       // Default turn the front headlights off.
    endcase
    
    case(transmission)
        GEAR_PARK: if(drive == 1'b1) transmission <= GEAR_ONE;                  // If car is in drive start in first gear.
                   else if(reverse == 1'b1) transmission <= GEAR_REVERSE;       // If car is in reverse start in reverse gear.
                   else transmission <= GEAR_PARK;                              // If nothing selected, keep car in park.
        
        GEAR_REVERSE: if(reverse == 1'b1) transmission <= GEAR_REVERSE;         // If car is in reverse gear, stay in reverse.
                      else transmission <= GEAR_PARK;                           // If not in reverse gear, go back to park.
        
        GEAR_ONE: if(rpm == 4'b0010) transmission <= GEAR_TWO;                  // If rpm is 0010, shift to second gear.
                  else if(reverse == 1'b1) transmission <= GEAR_REVERSE;        // If car is in reverse gear, shift to reverse gear.
                  else transmission <= GEAR_ONE;                                // Else, stay in first gear.
        
        GEAR_TWO: if(rpm == 4'b0011) transmission <= GEAR_THREE;                // If rpm is 0011, shift to third gear.
                  else if(rpm == 4'b0001) transmission <= GEAR_ONE;             // If rpm is 0001, shift down to first gear.
                  else transmission <= GEAR_TWO;                                // Else, stay in second gear.
        
        GEAR_THREE: if(rpm == 4'b0100) transmission <= GEAR_FOUR;               // If rpm is 0100, shift to fourth gear.
                    else if(rpm == 4'b0010) transmission <= GEAR_TWO;           // If rpm is 0010, shift down to second gear.
                    else transmission <= GEAR_THREE;                            // Else, stay in third gear.
        
        GEAR_FOUR: if(rpm == 4'b0101) transmission <= GEAR_FIVE;                // If rpm is 0101, shift to fifth gear.
                   else if(rpm == 4'b0011) transmission <= GEAR_THREE;          // If rpm is 0011, shift down to third gear.
                   else transmission <= GEAR_FOUR;                              // Else, stay in third gear.
        
        GEAR_FIVE: if(rpm == 4'b0110) transmission <= GEAR_SIX;                 // If rpm is 0110, shift to sixth gear.
                   else if(rpm == 4'b0100) transmission <= GEAR_FOUR;           // If rpm is 0100, shift down to fourth gear.
                   else transmission <= GEAR_FIVE;                              // Else, stay in fifth gear.
        
        GEAR_SIX: if(rpm == 4'b0110) transmission <= GEAR_SIX;                  // If rpm is 0110, stay in sixth gear.
                  else if(rpm == 4'b0101) transmission <= GEAR_FIVE;            // If rpm is 0101, shift down to fifth gear.
        
        default: transmission <= GEAR_PARK;                                     // Default transmission in park.
    endcase
end 
endmodule

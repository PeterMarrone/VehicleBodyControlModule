`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Peter Marrone 
// Company: SDSU 
// Design Name: Lighting system and trasmission test bench
// Create Date: 11/14/2021
//////////////////////////////////////////////////////////////////////////////////

module tb_lights_transmission;

reg CLK, RST, right, left, brake, d_time, l_beam, h_beam, park, reverse, drive;
reg [3:0] rpm;
wire [9:0] rear_lights, rear_blinkers, front_blinkers, front_headlights;
wire [2:0] transmission;

lights_transmission DUT (.CLK(CLK), .RST(RST), .right(right), .left(left), .brake(brake), .d_time(d_time), .l_beam(l_beam), .h_beam(h_beam), 
                         .park(park), .reverse(reverse), .drive(drive), .rpm(rpm), .rear_lights(rear_lights), .rear_blinkers(rear_blinkers), 
                         .front_blinkers(front_blinkers), .front_headlights(front_headlights), .transmission(transmission));

initial begin
    CLK = 1'b0; RST = 1'b1; right = 1'b0; left = 1'b0; brake = 1'b0; d_time = 1'b0; l_beam = 1'b0; h_beam = 1'b0; 
                park = 1'b1; reverse = 1'b0; drive = 1'b0; rpm = 4'b000;            // Start with all lights off and car in park.
#10 CLK = 1'b1; park = 1'b0; drive = 1'b1; d_time = 1'b1;       // Put car in drive and day time running lights turn on.
#10 CLK = 1'b0;
#10 CLK = 1'b1; RST = 1'b0; right = 1'b1; rpm = 4'b0010;        // Turn on right blinkers and rpm is enough to shift to second gear.
#10 CLK = 1'b0;
#10 CLK = 1'b1; rpm = 4'b0011;                                  // Rpm is enough to shift to third gear.
#10 CLK = 1'b0;
#10 CLK = 1'b1; rpm = 4'b0100;                                  // Rpm is enough to shift to fourth gear.
#10 CLK = 1'b0;
#10 CLK = 1'b1; 
#10 CLK = 1'b0;
#10 CLK = 1'b1; rpm = 4'b0101; d_time = 1'b0;                   // Turn day time running lights off and rpm is enough to shift to fifth gear.
#10 CLK = 1'b0;
#10 CLK = 1'b1;
#10 CLK = 1'b0;
#10 CLK = 1'b1; l_beam = 1'b1;                                  // Turn low beams on.
#10 CLK = 1'b0;
#10 CLK = 1'b1; 
#10 CLK = 1'b0;
#10 CLK = 1'b1; RST = 1'b1; right = 1'b0;                       // Turn right blinker off.
#10 CLK = 1'b0;
#10 CLK = 1'b1; RST = 1'b0; left = 1'b1;                        // Turn left blinker on.
#10 CLK = 1'b0;
#10 CLK = 1'b1; 
#10 CLK = 1'b0;
#10 CLK = 1'b1; l_beam = 1'b0;                                  // Turn low beams off.
#10 CLK = 1'b0;
#10 CLK = 1'b1; brake = 1'b1;                                   // Apply brakes.
#10 CLK = 1'b0;
#10 CLK = 1'b1; rpm = 4'b0100; h_beam = 1'b1;                   // Turn on high beams and rpm is enough to downshift to fourth gear.
#10 CLK = 1'b0;
#10 CLK = 1'b1; rpm = 4'b0011;                                  // Rpm is enough to downshift to third gear.
#10 CLK = 1'b0;
#10 CLK = 1'b1; rpm = 4'b0010;                                  // Rpm is enough to downshift to second gear.
#10 CLK = 1'b0;
#10 CLK = 1'b1; rpm = 4'b0001; brake = 1'b0;                    // Stop applying brakes and rpm is enough to downshift to first gear.
#10 CLK = 1'b0;
#10 CLK = 1'b1; RST = 1'b1; left = 1'b0; drive = 1'b0; reverse = 1'b1; rpm = 4'b0000;       // Turn off left blinker and put car into reverse.
#10 CLK = 1'b0;
#10 CLK = 1'b1; RST = 1'b0; h_beam = 1'b0;                      // Turn high beams off.
#10 CLK = 1'b0;
#10 CLK = 1'b1; reverse = 1'b0;                                 // Take car out of reverse.
#10 CLK = 1'b0;

#5 $finish;
end
endmodule

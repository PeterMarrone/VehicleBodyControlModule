`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Peter Marrone 
// Company: SDSU 
// Design Name: Distance Detection Test Bench
// Create Date: 11/14/2021
//////////////////////////////////////////////////////////////////////////////////

module tb_distance_detection;

reg CLK, RST, front, rear;
reg [4:0] distance;
wire [4:0] front_distance, rear_distance;

distance_detection DUT (.CLK(CLK), .RST(RST), .front(front), .rear(rear), .distance(distance), .front_distance(front_distance), .rear_distance(rear_distance));

initial begin
    CLK = 1'b0; RST = 1'b1; front = 1'b0; rear = 1'b0; distance = 5'b00000;     // Nothing within range of front or back of car.
#10 CLK = 1'b1; RST = 1'b0; front = 1'b1;       // Something comes within 20 feet of front of car.
#10 CLK = 1'b0; 
#10 CLK = 1'b1; distance = 5'b01111;            // Thing is now within 15 feet of front of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b01010;            // Thing is now within 10 feet of front of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b00101;            // Thing is now within 5 feet of front of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b00100;            // Thing is now within 4 feet of front of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b00101;            // Thing is now within 5 feet of front of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b01010;            // Thing is now within 10 feet of front of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b01111;            // Thing is now within 15 feet of front of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b10100;            // Thing is now within 20 feet of front of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b00000;            // Thing is now out of range of front of car.
#10 CLK = 1'b0; RST = 1'b1; front = 1'b0;       // Nothing within range of front of car.
#10 CLK = 1'b1; RST = 1'b0; rear = 1'b1;        // Something comes within 20 feet of rear of car.
#10 CLK = 1'b0; 
#10 CLK = 1'b1; distance = 5'b01111;            // Thing is now within 15 feet of rear of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b01010;            // Thing is now within 10 feet of rear of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b00101;            // Thing is now within 5 feet of rear of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b00100;            // Thing is now within 4 feet of rear of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b00101;            // Thing is now within 5 feet of rear of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b01010;            // Thing is now within 10 feet of rear of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b01111;            // Thing is now within 15 feet of rear of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b10100;            // Thing is now within 20 feet of rear of car.
#10 CLK = 1'b0;
#10 CLK = 1'b1; distance = 5'b00000;            // Thing is now out of range of rear of car.
#10 CLK = 1'b0; RST = 1'b1; rear = 1'b0;        // Nothing within range of rear of car.
#10 CLK = 1'b1; RST = 1'b0;
#10 CLK = 1'b0;

#5 $finish;
end
endmodule

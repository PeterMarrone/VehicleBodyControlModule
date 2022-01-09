`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Peter Marrone 
// Company: SDSU 
// Design Name: Lane Assist Test Bench
// Create Date: 10/25/2021
//////////////////////////////////////////////////////////////////////////////////

module tb_lane_assist;
reg CLK, RST, assist_right, assist_left, assist_disable;
wire [2:0] lane;

lane_assist DUT (.CLK(CLK), .RST(RST), .assist_right(assist_right), .assist_left(assist_left), .assist_disable(assist_disable), .lane(lane));
                  
initial begin
    CLK = 1'b0; RST = 1'b1; assist_right = 1'b0; assist_left = 1'b0; assist_disable = 1'b0;     // Car is driving perfectly in lane.
#10 CLK = 1'b1; RST = 1'b0; assist_right = 1'b1;            // Car too close to right side of lane.
#10 CLK = 1'b0;  
#10 CLK = 1'b1; 
#10 CLK = 1'b0; 
#10 CLK = 1'b1; assist_right = 1'b0;                        // Car back in the center of lane.
#10 CLK = 1'b0; RST = 1'b1; 
#10 CLK = 1'b1; RST = 1'b0; assist_left = 1'b1;             // Car too close to left side of lane.
#10 CLK = 1'b0;  
#10 CLK = 1'b1; 
#10 CLK = 1'b0; 
#10 CLK = 1'b1; assist_left = 1'b0;                         // Car back in the center of lane.
#10 CLK = 1'b0; RST = 1'b1;
#10 CLK = 1'b1; RST = 1'b0; assist_disable = 1'b1;          // Turn off lane assist feature.
#10 CLK = 1'b0;  
#10 CLK = 1'b1; 
#10 CLK = 1'b0;   

#5 $finish;
end
endmodule

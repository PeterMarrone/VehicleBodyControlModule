`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Peter Marrone 
// Company: SDSU 
// Design Name: Blind Spot Monitoring Test Bench
// Create Date: 10/25/2021
//////////////////////////////////////////////////////////////////////////////////

module tb_blind_spot;

reg CLK, RST, right_side, left_side;
wire [1:0] blind;

blind_spot DUT (.CLK(CLK), .RST(RST), .right_side(right_side), .left_side(left_side), .blind(blind));

initial begin
    CLK = 1'b0; RST = 1'b1; right_side = 1'b0; left_side = 1'b0;    // Nothing within the right and left blind spot of car.
#10 CLK = 1'b1; RST = 1'b0; right_side = 1'b1;                      // Car within right blind spot.
#10 CLK = 1'b0; 
#10 CLK = 1'b1; 
#10 CLK = 1'b0;
#10 CLK = 1'b1; RST = 1'b1; right_side = 1'b0;                      // Car not within right blind spot.
#10 CLK = 1'b0; RST = 1'b0; 
#10 CLK = 1'b1; left_side = 1'b1;                                   // Car within left blind spot.
#10 CLK = 1'b0; 
#10 CLK = 1'b1; 
#10 CLK = 1'b0; 
#10 CLK = 1'b1; RST = 1'b1; right_side = 1'b0; left_side = 1'b0;    // Car not within left blind spot.
#10 CLK = 1'b0; RST = 1'b0; 
#10 CLK = 1'b1; right_side = 1'b1; left_side = 1'b1;    // Car within right and left blind spot.
#10 CLK = 1'b0; 

#5 $finish;
end
endmodule


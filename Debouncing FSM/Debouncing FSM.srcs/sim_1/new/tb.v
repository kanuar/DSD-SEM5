`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2023 12:34:42
// Design Name: 
// Module Name: tb
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


module tb();
// Declare signals for connecting to the db_fsm module
reg clk;    // Clock signal
reg reset;  // Reset signal
reg sw;     // Switch input
wire db;    // Debounced output

// Instantiate the db_fsm module
design_module dut(clk, reset, sw, db);

// Clock generation
initial begin
    clk = 0;
    forever #10 clk = ~clk; // Toggle the clock every 10 time units (simulate 20ns clock period)
end

// Initializations
initial begin
    clk = 0;
    reset = 1;
    sw = 0;
    #10 reset = 0;
    sw = 1;
    #10485760 reset = 0;
    sw = 1;
    #10485760 reset = 0;
    sw = 1;
    #10485760 reset = 0;
    sw = 1;
    #10485760 reset = 0;
    sw = 0;
    #10485760 reset = 0;
    sw = 0;
    #10485760 reset = 0;
    sw = 0;
    #100 reset = 1;
    sw = 0;
    $finish;
end

// Display debounced output
always @(posedge clk) begin
    $display("Time=%t, db=%b", $time, db);
end

endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2023 13:11:10
// Design Name: 
// Module Name: testbench
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


module testbench();

reg clk,enable,reset;
reg [7:0] a;
wire [7:0] b;
wire data_out;

design_module #(8) dut(clk,enable,reset,a,b,data_out);

always begin 
#10 clk=~clk;
end

initial begin
clk=0;
reset=1;
enable=0;
repeat(20)
begin
    #20
    reset=0;
    a=$random();
    #5
    enable=1;
    #20
    enable=0;
    $display($time,"sim time value of a = %0d and value of b = %0d",a,b);
end
reset=1; 
#100
$finish(); 
end

endmodule

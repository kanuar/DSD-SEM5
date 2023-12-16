`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NA
// Engineer: Raunak Kodwani
// 
// Create Date: 16.12.2023 15:19:42
// Design Name: Circular FIFO
// Module Name: design_module
// Project Name: Circular FIFO
// Target Devices: Artix 7 xc7a35tcpg236-1
// Tool Versions: 
// Description: 
// Circular FIFO design with variable data length and variable FIFO size
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb();

reg clk,enable,reset,fifo_write,fifo_read,fifo_clear;
reg [7:0] data_in;
wire [7:0] data_out;
wire fifo_full,data_drop;

design_module #(8,12) dut(clk,enable,reset,fifo_write,fifo_read,fifo_clear,data_in,data_out,data_drop,fifo_full);

always begin
#10 clk=~clk;
end

initial begin
    clk=0;
    enable=0;
    reset=1;
    fifo_clear=1;
    fifo_write=0;
    fifo_read=0;
    data_in=0;
    #20
    reset=0;
    fifo_clear=0;
    enable=1;
    #5
    repeat(50)
    begin
        fifo_read=$random();
        fifo_write=~fifo_write;
        data_in=$random();
        #30
        $display("simulation time = ",$time,"  data_in = %0d, data_out=%0d, fifo_write= %0d,fifo_read= %0d",data_in,data_out,fifo_write,fifo_read);
    end
    
    #20
    reset=1;
    #20
    $finish();
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2023 12:55:24
// Design Name: 
// Module Name: design
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


module design_module
#(parameter N=4)
(input wire clk,
input wire enable,
input wire reset,
input wire [N-1:0]a,
output reg [N-1:0]gc,
output reg data_out
);
reg [N-1:0] data;
integer counter;
always @(posedge clk)
   begin
   if(reset)
       begin
        gc<=0;
        data=0;
      end
   if(enable && data_out)
    gc<=data;
   end

always @(a)
    begin
        counter=N-1;
        data=0;
        data_out=0;
    end

always @(data,counter)
    begin
    repeat(N)
    begin
        if(counter==N-1)
            data[counter]=a[counter];
        else
            data[counter]=a[counter]^a[counter+1];
        
       if(counter==0)
        begin
            data_out=1;
        end
        counter=counter-1;
    end
    end
endmodule

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


module design_module
#(parameter size=4,length=10)
(
    input wire clk,enable,reset,fifo_write,fifo_read,fifo_clear,
    input wire [size-1:0] data_in,
    output reg [size-1:0] data_out,
    output reg data_drop,fifo_full
);

integer write_pointer;
integer read_pointer;
reg [size-1:0] fifo [length-1:0];
integer i;
always @(posedge clk)
begin
    $display("fifo = %p",fifo);
    if(reset || fifo_clear)
    begin
        i=0;
        repeat(length)
        begin
            fifo[i]=0;
            i=i+1;
        end
        data_out<=0;
        write_pointer=0;
        read_pointer=0;
        data_drop=0;
        fifo_full=0;
    end
    
    else
    begin
        if(fifo_read)
        begin
            data_out<=fifo[read_pointer];
            read_pointer<=read_pointer+1;
            fifo[read_pointer]<=0;
            if(read_pointer+1==length)
                read_pointer<=0;
        end
        
        if(fifo_write)
        begin
            data_out<=0;
            if(fifo[write_pointer]==0)
            begin
                fifo[write_pointer]<=data_in;
                write_pointer=write_pointer+1;
                if(write_pointer+1==length)
                    write_pointer<=0;
            end
            
            else
            begin
                fifo_full=1;
                data_drop=1;
            end
        end
    end
end

endmodule
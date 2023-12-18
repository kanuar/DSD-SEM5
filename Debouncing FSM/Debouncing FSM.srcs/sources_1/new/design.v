`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2023 11:29:40
// Design Name: 
// Module Name: design_module
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

module design_module(
    input wire clk, 
    reset, 
    input wire sw, 
    output reg db
);

// Symbolic state declaration
localparam [2:0] zero = 3'b000, wait1_1 = 3'b001, wait1_2 = 3'b010, wait1_3 = 3'b011, 
                 one = 3'b100, wait0_1 = 3'b101, wait0_2 = 3'b110, wait0_3 = 3'b111;

// Number of counter bits (2^N * 20ns = 10ms tick)
localparam N = 19;

// Signal declaration
reg [N-1:0] q_reg;
wire [N-1:0] q_next;
wire m_tick;
reg [2:0] state_reg, state_next;

// Counter
always @(posedge clk)
    q_reg <= q_next;

// Next state logic
assign q_next = q_reg + 1;

// Output tick
assign m_tick = (q_reg == 0) ? 1'b1 : 1'b0;

// Debouncing FSM

// State register
always @(posedge clk, posedge reset)
    if (reset)
        state_reg <= zero;
    else
        state_reg <= state_next;

// Next-state logic and output logic
always @*
begin
    state_next = state_reg;
    db = 1'b0;
    case (state_reg)
        zero: if (sw) state_next = wait1_1;
        wait1_1: if (~sw) state_next = zero;
                else if (m_tick) state_next = wait1_2;
        wait1_2: if (~sw) state_next = zero;
                else if (m_tick) state_next = wait1_3;
        wait1_3: if (~sw) state_next = zero;
                else if (m_tick) state_next = one;
        one:    begin
                    db = 1'b1;
                    if (~sw) state_next = wait0_1;
                end
        wait0_1: begin
                    db = 1'b1;
                    if (sw) state_next = one;
                    else if (m_tick) state_next = wait0_2;
                end
        wait0_2: begin
                    db = 1'b1;
                    if (sw) state_next = one;
                    else if (m_tick) state_next = wait0_3;
                end
        wait0_3: begin
                    db = 1'b1;
                    if (sw) state_next = one;
                    else if (m_tick) state_next = zero;
                end
        default: state_next = zero;
    endcase
end

endmodule

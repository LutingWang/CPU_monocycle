`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:29:12 11/25/2018 
// Design Name: 
// Module Name:    dm 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dm(
    input [11:2] Addr,
    input [31:0] Din,
    input We,
    input Clk,
    input Reset,
    output [31:0] Dout
    );

	reg [31:0] dm[1023:0];
	integer i;
	initial begin
		for(i=0; i<1024; i=i+1) begin
			dm[i] = 0;
		end
	end
	
	assign Dout = dm[Addr];
	
	always @(posedge Clk) begin
		if (Reset) begin
			for(i=0; i<1023; i=i+1) begin
				dm[i] = 0;
			end
		end else begin
			if (We) begin
				dm[Addr] = Din;
			end
		end
	end

endmodule

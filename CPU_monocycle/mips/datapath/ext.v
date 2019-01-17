`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:30:53 11/25/2018 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [1:0] ExtOp,
    input [15:0] Imm,
    output reg [31:0] Ext
    );

	`include "header.v"
	
	always @(*) begin
		case (ExtOp)
			`ext_unsigned: begin
				Ext = {16'b0, Imm};
			end
			`ext_signed: begin
				Ext = {{16{Imm[15]}}, Imm};
			end
			`ext_lui: begin
				Ext = {Imm, 16'b0};
			end
			`ext_clear: begin
				Ext = 32'b0;
			end
		endcase
	end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:00 11/25/2018 
// Design Name: 
// Module Name:    RegDst 
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
module RegDst(
    input [4:0] A3,
    input [4:0] A2,
    input [1:0] RegDst,
    output reg [4:0] RegDstOut
    );

	`include "header.v"

	always @(*) begin
		case(RegDst)
			`RegDst_A3: begin
				RegDstOut = A3;
			end
			`RegDst_A2: begin
				RegDstOut = A2;
			end
			`RegDst_ra: begin
				RegDstOut = 31;
			end
		endcase
	end

endmodule

module ALUSrc(
    input [31:0] Rd2,
	 input [31:0] Ext,
	 input ALUSrc,
	 output [31:0] ALUSrcOut
	 );
	 
	`include "header.v"
	
	assign ALUSrcOut = (ALUSrc == 1) ? Ext : Rd2;
	 
endmodule

module DataSrc(
    input [31:0] C,
	 input [31:0] Dout,
	 input [31:0] PC,
	 input [1:0] DataSrc,
	 output reg [31:0] DataSrcOut
	 );
	 
	`include "header.v"
	 
	always @(*) begin
		case (DataSrc)
			`DataSrc_alu: begin
				DataSrcOut = C;
			end
			`DataSrc_dm: begin
				DataSrcOut = Dout;
			end
			`DataSrc_ifu: begin
				DataSrcOut = PC;
			end
		endcase
	end
endmodule

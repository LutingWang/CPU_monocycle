`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:25:22 11/25/2018 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output reg [31:0] C,
    output N,
    output Z,
    output reg V,
    output reg Carry
    );
	`include "header.v"

	assign N = C[31];
	assign Z = ~(|C);
	
	reg CS;
	
	always @(*) begin
		case (ALUOp)
			`alu_nop: begin
				C = 32'b0;
			end
			`alu_add: begin
				{CS, C[30:0]} = A[30:0] + B[30:0];
				{Carry, C[31]} = A[31] + B[31] + CS;
				V = CS ^ Carry;
			end
			`alu_sub: begin
				{CS, C[30:0]} = A[30:0] - B[30:0];
				{Carry, C[31]} = A[31] - B[31] - CS;
				V = CS ^ Carry;
			end
			`alu_and: begin
				C = A & B;
			end
			`alu_or: begin
				C = A | B;
			end
			`alu_xor: begin
				C = A ^ B;
			end
			`alu_lt: begin
				C = (A<B) ? 32'b1 : 32'b0;
			end
			`alu_B: begin
				C = B;
			end
		endcase
	end

endmodule

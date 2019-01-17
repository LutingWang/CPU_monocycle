`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:45 11/25/2018 
// Design Name: 
// Module Name:    ctrl 
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
module ctrl(
    input [5:0] OpCode,
    input [5:0] Funct,
    output [1:0] RegDst,
    output ALUSrc,
    output [1:0] DataSrc,
    output RegWrite,
    output MemWrite,
    output [1:0] NPC_Sel,
    output [1:0] ExtOp,
    output [2:0] ALUOp
    );

	`include "header.v"

	assign nop = (OpCode == `R && Funct == `nop) ? 1 : 0;
	assign jr = (OpCode == `R && Funct == `jr) ? 1 : 0;
	assign addu = (OpCode == `R && Funct == `addu) ? 1 : 0;
	assign subu = (OpCode == `R && Funct == `subu) ? 1 : 0;
	assign slt = (OpCode == `R && Funct == `slt) ? 1 : 0;
	
	assign beq = (OpCode == `beq) ? 1 : 0;
	assign addiu = (OpCode == `addiu) ? 1 : 0;
	assign ori = (OpCode == `ori) ? 1 : 0;
	assign lui = (OpCode == `lui) ? 1 : 0;
	assign lw = (OpCode == `lw) ? 1 : 0;
	assign sw = (OpCode == `sw) ? 1 : 0;
	assign j = (OpCode == `j) ? 1 : 0;
	assign jal = (OpCode == `jal) ? 1 : 0;
	
	assign NPC_Sel = (nop + addu + subu + slt + addiu + ori + lui + lw + sw) ? `ifu_add4 :
	                 (j + jal) ? `ifu_jump :
						  (beq) ? `ifu_branch :
						  (jr) ? `ifu_jr :
						  2'bxx;
	assign NPCOp = (j + jal) ? 1'b1 :
	               (beq) ? 1'b0 :
						1'bx;
	assign ExtOp = (ori) ? `ext_unsigned :
	               (addiu + lw + sw) ? `ext_signed :
						(lui) ? `ext_lui :
						2'bxx;
	assign ALUSrc = (jr + addu + subu + slt + beq) ? 1'b0 :
	                (addiu + ori + lui + lw + sw) ? 1'b1 :
						 1'bx;
	assign ALUOp = (addu + addiu + lw + sw) ? `alu_add :
	               (subu + beq) ? `alu_sub :
						(jr + ori) ? `alu_or :
						(slt) ? `alu_lt :
						(lui) ? `alu_B :
						3'bxxx;
	assign MemWrite = (nop + jr + addu + subu + slt + beq + addiu + ori + lui + lw + j + jal) ? 1'b0 :
	                  (sw) ? 1'b1 :
							1'bx;
	assign RegDst = (addu + subu + slt) ? `RegDst_A3 :
	                (addiu + ori + lui + lw) ? `RegDst_A2 :
						 (jal) ? `RegDst_ra :
						 2'bxx;
	assign DataSrc = (addu + subu + slt + addiu + ori + lui) ? `DataSrc_alu :
	                 (lw) ? `DataSrc_dm :
						  (jal) ? `DataSrc_ifu :
						  2'bxx;
	assign RegWrite = (nop + jr + beq + sw + j) ? 1'b0 :
	                  (addu + subu + slt + addiu + ori + lui + lw + jal) ? 1'b1 :
							1'bx;

endmodule

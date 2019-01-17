`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:03 11/23/2018 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );

	assign Clk = clk;
	assign Reset = reset;
	
	wire ALUSrc, RegWrite, MemWrite;
	wire [1:0] RegDst, DataSrc, NPC_Sel, ExtOp;
	wire [2:0] ALUOp;
	wire [31:0]Instr;
	datapath Datapath (
    .RegDst(RegDst), 
    .ALUSrc(ALUSrc), 
    .DataSrc(DataSrc), 
    .RegWrite(RegWrite), 
    .MemWrite(MemWrite), 
    .NPC_Sel(NPC_Sel), 
    .ExtOp(ExtOp), 
    .ALUOp(ALUOp), 
    .Clk(Clk), 
    .Reset(Reset), 
    .Instr(Instr)
    );
	
	wire [5:0] OpCode, Funct;
	assign OpCode = Instr[31:26];
	assign Funct = Instr[5:0];
	ctrl Controller (
    .OpCode(OpCode), 
    .Funct(Funct), 
    .RegDst(RegDst), 
    .ALUSrc(ALUSrc), 
    .DataSrc(DataSrc), 
    .RegWrite(RegWrite), 
    .MemWrite(MemWrite), 
    .NPC_Sel(NPC_Sel), 
    .ExtOp(ExtOp), 
    .ALUOp(ALUOp)
    );

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:17:37 11/25/2018 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
    input [1:0] RegDst,
    input ALUSrc,
    input [1:0] DataSrc,
    input RegWrite,
    input MemWrite,
    input [1:0] NPC_Sel,
    input [1:0] ExtOp,
	 input [2:0] ALUOp,
	 input Clk,
	 input Reset,
    output [31:0] Instr
    );
	 
	`include "header.v"
	
	always @(posedge Clk) begin
		if (!Reset) begin
			if (RegWrite) $display("@%h: $%d <= %h", PC-4, RegDstOut, Wd);
			if (MemWrite) $display("@%h: *%h <= %h", PC-4, {20'b0, C[11:2], 2'b00}, Din);
		end
	end
	
	wire Z;
	assign Jr = Rd1;
	wire [31:0] Instr, PC, Jr;
	ifu dp_ifu (
    .NPC_Sel(NPC_Sel), 
    .Z(Z), 
    .Jr(Jr), 
    .Clk(Clk), 
    .Reset(Reset), 
    .Instr(Instr), 
    .PC(PC)
    );
	
	wire [4:0] A1, A2, A3;
	assign A1 = Instr[25:21];
	assign A2 = Instr[20:16];
	assign A3 = Instr[15:11];
	assign Wd = DataSrcOut;
	wire [31:0] Rd1, Rd2, Wd;
	grf dp_grf (
    .A1(A1), 
    .A2(A2), 
    .A3(RegDstOut), 
    .Wd(Wd), 
    .We(RegWrite), 
    .Clk(Clk), 
    .Reset(Reset), 
    .Rd1(Rd1), 
    .Rd2(Rd2)
    );
	
	assign A = Rd1;
	assign B = ALUSrcOut;
	wire [31:0] A, B, C;
	wire N, V, Carry;
	alu dp_alu (
    .A(A), 
    .B(B), 
    .ALUOp(ALUOp), 
    .C(C), 
    .N(N), 
    .Z(Z), 
    .V(V), 
    .Carry(Carry)
    );
	
	assign Addr = C[11:2];
	assign Din = Rd2;
	wire [9:0] Addr;
	wire [31:0] Din, Dout;
	dm dp_dm (
    .Addr(Addr), 
    .Din(Din), 
    .We(MemWrite), 
    .Clk(Clk), 
    .Reset(Reset), 
    .Dout(Dout)
    );
	
	assign Imm = Instr[15:0];
	wire [15:0] Imm;
	wire [31:0] Ext;
	ext dp_ext (
    .ExtOp(ExtOp), 
    .Imm(Imm), 
    .Ext(Ext)
    );
	
	wire [4:0] RegDstOut;
	RegDst mux_RegDst (
    .A3(A3), 
    .A2(A2), 
    .RegDst(RegDst), 
    .RegDstOut(RegDstOut)
    );
	
	wire [31:0] ALUSrcOut;
	ALUSrc mux_ALUSrc (
    .Rd2(Rd2), 
    .Ext(Ext), 
    .ALUSrc(ALUSrc), 
    .ALUSrcOut(ALUSrcOut)
    );
	
	wire [31:0] DataSrcOut;
	DataSrc mux_DataSrc (
    .C(C), 
    .Dout(Dout), 
    .PC(PC), 
    .DataSrc(DataSrc), 
    .DataSrcOut(DataSrcOut)
    );

endmodule

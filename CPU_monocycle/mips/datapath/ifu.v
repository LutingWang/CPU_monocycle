`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:23:18 11/25/2018 
// Design Name: 
// Module Name:    ifu 
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
module ifu(
    input [1:0] NPC_Sel,
    input Z,
    input [31:0] Jr,
    input Clk,
    input Reset,
    output [31:0] Instr,
    output [31:0] PC
    );
	`include "header.v"

	reg [31:0] programCounter;
	assign PC = programCounter + 4;
	reg [31:0] im[1023:0];
	assign Instr = im[programCounter[11:2]];
	
	integer i;
	initial begin
		programCounter = 32'h0000_3000;
		
		for(i=0; i<1024; i=i+1) im[i] = 32'b0;
		$readmemh("code.txt", im);
	end
	
	always @(posedge Clk) begin
		if (Reset)
			programCounter = 32'h0000_3000;
		else begin
			case (NPC_Sel)
				`ifu_add4: begin
					programCounter = PC;
				end
				`ifu_jump: begin
					programCounter = {programCounter[31:26], Instr[25:0], 2'b00};
				end
				`ifu_branch: begin
					if (Z) begin
						programCounter = PC + {{14{Instr[15]}}, Instr[15:0], 2'b00};
					end else begin
						programCounter = PC;
					end
				end
				`ifu_jr: begin
					programCounter = Jr;
				end
			endcase
			programCounter = {20'h00003, programCounter[11:2], 2'b00};
		end
	end

endmodule

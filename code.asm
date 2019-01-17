.text
# addiu
addiu $t0, $zero, 10
# addu
addu $t1, $t0, $t0
# beq
beq $t0, $t0, if_1_else
	addiu $t0, $zero, 1
if_1_else:
	addiu $t0, $t0, 1
addiu $s0, $zero, 1
beq $t1, $s0, if_2_else
	addiu $t0, $zero, 1
if_2_else:
	addiu $t0, $t0, 1
# subu
subu $t0, $t0, 1
# slt
addiu $s0, $t0, 1
slt $t1, $t0, $s0
slt $t1, $s0, $t0
# ori
addiu $t1, $zero, 6
ori $t2, $t1, 1
# lui
lui $t0, 2
# jal, jr
jal test
addiu $t0, $zero, 1
# j
j jump
	addiu $t0, $zero, 8
jump:
# sw
sw $t0, 0x00000000
# lw
lw $t0, 0x00000000
j end
test: 
sw $ra, 0x0000004
jr $ra
end:

#################
# check




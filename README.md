# CPU_monocycle

## Overview

This is the final version of ***Project 4 CPU monocycle*** of ***BUAA Computer Origanization*** year 2018 - 2019. The project is written in Verilog and is designed handle the MIPS-Lite Instruction Set, i.e. {nop, jr, addu, subu, slt, beq, addiu, ori, lui, lw, sw, j, jal}. 

**WARNING: the project is used only for study! Cloning the whole project and submitting it as your project is a serious violation of the course regulations. Cheating will bring about numerous penalties. Moreover, nobody ensures the project being absolutely correct. Please test it before you put into use.** 

## Project Info

The project consists of one monocycle CPU, using one set of instruction and data cache. Upon booting (stating simulation in ISim), the CPU model automatically searches for ./CPU_monocycle/code.txt and loads it into the instruction cache. Then the model will execute the instructions in order.

## Testing

A short piece of MIPS code is attached to the project, in order to test the model. The file named code.asm can be opened and edited in any text pocessing applications, while MARS is specifically preffered. MARS is an open-source, lightweight application developed in Java, intending to simulate the behavior of MIPS CPU. 

To test the project, first open code.asm in MARS. After compiling the source code, a hexdecimal version of the binary code can be exported. **It is exceedingly crucial that the file is named code.txt, and is placed immediately under /CPU_monocycle.**

Thereafter, open the project in ISE and run ISim to inspect the values of all registers. You could compare the values in ISim and those in MARS. Value information output will be available in further projects, which will make this comparison more convinient.
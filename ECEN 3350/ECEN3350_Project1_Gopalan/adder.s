.global _start
_start:
	
	.text
	.equ LEDs, 0xFF200000
	.equ SWITCHES, 0xFF200040
	.global _start
_start:
	movia r2, LEDs # Address of LEDs
	movia r3, SWITCHES # Address of switches
	
LOOP:
	ldwio r4, (r3) # Read the state of switches
	
	# <Your code to modify r4 here>
	andi r5, r4, 0x000003E0
	srli r5, r5, 5
	andi r6, r4, 0x0000001F
	add r7, r5, r6
	stwio r7, (r2) # Display the state on LEDs
	br LOOP
	.end

.text
.equ HEX, 0xFF200020
.equ PATTERN_A, 0x49494949
.equ PATTERN_B, 0x36363636
.equ PATTERN_C, 0x7F7F7F7F

.global _start

_start:
	movia r8, M
	movia r5, HEX
	movia r7, 0x001FFFFF
	movia r11, 0
	movia r12, 1
	movia r13, 18
	movia r14, P
	movia r15, 12
	
JUMP:
	ldw r9, (r8)
	add r11, r11, r9
	stwio r11, (r5)
	addi r8, r8, 4
	addi r12, r12, 1
	slli r11, r11, 8
	movia r6, 0
	
DELAY:
	addi r6, r6, 1
	bltu r6, r7, DELAY
	beq r12, r13, PATTERNS
	br JUMP
	
PATTERNS:
	ldw r9, (r14)
	stwio r9, (r5)
	addi r14, r14, 4
	subi r15, r15, 1
	movia r6, 0
	bgt r15, r0, DELAY
	br _start
	
.data
M:
	.word 0x00000076, 0x00000079, 0x00000038, 0x00000038, 0x0000003F, 0x0000007C, 0x0000003E, 0x00000071, 0x00000071, 0x0000006D, 0x00000040, 0x00000040, 0x00000040, 0x00000000, 0x00000000, 0x00000000,0x00000000
P:
	.word PATTERN_A, PATTERN_B, PATTERN_A, PATTERN_B, PATTERN_A, PATTERN_B, 0x00000000, PATTERN_C, 0x00000000, PATTERN_C, 0x00000000
.end
	
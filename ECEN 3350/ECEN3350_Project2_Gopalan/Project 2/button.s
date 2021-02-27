.text
	.equ	HEX, 0xFF200020
	.equ	KEY, 0xFF200050
	.global _start
	
_start:
	movia	r2, HEX
	movia	r3, KEY
	movia	r4, left_word
	movia	r5, right_word
	movi	r6, 8 
	movi	r7, 0
	movi	r8, 0 
	movi 	r10, 0 
	stwio	r0, 0(r2) 
	
LOOP:	          
	ori 	r9, r0, 0x00004B40
	orhi	r9, r9, 0x0000004C
	
DELAY:
	subi	r9, r9, 1
	bgt 	r9, r0, DELAY
	br 		CHECK
	
HANDLER:
	ldw 	r4, 0(r3)
	stwio	r4, 0(r2)
	br  	LOOP
	
CHECK:
	ldwio 	r11, 0(r3)
	blt 	r0, r11, RESET 
	beq 	r8, r0, DIRECTION_LEFT 
	br  	DIRECTION_RIGHT 
	
DIRECTION_LEFT:
	slli	r10, r10, 8
	ldw 	r11, 0(r4) 
	or  	r10, r10, r11 
	stwio	r10, 0(r2) 
	addi	r4,	r4, 4 
	addi	r7, r7, 1
	beq 	r7, r6, LEFT 
	br  	LOOP
	
DIRECTION_RIGHT:
	srli	r10, r10, 8 
	ldw 	r11, 0(r5) 
	slli	r11, r11, 24
	or  	r10, r10, r11 
	stwio	r10, 0(r2) 
	addi	r5,	r5, 4 
	addi	r7, r7, 1 
	beq 	r7, r6, RIGHT 
	br  	LOOP
	
RESET:
	beq 	r8, r0, RIGHT
	br  	LEFT
	
LEFT:
	movi	r8, 0
	movi	r7, 0
	movi	r10, 0
	movia	r4, left_word
	br  	LOOP
	
RIGHT:
	movi 	r8, 1
	movi	r7, 0
	movi	r10, 0
	movia	r5, right_word
	br  	LOOP
	
.data	
left_word:
	.word 0x00000079, 0x00000049, 0x00000049, 0x00000049, 0x00000000, 0x00000000, 0x00000000, 0x00000000
right_word:
	.word 0x0000004F, 0x00000049, 0x00000049, 0x00000049, 0x00000000, 0x00000000, 0x00000000, 0x00000000
	
.end
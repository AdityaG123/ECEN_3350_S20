.text
.global sum_two
sum_two:
	addi	sp, sp, -8			# saves 8 bytes in the stack pointer
    stw		ra, 4(sp)			# shifts the return address down 4
    stw		fp, 0(sp)		
	add		r2, r4, r5			#r2 saved as the return register while the r4 and r5 would be the argument registers	
    ldw		fp, 0(sp)			
	ldw		ra, 4(sp)
	addi	sp, sp, 8			# unsaves the 8 bytes int he stack pointer
    ret


.global op_three
op_three:
	addi	sp, sp, -8			
    stw		ra, 4(sp)			
    stw		fp, 0(sp)			
	
	call 	op_two
	mov		r4, r2
	mov		r5, r6
	call 	op_two
	
    ldw		fp, 0(sp)			
	ldw		ra, 4(sp)		
	addi	sp, sp, 8			# saves 12 bites in the stack pointer
    ret

.global fibonacci
fibonacci:
	addi	sp, sp, -16		    # saves 16 bites in the stack pointer
    stw		ra, 12(sp)			
    stw		fp, 8(sp)			
    addi	fp, sp, 8		
    movi	 r5, 1				# checks to see if n = 1, then moves to the fibonacci_one
    beq		 r4, r5, fibonacci_one
    beq		 r4, r0, fibonacci_zero  	# compare if n == 0
  
  # checks to see if n != 1	   
	stw		r4, -4(fp)			# takes the value of n and movies it to the stack
	subi	r4, r4, 1			# subtracts n by 1
	call	fibonacci			# takes the factorial of the previous line

    ldw		r4, -4(fp)			# loads the new value of n
    add		r7, r2, r3			# takes n-1, then adds it to the fibonacci of the n-2
	mov		r3, r2
	mov		r2, r7
	br		fibonacci_last		# moves to last function to deallocate bytes before returning from stack

fibonacci_one:
	movi	r2, 1				# ensures that if the value of n is 1, then the value of n is returned
	movi    r3, 0
	br		fibonacci_last

fibonacci_zero:
	movi	r2, 0				# ensures that if the value of n is 0, then the value  of 0 is returned
  
fibonacci_last:
	mov		sp, fp				# undos whatevery was done at the beginning of the code and deallocates the bytes in the stack
    ldw		ra, 4(sp)			# loads the return address
    ldw		fp, 0(sp)			# loads the original frame pointer
    addi	sp, sp, 8			# moves the frame pointer and the return address back to where it was originally
    ret
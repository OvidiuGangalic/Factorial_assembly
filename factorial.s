.global main 
.global factorial

output: .asciz "%ld"
input: .asciz "%ld"


main:

	#prologue
	pushq %rbp				# push the base pointer 
	movq %rsp, %rbp			# copy the stack pointer into the base pointer

	movq $0, %rax   		#clean the rax
	subq $16, %rsp   		#
	movq $input, %rdi
	leaq -16(%rbp), %rsi
	call scanf
	movq -16(%rbp), %rdi
	
	call factorial

	movq %rax, %rsi  		# copy the final result into the rsi registor so it could be the input for the printf 
	movq $0, %rax			#clean the registor so we can call the printf function
	movq $output, %rdi 		#show what type of output we want 
	call printf

	movq %rbp, %rsp  		# leave the usage from the stack from the main function
	popq %rbp				# restore base pointer location

end:
	
	movq $0, %rdi 
	call exit

factorial:
	
	pushq %rbp
	movq %rsp, %rbp

	cmpq $0, %rdi
	jle fin_0_case		#jumps to the case fin_0_case when it is less or equal.

	pushq $0		#align in a 16 byte 
	pushq %rdi 			#puts rdi in the stack 
	
	
	decq %rdi 

	call factorial

	popq %rdi  			
	mulq %rdi  			#multiply rdi to rax 

	jmp fin

fin_0_case:
	
	movq $1, %rax
	#epilogue
	movq %rbp, %rsp  	# leave the usage from the stack from the main function
	popq %rbp			# restore base pointer location

	ret 


fin: 
	movq %rbp, %rsp  		# copy the adress of the base pointer into stack pointer so it goes in the stack memory from before the function call
	popq %rbp				# restore base pointer location

	ret 
	

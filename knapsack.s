.global knapsack

.equ wordsize, 4

knapsack:
	# unsigned int knapsack(int* weights, unsigned int* values, unsigned int num_items, 
              #int capacity, unsigned int cur_value){

	push %ebp
	movl %esp, %ebp
	subl $1*wordsize, %esp
	
	
	.equ weights, 2*wordsize #(%ebp)
	.equ values, 3*wordsize #(%ebp)
	.equ num_items, 4*wordsize #(%ebp)
	.equ capacity, 5*wordsize #(%ebp)
	.equ cur_value, 6*wordsize #(%ebp)

	.equ best_value, -1*wordsize #(%ebp)

	push %ebx
	push %edi
	push %esi

	# edi is i
	# eax is capacity
	# ecx is weights
	# edx is cur_value
	# esi is num_items
	# ebx is values

	movl capacity(%ebp), %eax
	movl weights(%ebp), %ecx
	movl cur_value(%ebp), %edx
	movl num_items(%ebp), %esi
	movl values(%ebp), %ebx

	# best_value = cur_value;
	movl %edx, best_value(%ebp)


	movl $0, %edi # i = 0;
	for_loop:
		movl capacity(%ebp), %eax
		movl weights(%ebp), %ecx
		movl cur_value(%ebp), %edx
		# i < num_items
		# i - num_items < 0
		# Negation: i - num_items >= 0
		cmpl %esi, %edi
		jae end_for_loop

		# capacity - weights[i] >= 0
		# Negation: capacity - weights[i] < 0
		cmp (%ecx, %edi, wordsize), %eax #if(capacity - weights[i] >= 0 )
		jb recursion_done

	recursion:
		# setting up 
		movl cur_value(%ebp), %eax #putting cur_value in eax
		addl (%ebx, %edi, wordsize), %eax #cur_value + values[i]
		push %eax

		movl capacity(%ebp), %eax
		subl (%ecx, %edi, wordsize), %eax #capacity - weights[i]
		push %eax

		# num_items - i - 1
		movl num_items(%ebp), %eax	
		subl $1, %eax
		subl %edi, %eax 
		push %eax

		#values + i + 1
		movl values(%ebp), %eax
		leal wordsize(%eax, %edi, wordsize), %eax 
		push %eax

		#weights + i + 1
		movl weights(%ebp), %eax
		leal wordsize(%eax, %edi, wordsize), %eax 
		push %eax

		call knapsack
		addl $5*wordsize, %esp 
		
		# best_value is stored in eax.

		movl weights(%ebp), %ecx
		movl cur_value(%ebp), %edx
		
		cmpl %eax, best_value(%ebp)
		jb get_number
		
		cmpl %eax, best_value(%ebp)
		jae recursion_done
	
	get_number:
		movl %eax, best_value(%ebp)
		jmp recursion_done
	

	recursion_done:
		incl %edi
		jmp for_loop
	
	end_for_loop:

	# Epilogue
	pop %esi
	pop %edi
	pop %ebx	
	movl best_value(%ebp), %eax
	movl %ebp, %esp
	pop %ebp
	ret
	################ DONE WITH CODE SECTION ########################
	



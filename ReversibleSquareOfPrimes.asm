.text
#progra that implements the functions to reverse numbers
#it tries to use registers as convention as they are set
main:
jal print

li $v0,10
syscall


.data

number:.word 169

.text
reverse:
	add $v0,$zero,0 #initiating return type to 0( a revered word)
	#test if the number to be reversed is greater then zero
	while:
	sgt $t0,$a1,$zero
	beqz $t0,endReverse
	#(reversed*10)
	mul $t1,$v0,10
	#(num%10)
	rem $t2,$a1,10
	#this our return value so store it in either register $v0 or $v1 
	add $v0,$t1,$t2
	div $a1,$a1,10
	#loop back to while
	b while
endReverse:
	jr $ra
	
compare:
	#arguments to this function are $a1,and $a2
	
	#arguments don'tcompare by default
	add $v0,$zero,0
	seq $v0,$a1,$a0
	
	
	
	jr $ra
	
isPrime:
	#takes $a1 as the parameter
	#default a number to prime
	li $v0,1
	
	#if a number is less than 2 then its not prime
	li $t0,2
	sgt $v0,$a1,$t0
	beqz  $v0,endLoop
	
	#test if is devisible 
	
	#store in $to input/2 (end of loop)
	div $t0,$a1,2
	#initialise the iterator i.e "i"
	#test factors from two 
	li $t1,2
	start:
	
		sle $t2,$t1,$t0
		beqz $t2,endLoop
		
		#if (num%iterator)==0
		rem $t3,$a1,$t1
		#iterator ++
		addu $t1,$t1,1
		#if remainder is 1 loop again  otherwise its not prime
		bnez $t3,start
		addu $v0,$v0,-1
		
	endLoop:
		jr $ra
		
isASquareRootOfReversiblePrimeSquare:
		#assumes it takes $a1 as argument
		
		
		
		#number is not a reversible by default
		addi $v0,$zero,0
		
		addi $sp,$sp,-4
		sw $ra,0($sp)
		#since both are passed $a1 as the parameters
		jal isPrime
		#value is returned in $v0
		beqz $v0,disqualified
		
		
		#squareNumber
		mul $a1,$a1,$a1
		# reverse fuction value returned in $v0
		
		jal reverse
		#it returns revesedSquareNumber
		move $a0,$v0
		jal compare
		
		#move $t0,$v0
		#branc if they compare ie $v0=1
		bnez  $v0,disqualified
		li $t0,2
		
		div $t1,$a0,2
		startLoop:
			sle $t2,$t0,$t1
			beqz $t2,disqualified
			mul $t3,$t0,$t0 #potential squareNumber
			seq  $t4,$t3,$a0
			beqz $t4,startLoop
			#move $t3 into $a1 as it is the square number and we want to test is prime
			
			move $a1,$t3
			jal isPrime
			
			
			b disqualified
		
		disqualified:
		#clean stack
		lw $ra,0($sp)
		addi $sp,$sp,4
		
		jr $ra
		
			
			
		
print:
	#load most of the variables into the stack for they are updated in isAReversiblePrimeSquare,
	add $sp,$sp,-20
	sw $ra,0($sp)
	
	
	li $t0,2000
	#use $a1 as an iterator as it is going to be passed as the argument of isAReversiblePrimeSquare (potentialSquareOfThePrime)
	li $a1,2
	sw $t0,4($sp) #endloop
	sw $a1,8($sp) #iterator
	
	#handles the issue, number of isAReversiblePrimeSquare printed already
	li $t1,10
	li $t2,0
	sw $t1,12($sp)
	sw $t2,16($sp)
	
	test:
		#test if we have not printed 10 arealdy, exit  subprogram if the case 
		lw $t1,12($sp)
		lw $t2,16($sp)
		#no need to store $t3 in stack 
		slt $t3,$t2,$t1
		beqz $t3,finish
		lw $a1,8($sp) #load the iterator
		jal isASquareRootOfReversiblePrimeSquare
		#returns value into the $v0 register
		#since $a1 was an argument to isASquareRootOfReversiblePrimeSquare,it was prone to modification , reload $a0,from the stack
		
		#increment $a1 and push it back into the stack, incase $a1 is a not ASquareRootOfReversiblePrimeSquare
		lw $a1,8($sp)
		addi $a1,$a1,1 
		sw $a1,8($sp)
		
		beqz $v0,test
		
		#but if indeed $a1 was ASquareRootOfReversiblePrimeSquare,then we shouldnt have added a one hence modification
		lw $a1,8($sp)
		addu $a1,$a1,-1
		
		#the printing now
		#since we have ASquareRootOfReversiblePrimeSquare, square to obtain aReversibleSquareOfAPrime
		mul $a0,$a1,$a1
		li $v0,1
		syscall
		
		#printed++
		#pop,increment and push
		lw $t2,16($sp)
		add $t2, $t2,1
		sw $t2,16($sp)
		jal printNewLine
		#go searching for another ReversibleSquareOfThePrime
		b test
	finish:
		
		lw $ra,0($sp)
		#since i requested 20 bytes of memory from stack i have to free that memory
		add $sp,$sp,20
		
		jr $ra
printNewLine:
	la $a0,text
	li $v0,4
	syscall
jr $ra

.data
text: .asciiz "\n"

.text 
.globl main

main:
	li $v0, 5
	syscall
	move $a0, $v0
	jal somatorio
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	
somatorio:
	bne $a0, 1, recursao
	li $v0, 1
	jr $ra
	 
recursao:
	# Prólogo da recursão, onde a gente salva o endereço de memória de retorno atual e o valor atual.
	 addi $sp, $sp, -8
	 sw $ra, 4($sp)
	 sw $a0, 0($sp)
	 
	 # A recursão em si vem nessa parte
	 addi $a0, $a0, -1
	 jal somatorio
	 
	 lw $a0, 0($sp)
	 lw $ra, 4($sp)
	 addi $sp, $sp, 8
	 
	 add $v0, $a0, $v0
	 
	 jr $ra
	 
	

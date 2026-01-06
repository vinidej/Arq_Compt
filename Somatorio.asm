#1) O programa implementa o cálculo do somatório de um número N e ao final imprime todos os números de N até 0. 
#É simples mas contém desvio condicional, repetição, funções, recursividade e sequencial. 5 dos 6 pedidos no trabalho.

.text 
.globl main #Defino que o main é um escopo global

main:
	li $v0, 5 #Gravo o valor 5 no $v0, e chamo o syscall que indica que o sistema irá ler um inteiro.
	syscall #Chamada do sistema
	move $a0, $v0 #Movo do $v0 para o reg. $a0. Isso ocorre pq usamos o v0 para saídas e o a0 para entrada de dados.
	jal somatorio #Faço um 'Jump and Link', ou seja, ele pula para somatorio e registra o endereço de memória de PC + 4 num registrador chamado $ra
	move $a0, $v0 #Após retornar do Jump and Link ele move o valor retornada da função que está guardado em $v0 para $a0
	li $v0, 1 #Apenas para poder gravar o valor 1(significa "Imprima um inteiro") no $v0 sem perder o dado que seria sobreescrito
	syscall #chamo o sistema, ele imprime o valor que está em $a0
	move $t0, $a0 #movo para registrador temporario, explicarei abaixo o motivo
	li $v0, 11	#Gravo em v0 o codigo de impressão de um caracter
	li $a0, 10	#Gravo em a0 o codigo correspondente a o \n na tabela ascii
	syscall		#Sistema imprime o que está em a0 e como o cdoigo em v0 é para caracter ele imprime o codigo da tabela ascii
	#Por esse motivo que eu passo o valor de a0 para t0, para não ser sobreescrito
	jal imprimir_numeros	#Chamo a função que implementa um for para imprimir todos os números de N até 0	
	li $v0, 10 #Gravo o valor 10(Que significa "Encerre o programa") no $v0
	syscall #chamo o sistema onde ver o valor 10 e encerra o programa

somatorio:
	beq $a0, 1, retorno #"Brench if Equal", se o valor no $a0 for == 1 então pule para retorno
	 
	# Prólogo da recursão, onde a gente salva o endereço de memória de retorno atual e o valor atual.
	 addi $sp, $sp, -8 #Crio espaço na pilha fazendo um $sp receber o valor que já está nele -8. Então criei 8 espaços a mais.
	 sw $ra, 4($sp) #guardo no endereço de memoria de $sp + 4 o valor que está em $ra, ou seja, o endereço de retorno atual
	 sw $a0, 0($sp) #e guardo em $sp + 0 o valor atual da recursão que está em $a0

	#Depois que eu preparei o sistema e suas variáveis, posso chamar a recursão sem sobreescrever os dados.
	#Em C o programa está na parte de: return N + somatorio(N - 1)
	#Então eu preparo esse N - 1 para ser jogado na recursão

	 # A recursão em si vem nessa parte
	 addi $a0, $a0, -1 #Somo addi(soma de um imediato com sinal. Se fosse add ele esperava soma entre registradores) com -1
	 jal somatorio #agora que o valor atual foi decrementado ou seja, N - 1, chamo a função recursivamente.
	 
	 lw $a0, 0($sp) #Retornando da recursão, recuperamos o valor que foi guardado anteriormente e guardamos em $a0
	 lw $ra, 4($sp) #E o mesmo para o endereço de retorno do anterior
	 addi $sp, $sp, 8 #E removemos o espaço que foi separado na pilha para guardar esses valores
	 
	 add $v0, $a0, $v0 #$v0 recebe o valor dele mesmo somado com o valor retornado do anterior.
	 
	 jr $ra #"Jump Register" onde pula para o endereço de memoria daquele registrador e continua

retorno:
	li $v0, 1 #Grava 1 no $v0. Dessa vez não é para imprimir um inteiro, é o valor 1 de fato que retorna no caso base
	jr $ra #"Jump Register" ele pula para o endereço de memória daquele registrador e continua
	
	
retorno_imprimir_numeros:
	jr $ra	#Apenas pula para endereço salvo de retorno em $ra

imprimir_numeros:
	bltz $t0, retorno_imprimir_numeros #"Branch low then zero" Se t0 for menor que 0, pule para essa função
	li $v0, 1	#grava em v0 o codigo referente a impressão de um inteiro
	move $a0, $t0	#move de t0 para a0 pois o sistema so lê do a0
	syscall		#Chama o sistema
	li $v0, 11	#Mesma coisa para imprimir o \n
	li $a0, 10	#Escreve o codigo de \n na tabela ascii em a0
	syscall		#imprime o \n
	addi $t0, $t0, -1	#Soma o valor em t0 com -1 para imprimir o proximo
	j imprimir_numeros #Pula para inicio da função novamente. Note que não precisa de link pois não preciso guardar nada da ultima iteração
	
	
#2) O programa já era bem simples antes no C, em Assembly Mips só notei a otimização de que a linguagem ta conversando com a máquina
#mais direto do que a linguagem C, então é mais rápido. Mas fora isso eu não notei muita coisa pq o programa já é naturalmente bem simples

#Algo interessante de se notar foi que um laço for, e uma função recursiva são basicamente a mesma coisa com o diferencial de que
#a recursiva salva as informações que ela precisa na pilha, como endereço do retorno e valor naquele momento.
#O for faz a mesma coisa, mas não salva nada da ultima iteração. Algo besta mas que só notei agora no assembly

#Curiosidade: Enquanto fazia, o sistema imprimia na saída alguns valores "loucos" e após sair do Main voltava para o somatorio
#Foi então que eu percebi que faltava o encerramento do programa, o que não é necessário em C a linguagem que foi traduzida
#Uma pequena curiosidade de uma experiência simples mas para um programador inciante em assembly achei interessante.

# A program that divides two integers according to the approach described in Fig. 3.12

.data   # Data declaration section

.text

main:       # Start of code section 
li $s2, 4 # dividend, will als0 be used as the remainder register which will hold remainder and quotient initialized to dividend
li $s3, 2 # divisor

li $s4, 2 # another register to hold the dividend shifted 6 bits, for adding and subtracting dividend from remainder
sll $s4, $s4, 6

li $t0, 0 # counter of the loop

LOOP:   sll $s2, $s2, 1 # shift the remainder regitser by 1 bit to right
sub $s2, $s2, $s4 # subtract divisor from remainder part of the remainder register

slt $t1, $s2, $zero # to check if rem < 0
beq $t1, $zero, MORE # if rem no < 0 then branch to MORE label
nop

add $s2, $s2, $s4 # if rem < 0, to add the divisor to the remainder part of the remainder register

j LOOP # jump back to the loop
nop

MORE:   # if rem > 0, then do arithmetic right shift and place 1 as the 0th position
rol $s2, $s2, 1 # rotate the number to the left by 1 bit which is arithmetic right shift

j LOOP # jump back to loop
nop

addi $t0, $t0, 1 # adding 1 to the counter of the loop
slti $t1, $t0, 6 # checking if the loop condition is working or not
bne $t1, $zero, LOOP
nop

add $a0, $zero, $s2 # putting the result in regitser a0

li $v0, 1 # printing out the result
syscall

# END OF PROGRAM

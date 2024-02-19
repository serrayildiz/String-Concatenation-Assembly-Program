#SERRA YILDIZ 1904010018
#MEHMET KAYA 2004010026

# In this section, we declare strings terminated with null characters using the .asciiz directive

.data
string1:    .asciiz "Hello, "
string2:    .asciiz "world!"
string3:    .asciiz " This is a concatenated string."
specialChar: .asciiz "Z"

# Program execution starts at the main tag

.text
main:

     # In these lines load the addresses of the original strings into $a0 and then call the printString function to print each string.
    la $a0, string1
    jal printString
    la $a0, string2
    jal printString
    la $a0, string3
    jal printString

     # Here, the addresses of string and string 2 are loaded into $a0 and $a1 respectively and the concatStrings function is called to concatenate these two strings.
    la $a0, string1   
    la $a1, string2   
    # We call the merge function
    jal concatStrings 

    # Prints the concatenated string
    la $a0, string1
    jal printString

    # Exit program
    li $v0, 10 # Loads system call number for program exit
    syscall # Makes a system call to terminate the program

concatStrings:
    # $a0 = destination address
    # $a1 = source address

    concatLoop:
        lb $t0, 0($a0)       # Loads byte from destination
        beq $t0, 0, endConcat # If null, the program ends.

        addi $a0, $a0, 1      # Moves to the next byte in the destination
        j concatLoop

    endConcat:
       # This part is for copying bytes from source to destination
        copyLoop:
            lb $t1, 0($a1)   # Loads byte from source
            sb $t1, 0($a0)   # Stores byte to destination
            beq $t1, 0, endCopy # If null, the program ends.

            addi $a0, $a0, 1  # Moves to the next byte in destination
            addi $a1, $a1, 1  # Moves to the next byte in source
            j copyLoop

        endCopy:
            jr $ra

#The printString function uses system call 4 to print the null-terminated string whose address is located in record $a0. And then it returns to the caller using $ra. 

printString:
    li $v0, 4           
    syscall
    jr $ra



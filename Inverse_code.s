.data
zero_float:
    .float 0.0

precision: 
    .float 0000.0

matrix: 
    # .float 0.0, 2.0, 1.0
    # .float 1.0, -1.0, 3.0
    # .float 2.0, 3.0, 4.0

    # .float 3.0, 6.0, 3.0, 4.0, 3.0
    # .float 3.0, 6.0, 3.0, 4.0, 3.0
    # .float 2.0, 9.0, 6.0, 6.0, 9.0
    # .float 9.0, 5.0, 3.0, 0.0, 4.0
    # .float 2.0, 0.0, 1.0, 9.0, 6.0

    .float 2.0, 1.0, 3.0, 4.0, 5.0
    .float 1.0, 0.0, 4.0, 3.0, 2.0
    .float 3.0, 4.0, 0.0, 1.0, 5.0
    .float 4.0, 5.0, 1.0, 0.0, 3.0
    .float 5.0, 2.0, 1.0, 4.0, 0.0

    # .float 3.0, 6.0, 3.0, 4.0, 3.0
    # .float 3.0, 6.0, 3.0, 4.0, 3.0
    # .float 2.0, 9.0, 6.0, 6.0, 9.0
    # .float 9.0, 5.0, 3.0, 0.0, 4.0
    # .float 2.0, 0.0, 1.0, 9.0, 6.0

    # .float 1.0, 0.0
    # .float 0.0, 9.0

verification_matrix:
    .float 2.0, 1.0, 3.0, 4.0, 5.0
    .float 1.0, 0.0, 4.0, 3.0, 2.0
    .float 3.0, 4.0, 0.0, 1.0, 5.0
    .float 4.0, 5.0, 1.0, 0.0, 3.0
    .float 5.0, 2.0, 1.0, 4.0, 0.0

    # .float 3.0, 6.0, 3.0, 4.0, 3.0
    # .float 3.0, 6.0, 3.0, 4.0, 3.0
    # .float 2.0, 9.0, 6.0, 6.0, 9.0
    # .float 9.0, 5.0, 3.0, 0.0, 4.0
    # .float 2.0, 0.0, 1.0, 9.0, 6.0

    # .float 1.0, 2.0, 3.0, 4.0, 5.0
    # .float 2.0, 3.0, 4.0, 5.0, 6.0
    # .float 3.0, 4.0, 5.0, 6.0, 7.0
    # .float 4.0, 5.0, 6.0, 7.0, 8.0
    # .float 5.0, 6.0, 7.0, 8.0, 9.0

    # .float 3.0, 6.0, 3.0, 4.0, 3.0
    # .float 3.0, 6.0, 3.0, 4.0, 3.0
    # .float 2.0, 9.0, 6.0, 6.0, 9.0
    # .float 9.0, 5.0, 3.0, 0.0, 4.0
    # .float 2.0, 0.0, 1.0, 9.0, 6.0


    # .float 1.0, 0.0
    # .float 0.0, 9.0
store_matrix:
    .float 0.0, 0.0, 0.0, 0.0, 0.0
    .float 0.0, 0.0, 0.0, 0.0, 0.0
    .float 0.0, 0.0, 0.0, 0.0, 0.0
    .float 0.0, 0.0, 0.0, 0.0, 0.0
    .float 0.0, 0.0, 0.0, 0.0, 0.0

inverse: 
    # .float 1.0, 0.0, 0.0, 0.0
    # .float 0.0, 1.0, 0.0, 0.0
    # .float 0.0, 0.0, 1.0, 0.0
    # .float 0.0, 0.0, 0.0, 1.0

    .float 1.0, 0.0, 0.0, 0.0, 0.0
    .float 0.0, 1.0, 0.0, 0.0, 0.0
    .float 0.0, 0.0, 1.0, 0.0, 0.0
    .float 0.0, 0.0, 0.0, 1.0, 0.0
    .float 0.0, 0.0, 0.0, 0.0, 1.0
    # .float 1.0, 0.0
    # .float 0.0, 1.0

str_no_inverse:
        .string "Inverse not exists\n"

str_verfication:
        .string "\n\nMatrix after multiplying by its inverse\n"

str_newline:
        .string "\n"

add_space:
        .string "  "
# Registers:
# t0, t1, t2, t3, ... used as general-purpose registers for indexing and calculations
# f0, f1, ... used for floating-point operations (if available)

# Base address of the matrix in memory
.text
.globl _start
_start:
la s4, matrix
la s8, inverse
la s9, store_matrix

li t0, 0      # Initialize i = 0
li t1, 5

loop_start:
    bge t0, t1, loop_end   # if i >= n, exit the loop

    # Loop body here
    # Calculate the address of matrix[i][i]
    la t6, matrix
    mul t3, t0, t1           # t5 = i * n (row i's base address offset)
    add t3, t3, t0           # t5 = i * n + i (element [i][i])
    slli t3, t3, 2           # t5 = (i * n + i) * 8 (each double is 8 bytes)
    add t3, t3, t6           # t5 now holds the address of matrix[i][i]
    

    # Load the value of matrix[i][i] into floating-point register f0
    flw f0, 0(t3)            # Load the double precision value at matrix[i][i] into f0

    # Compare matrix[i][i] with 0.0

    la s1, zero_float       # Move 0.0 (represented by integer 0) into floating-point register f1
    flw f1, 0(s1)

    # la s2, precision
    # flw f4, 0(s2)
    # fmul.s f0, f0, f4

    feq.s t3, f0, f1         # t6 = (matrix[i][i] == 0.0), result is in t6

    # Conditional branch based on comparison
    beqz t3, handle_zero     # if matrix[i][i] == 0, jump to handle_zero

    li t3, 0 # if loop body  
    li a3, 1
    add t2, t0, a3      # j = i + 1 (initialize j)

    loop_j_start:
        bge t2, t1, loop_j_end  # if j >= n, exit the loop

        # Loop body here (when j < n)
         # Calculate the address of matrix[j][i]
        la t6, matrix
        mul t5, t2, t1          # t5 = j * n (row j's base address offset)
        add t5, t5, t0          # t5 = j * n + i (element [j][i])
        slli t5, t5, 2          # t5 = (j * n + i) * 4 (each double is 4 bytes)
        #add t5, t5, t3  
        add t5, t5, t6        # t5 now holds the address of matrix[j][i]

        # Load the value at matrix[j][i] into floating-point register f0
        flw f0, 0(t5)           # Load the double precision value at matrix[j][i] into f0

        # Compare matrix[j][i] with 0.0
        la s1, zero_float       # Move 0.0 (represented by integer 0) into floating-point register f1
        flw f1, 0(s1)           # Move 0.0 into floating-point register f1
        feq.s t6, f0, f1        # t6 = (matrix[j][i] == 0.0), result in t6

        # Conditional branch based on the comparison
        bnez t6, skip_if_body   # if matrix[j][i] == 0, skip the if-body

        # If-body here (when matrix[j][i] != 0)
        # ...
        # Initialize k = 0
        li t4, 0                   # k = 0

        loop_p_start:
            bge t4, t1, loop_p_end  # if k >= n, exit the loop

            # Loop body for the for (int k = 0; k < n; k++) loop

            # ... (Insert actual loop body here)
            # Calculate the address of matrix[i][k]
            la t6, matrix 
            mul t5, t0, t1             # t5 = i * n (row i's base address offset)
            add t5, t5, t4             # t5 = i * n + k (element [i][k])
            slli t5, t5, 2             # t5 = (i * n + k) * 4 (each double is 4 bytes)
            #add t5, t5, t3             # t5 now holds the address of matrix[i][k]
            add t5, t6, t5

            # Load the value at matrix[i][k] into floating-point register f0
            flw f0, 0(t5)              # temp = matrix[i][k]

            # Calculate the address of matrix[j][k]
            la s0, matrix
            mul t6, t2, t1             # t6 = j * n (row j's base address offset)
            add t6, t6, t4             # t6 = j * n + k (element [j][k])
            slli t6, t6, 2             # t6 = (j * n + k) * 4 (each double is 4 bytes)
            #add t6, t6, t3             # t6 now holds the address of matrix[j][k]
            add t6, t6, s0

            # Load the value at matrix[j][k] into floating-point register f1
            flw f1, 0(t6)              # f1 = matrix[j][k]

            # Store the value of matrix[j][k] into matrix[i][k]
            fsw f1, 0(t5)              # matrix[i][k] = matrix[j][k]

            # Store the value of temp (f0) into matrix[j][k]
            fsw f0, 0(t6)              # matrix[j][k] = temp

            # Increment k
            addi t4, t4, 1          # k++

            # Jump back to the start of the k loop
            j loop_p_start

        loop_p_end:
            # End of the k loop

        li t4, 0                   # k = 0

        loop_q_start:
            bge t4, t1, loop_q_end  # if k >= n, exit the loop

            # Loop body for the for (int k = 0; k < n; k++) loop

            # ... (Insert actual loop body here)
            # Calculate the address of matrix[i][k]
            la t6, inverse
            mul t5, t0, t1             # t5 = i * n (row i's base address offset)
            add t5, t5, t4             # t5 = i * n + k (element [i][k])
            slli t5, t5, 2             # t5 = (i * n + k) * 4 (each double is 4 bytes)
            #add t5, t5, t3             # t5 now holds the address of matrix[i][k]
            add t5, t6, t5

            # Load the value at matrix[i][k] into floating-point register f0
            flw f0, 0(t5)              # temp = matrix[i][k]

            # Calculate the address of matrix[j][k]
            la s7, inverse
            mul t6, t2, t1             # t6 = j * n (row j's base address offset)
            add t6, t6, t4             # t6 = j * n + k (element [j][k])
            slli t6, t6, 2             # t6 = (j * n + k) * 4 (each double is 4 bytes)
            add t6, t6, s7             # t6 now holds the address of matrix[j][k]

            # Load the value at matrix[j][k] into floating-point register f1
            flw f1, 0(t6)              # f1 = matrix[j][k]

            # Store the value of matrix[j][k] into matrix[i][k]
            fsw f1, 0(t5)              # matrix[i][k] = matrix[j][k]

            # Store the value of temp (f0) into matrix[j][k]
            fsw f0, 0(t6)              # matrix[j][k] = temp

            # Increment k
            addi t4, t4, 1          # k++

            # Jump back to the start of the k loop
            j loop_q_start

        loop_q_end:
            
            li t3, 1
            j if_cond

        skip_if_body:
            addi t2, t2, 1
            j loop_j_start

        loop_j_end:

        if_cond:
            beqz t3, exit
            j handle_zero

exit:
    j print_no_inverse

print_no_inverse:
    addi a0,x0,4
    la a1, str_no_inverse   # Load address of the string
    ecall                           # Print the string
    j exit_program

handle_zero:
    # Calculate the address of matrix[i][i]
        la t6, matrix
        mul t5, t0, t1             # t5 = i * n (row i's base address offset)
        add t5, t5, t0             # t5 = i * n + i (element [i][i])
        slli t5, t5, 2             # t5 = (i * n + i) * 4 (each double is 4 bytes)
        #add t5, t5, t3             # t5 now holds the address of matrix[i][i]
        add t5, t6, t5

        # Load the value at matrix[i][i] into floating-point register f0
        flw f1, 0(t5)              # pivot = matrix[i][i]

        # Initialize j = 0
        li t2, 0                   # j = 0

        loop_r_start:
            # Check if j >= n
            bge t2, t1, loop_r_end  # if j >= n, exit the loop

            # Loop body
            # ...
            # Calculate the address of matrix[i][j]
            la t6, matrix
            mul t5, t0, t1             # t5 = i * n (row i's base address offset)
            add t5, t5, t2             # t5 = i * n + j (element [i][j])
            slli t5, t5, 2             # t5 = (i * n + j) * 4 (each double is 4 bytes)
            #add t5, t5, t3             # t5 now holds the address of matrix[i][j]
            add t5, t6, t5

            # Load the value of matrix[i][j] into floating-point register f0
            flw f0, 0(t5)              # f0 = matrix[i][j]

            # Divide matrix[i][j] by pivot
            fdiv.s f0, f0, f1          # f0 = f0 / f1 (matrix[i][j] /= pivot)

            # Store the result back into matrix[i][j]
            fsw f0, 0(t5)              # matrix[i][j] = result of division

            la t6, inverse
            mul t5, t0, t1             # t5 = i * n (row i's base address offset)
            add t5, t5, t2             # t5 = i * n + j (element [i][j])
            slli t5, t5, 2             # t5 = (i * n + j) * 4 (each double is 4 bytes)
            #add t5, t5, t3             # t5 now holds the address of inverse[i][j]
            add t5, t6, t5

            # Load the value of matrix[i][j] into floating-point register f0
            flw f0, 0(t5)              # f0 = matrix[i][j]

            # Divide matrix[i][j] by pivot
            fdiv.s f0, f0, f1          # f0 = f0 / f1 (matrix[i][j] /= pivot)

            # Store the result back into matrix[i][j]
            fsw f0, 0(t5)              # matrix[i][j] = result of division

            # Increment j
            addi t2, t2, 1          # j++

            # Jump back to the start of the loop
            j loop_r_start

        loop_r_end:
            # End of the j loop

        # Initialize j = 0
        li t2, 0                   # j = 0

        loop_s_start:
            # Check if j >= n
            bge t2, t1, loop_s_end  # if j >= n, exit the loop

            # Loop body
            # ...
            beq t2, t0, break
            # Calculate the address of matrix[j][i]
            la t6, matrix
            mul t5, t2, t1             # t5 = j * n (row j's base address offset)
            add t5, t5, t0             # t5 = j * n + i (element [j][i])
            slli t5, t5, 2             # t5 = (j * n + i) * 4 (each double is 4 bytes)
            #add t5, t5, t3             # t5 now holds the address of matrix[j][i]
            add t5, t6, t5

            # Load the value of matrix[j][i] into floating-point register f2
            flw f2, 0(t5)              # factor = matrix[j][i]

            # Initialize k = 0
            li t4, 0                   # k = 0

            loop_k_start:
                # Check if k >= n
                bge t4, t1, loop_k_end  # if k >= n, exit the loop

                # Loop body
                # ...
                # Calculate the address of matrix[j][k]
                la t6, matrix
                mul t5, t2, t1             # t5 = j * n (row j's base address offset)
                add t5, t5, t4             # t5 = j * n + k (element [j][k])
                slli t5, t5, 2             # t5 = (j * n + k) * 4 (each double is 4 bytes)
                #add t5, t5, t3             # t5 now holds the address of matrix[j][k]
                add t5, t6, t5

                # Load the value of matrix[j][k] into floating-point register f0
                flw f0, 0(t5)              # f0 = matrix[j][k]

                # Calculate the address of matrix[i][k]
                la a2, matrix
                mul t6, t0, t1             # t6 = i * n (row i's base address offset)
                add t6, t6, t4             # t6 = i * n + k (element [i][k])
                slli t6, t6, 2             # t6 = (i * n + k) * 4 (each double is 4 bytes)
                #add t6, t6, t3             # t6 now holds the address of matrix[i][k]
                add t6, t6, a2

                # Load the value of matrix[i][k] into floating-point register f1
                flw f1, 0(t6)              # f1 = matrix[i][k]

                # Multiply factor (f2) by matrix[i][k] (f1)
                fmul.s f3, f2, f1         # f3 = f2 * f1 (factor * matrix[i][k])

                # Subtract the result from matrix[j][k]
                fsub.s f0, f0, f3         # f0 = f0 - f3 (matrix[j][k] -= factor * matrix[i][k])

                # Store the result back into matrix[j][k]
                fsw f0, 0(t5)             # matrix[j][k] = result of subtraction

                la t6, inverse                  # for inverse matrix
                mul t5, t2, t1             # t5 = j * n (row j's base address offset)
                add t5, t5, t4             # t5 = j * n + k (element [j][k])
                slli t5, t5, 2             # t5 = (j * n + k) * 4 (each double is 4 bytes)
                #add t5, t5, t3             # t5 now holds the address of matrix[j][k]
                add t5, t6, t5

                # Load the value of matrix[j][k] into floating-point register f0
                flw f0, 0(t5)              # f0 = matrix[j][k]

                # Calculate the address of matrix[i][k]
                la a2, inverse
                mul t6, t0, t1             # t6 = i * n (row i's base address offset)
                add t6, t6, t4             # t6 = i * n + k (element [i][k])
                slli t6, t6, 2             # t6 = (i * n + k) * 4 (each double is 4 bytes)
                #add t6, t6, t3             # t6 now holds the address of matrix[i][k]
                add t6, t6, a2

                # Load the value of matrix[i][k] into floating-point register f1
                flw f1, 0(t6)              # f1 = matrix[i][k]

                # Multiply factor (f2) by matrix[i][k] (f1)
                fmul.s f3, f2, f1         # f3 = f2 * f1 (factor * matrix[i][k])

                # Subtract the result from matrix[j][k]
                fsub.s f0, f0, f3         # f0 = f0 - f3 (matrix[j][k] -= factor * matrix[i][k])

                # Store the result back into matrix[j][k]
                fsw f0, 0(t5)             # matrix[j][k] = result of subtraction


                # Increment k
                addi t4, t4, 1          # k++

                # Jump back to the start of the loop
                j loop_k_start

            loop_k_end:
    # End of the k loop

    # # Jump back to the start of the loop
    # j loop_k_start

    break:

        # Increment j
            addi t2, t2, 1          # j++

            # Jump back to the start of the loop
            j loop_s_start

        loop_s_end:
            # End of the j loop

        # Continue with the outer loop or if-body after the k-loop

    addi t0, t0, 1         # i++
    j loop_start           # Jump back to the start of the loop

loop_end:
    li t2, 0
    mv t3, t1
    mv s0, s8
    mul t3, t3, t3
    outer_loop_inverse:
        li t4, 1
    inner_loop:
        beq t2, t3, verification_module
        mv t5, t1
        addi a0, x0, 34
        lw a1, 0(s0)
        ecall
        addi a0, x0, 4
        blt t4, t5, not_new_line_inverse
        la a1, str_newline         # Load a1 with the length of the string (1)
        ecall                      # Print the newline character
        not_new_line_inverse:
        addi s0, s0, 4
        addi t2, t2, 1
        beq t4, t5, outer_loop_inverse
        addi t4, t4, 1
        j inner_loop
    # Loop ends here

verification_module:
    li t5, 0
      
        print_loop1:
            beq t5, t1, print_loop1_end

            li s7, 0

        print_loop2:    
            beq s7, t1, print_loop2_end

            la s1, zero_float       # Move 0.0 (represented by integer 0) into floating-point register f1
            flw f0, 0(s1)  
            li t4, 0
            li s5, 0     

            print_loop3:
                beq t4, t1, print_loop3_end

                la a2, inverse
                mul s3, t5, t1
                add s3, s3, t4
                slli s3, s3, 2             # t6 = (i * n + k) * 4 (each double is 4 bytes)
                add a2, a2, s3             # t6 now holds the address of matrix[i][k] 

                flw f1, 0(a2)

                la a2, verification_matrix
                mul s2, t4, t1
                add s2, s2, s7
                slli s2, s2, 2             # t6 = (i * n + k) * 4 (each double is 4 bytes)
                add a2, a2, s2             # t6 now holds the address of matrix[i][k] 

                flw f2, 0(a2)

                fmul.s f3, f2, f1
                fadd.s f0, f0, f3

                addi s5, s5, 1
                addi t4, t4, 1

                j print_loop3


            print_loop3_end:

                la a2, store_matrix
                mul s2, t5, t1
                add s2, s2, s7
                slli s2, s2, 2             # t6 = (i * n + k) * 8 (each double is 8 bytes)
                add a2, a2, s2

                fsw f0, 0(a2) 

                addi s7, s7,1 
                j print_loop2

        print_loop2_end:

            addi t5, t5, 1

            j print_loop1

    print_loop1_end:

        j loop_end_verification
            
loop_end_verification:
    li t2, 0
    mv t3, t1
    mv s0, s9
    mul t3, t3, t3
    addi a0, x0, 4
    la a1, str_verfication         # Load a1 with the length of the string (1)
    ecall 
    outer_loop_verification:
        li t4, 1
    inner_loop_verification:
        beq t2, t3, exit_program
        mv t5, t1
        addi a0, x0, 34
        lw a1, 0(s0)
        ecall
        addi a0, x0, 4
        blt t4, t5, not_new_line 
        la a1, str_newline         # Load a1 with the length of the string (1)
        ecall
        not_new_line:                      # Print the newline character
        addi s0, s0, 4
        addi t2, t2, 1
        beq t4, t5, outer_loop_verification
        addi t4, t4, 1
        j inner_loop_verification
    
exit_program:
    li a1, 10    # System call code for program exit
    ecall        # Invoke the system call
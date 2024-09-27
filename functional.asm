; Interpret as 64 bits code
[bits 64]

; nu uitati sa scrieti in feedback ca voiati
; assembly pe 64 de biti

section .text
global map
global reduce
map:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp

    ; sa-nceapa turneu'

    ; contor
    xor rbx, rbx

for_loop_map:
    cmp rbx, rdx
    je end_map

    push rdi

    ; accesez elementul din vector, din src
    mov rdi, [rsi + 8 * rbx]
    call rcx

    pop rdi
    ; pun in vector
    mov [rdi + 8 * rbx], rax

    inc rbx
    jmp for_loop_map

end_map:
    leave
    ret

; int reduce(int *dst, int *src, int n, int acc_init, int(*f)(int, int));
; int f(int acc, int curr_elem);
reduce:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp

    ; sa-nceapa festivalu'

    ; acc = acumulator_initial
    mov r10, rcx

    ; salvez src
    mov r9, rsi

    ; contor
    xor rbx, rbx

for_loop_reduce:
    cmp rbx, rdx
    jge end_reduce
    push rdx

    ; accesez elementul din vector
    mov rsi, [r9 + 8 * rbx]
    mov rdi, r10
    call r8
    mov r10, rax
    ; pun rezultatul in rax
    mov rax, r10

    pop rdx

    inc rbx
    jmp for_loop_reduce

end_reduce:
    leave
    ret


; Interpret as 32 bits code
[bits 32]

%include "../include/io.mac"

section .text
; int check_parantheses(char *str)
global check_parantheses
check_parantheses:
    push ebp
    mov ebp, esp

    ; sa-nceapa concursul

    ; retin sirul de paranteze
    mov ecx, [ebp + 8] 
    ; retin rezultatul final
    xor eax, eax 
    ; contor
    xor edx, edx 

while_loop:
    ; adaug caracter cu caracter, adica paranteza
    mov al, byte [ecx + edx]
    movzx eax, al
    ; verific daca am ajuns la finalul sirului
    cmp eax, 0
    je end_correct
    jmp if_round_paran

if_round_paran:
    ; testez daca este paranteza (
    cmp eax, 40
    jne if_square_paran
    ; adaug paranteza pe stiva
    push eax
    jmp incrementare

if_square_paran:
    ;  testez daca este paranteza [
    cmp eax, 91
    jne if_paran
    ; adaug paranteza pe stiva
    push eax
    jmp incrementare

if_paran:
    ;  testez daca este paranteza {
    cmp eax, 123
    jne if_round_paran_close
    ; adaug paranteza pe stiva
    push eax
    jmp incrementare

if_round_paran_close:
    ; testez daca este paranteza )
    cmp eax, 41
    jne if_square_paran_close
    pop eax
    ; verific daca am ()
    cmp eax, 40
    jne end_prog
    jmp incrementare

if_square_paran_close:
    ; testez daca este paranteza ]
    cmp eax, 93
    jne if_paran_close
    pop eax
    ; verific daca am []
    cmp eax, 91
    jne end_prog
    jmp incrementare

if_paran_close:
    ; testez daca este paranteza }
    cmp eax, 125
    jne incrementare
    pop eax
    ; verific daca am {}
    cmp eax, 123
    jne end_prog
    jmp incrementare

incrementare:
    inc edx
    jmp while_loop

end_prog:
    ; inseamna ca sirul de paranteze nu se inchide cum trebuie
    mov eax, 1
    jmp end

end_correct:
    ; sirul de paranteze e bun
    mov eax, 0

end:
    leave
    ret

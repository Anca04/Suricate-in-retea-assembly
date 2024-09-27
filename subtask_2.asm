; subtask 2 - bsearch
%include "../include/io.mac"

extern printf

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    push ebx
    push esi
    push edi

    ;; recursive bsearch implementation goes here

    ; start    
    mov eax, [ebp + 8]
    ; end
    mov ebx, [ebp + 12]

binary_search_func:
    ; daca start <= end
    cmp eax, ebx
    jg not_found

    ; salvez pe stiva start
    push eax
    ; salvez pe stiva end
    push ebx

    ; salvez end-ul pentru a putea retine mijlocul
    mov esi, ebx

    ; end - start
    sub esi, eax
    ; (end - start) / 2
    shr esi, 1
    ; mid = l + (end - start) / 2
    add esi, eax

    ; arr[mid]
    mov eax, [ecx + 4 * esi]
    ; daca arr[mid] == elem cautat
    cmp eax, edx
    ; restaurez registri
    pop ebx
    pop eax

    je found
    jg apel_recursiv_dreapta
    jl apel_recursiv_stanga

apel_recursiv_dreapta:
    ; apel recursiv cu mid - 1 pentru end
    dec esi
    mov ebx, esi
    jmp binary_search_func

apel_recursiv_stanga:
    ; apel recursiv cu mid + 1 pentru start
    inc esi
    mov eax, esi
    jmp binary_search_func

found:
    ; return mid
    mov eax, esi    
    jmp end

not_found:
    ; elementul nu a fost gasit, returneaza -1
    mov eax, -1

    ;; restore the preserved registers
end:   
    pop edi
    pop esi
    pop ebx

    leave
    ret

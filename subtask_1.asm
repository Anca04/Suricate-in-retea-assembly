; subtask 1 - qsort

section .data
    ; retin low
    low dd 0
    ; retin high
    high dd 0
    ; contorul i
    i dd 0
    ; contorul j
    j dd 0
    ; o variabila auxiliara in care salvez high
    high_aux dd 0
    ; retin pivotul
    pivot dd 0

section .text
    global quick_sort
    ;; no extern functions allowed

quick_sort:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers

    push ebx
    push esi
    push edi

    ; vectorul
    mov edi, [ebp + 8] 
    ; low = 0
    xor eax, eax 
    ; high = n - 1
    mov ecx, [ebp + 16]

    mov [low], eax
    mov [high], ecx
    mov [high_aux], ecx

    xor edx, edx

qsort_func:
    mov eax, [low]
    mov ecx, [high]
    ; low < high
    cmp eax, ecx
    jge end
    ; pivot = low
    mov [pivot], eax
    ; i = low
    mov [i], eax
    ; j = high
    mov [j], ecx
    jmp while_loop

while_loop:
    mov eax, [i]
    mov ecx, [j]
    ; i < j
    cmp eax, ecx
    jge swap
    jl while_loop_1

while_loop_1:
    mov eax, [i]
    mov ecx, [pivot]
    ; arr[pivot]
    mov edx, [edi + 4 * ecx]

    ; arr[i] <= arr[pivot]
    cmp [edi + 4 * eax], edx
    jg while_loop_2
    mov eax, [i]
    mov ecx, [high]
    ; i <= high
    cmp eax, ecx
    jg while_loop_2
    ; i++
    inc eax
    mov [i], eax
    jmp while_loop_1

while_loop_2:
    mov eax, [j]
    mov ecx, [pivot]
    ; arr[pivot]
    mov edx, [edi + 4 * ecx]

    ; arr[j] > arr[pivot]
    cmp [edi + 4 * eax], edx
    jle if_cond
    mov eax, [j]
    mov ecx, [low]
    ; j >= low
    cmp eax, ecx
    jl if_cond
    mov ecx, [j]
    ; j--
    dec ecx
    mov [j], ecx
    jmp while_loop_2

if_cond:
    mov eax, [i]
    mov ecx, [j]
    ; i < j
    cmp eax, ecx
    jge while_loop
    mov eax, [i]
    mov ecx, [j]
    ; arr[i]
    mov edx, [edi + 4 * eax]
    ; arr[j]
    mov eax, [edi + 4 * ecx]

    ; fac swap intre arr[i] si arr[j]
    push edx
    push eax

    pop edx
    pop eax

    mov ecx, [i]
    ; adaug in arr[i], arr[j]
    mov [edi + 4 * ecx], edx
    mov ecx, [j]
    ; adaug in arr[j], arr[i]
    mov [edi + 4 * ecx], eax
    jmp while_loop

swap:
    mov eax, [j]
    mov ecx, [pivot]

    ; arr[j]
    mov edx, [edi + 4 * eax]
    ; arr[pivot]
    mov eax, [edi + 4 * ecx]

    ; fac swap intre arr[pivot] si arr[j]
    push edx
    push eax

    pop edx
    pop eax

    mov ecx, [j]
    ; adaug in arr[j], arr[pivot]
    mov [edi + 4 * ecx], edx
    mov ecx, [pivot]
    ; adaug in arr[pivot], arr[j]
    mov [edi + 4 * ecx], eax

    ; apelez recursiv
    ; quicksort(arr, low, j - 1);
    call recursive_apel_1
    ; quicksort(arr, j + 1, high);
    call recursive_apel_2

recursive_apel_2:
    ; stabilesc parametrii, adica j + 1 pentru low, iar high ramane high
    mov eax, [high_aux]
    mov [high], eax
    mov eax, [high]
    mov ecx, [j]
    inc ecx
    mov [low], ecx
    mov ecx, [low]
    cmp ecx, eax
    jge end
    jl qsort_func

recursive_apel_1:
    ; stabilesc parametrii, adica j - 1 pentru high, iar low ramane low
    mov eax, [low]
    mov ecx, [j]
    push ecx
    dec ecx
    mov [high], ecx
    mov ecx, [high]
    cmp eax, ecx
    jge recursive_apel_2
    jl qsort_func


    ;; restore the preserved registers
    pop edi
    pop esi
    pop ebx

end:
    leave
    ret



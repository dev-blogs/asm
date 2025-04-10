%include "stud_io.inc"
global _start

section .data
        string db "abbijijnec", 0
        pattern db "a*ec", 0

section .text
_start: push string
        push pattern
        call match
        add esp, 8
check:  FINISH
match:
                push ebp
                mov ebp, esp
                sub esp, 4
                mov [ebp - 4], dword 0
                push esi
                push edi

                mov esi, [ebp + 8]
                mov edi, [ebp + 12]

for:            mov eax, [esi]
                mov ebx, [edi]

zero_case:      test al, al
                jnz quest_case

                mov edx, 0
                test bl, bl
                jnz ret_0
                mov edx, 1
ret_0:          jmp quit

quest_case:
star_case:      cmp al, 0x2A
                jnz dflt
                mov ecx, 0

lp2:            mov eax, edi
                add eax, ecx
                push eax
                mov eax, esi
                inc eax
                push eax
                call match
                add esp, 8

                mov eax, [esi]
                mov ebx, [edi]

                test edx, edx
                jz check_zero
                mov edx, 1
                jmp quit

check_zero:     test bl, bl
                jnz end_lp2
                jmp quit

end_lp2:        inc ecx
                jmp lp2

dflt:           cmp al, bl
                jz end_for
                mov edx, 0
                jmp quit

end_for:        inc esi
                inc edi
                jmp for

quit:           pop edi
                pop esi
                mov esp, ebp
                pop ebp
                ret

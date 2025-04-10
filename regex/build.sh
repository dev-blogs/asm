nasm -f elf regex.asm
ld -m elf_i386 regex.o -o regex

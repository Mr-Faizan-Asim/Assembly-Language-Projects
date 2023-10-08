; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example
Include Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
	prompt1 db "Enter First Number: ", 0
	prompt2 db "Enter Second Number: ", 0
	prompt3 db "Enter the Operation as(a,x,d,m): ",0
	resultMessage db "Result is: ", 0
	num1 dd ?
	num2 dd ?
	operation db ? 
	result dd ?
.code
main proc
	; 1st number take
	mov edx, offset prompt1
	call writestring
	call readint
	mov num1,eax

	; 2nd number take
	mov edx, offset prompt2
	call writestring
	call readint
	mov num2,eax

	; taking operations
	mov edx, offset prompt3
	call writestring
	call readchar
	mov operation,al

	call crlf

	cmp operation,'a'
	je performAdd

	cmp operation,'x'
	je performMul

	cmp operation,'d'
	je performDiv

	cmp operation,'m'
	je performSub


	invoke ExitProcess,0

performAdd:
	mov eax,num1
	add eax,num2
	mov result,eax
	jmp displayAnswer

performMul:
	mov eax,num1
	imul eax,num2
	mov result,eax
	jmp displayAnswer

performSub:
	mov eax,num1
	sub eax,num2
	mov result,eax
	jmp displayAnswer

performDiv:
	mov eax,num1
	cdq ; it exten eax to edx : eax
	idiv num2
	mov result,eax
	jmp displayAnswer


displayAnswer:
	mov edx , offset resultMessage
	call writestring
	mov eax, result
	call writeint

	call crlf

	call waitmsg
	invoke ExitProcess, 0    ; Exit the program


main endp
end main
include Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
    ; Operation Performer
    oper db ?
    ; Define the header
    headerArray db "##############",0
                db "#            #",0
                db "#     LMS    #",0
                db "#            #",0
                db "##############",0
    headerSize dd 5             ; Number of strings in the array

    ; Define the menu
    menuArray db "1. ADD BOOK",0
              db "2. DEL BOOK",0
              db "3. UPD BOOK",0
              db "4. PRI BOOK",0
              db "5. NAM BOOK",0
    menuSize dd 5               ; Number of strings in the menu
    menuMessage db "CHOSE ONE: ",0
    ; Books Variable
    prompt1 db "BOOK NAME: ",0
    prompt2 db "BOOK ID: ",0
    prompt3 db "BOOK PRICE: ",0
    BookName db 100 dup (?) 
    Bookid db 100*100 dup (?) 
    BookPrice db 100*100 dup (?)
    BookCounter dd 0
    ; temp thing
    temp db ?


.code
; header Function
header proc
    mov ecx, [headerSize]
    mov esi, 0 
print_loop:
    lea edx, [headerArray + esi]
    call writestring
    call crlf

    add esi, 15

    loop print_loop

    ret
header endp

menuPrinter proc
    mov ecx, [menuSize]
    mov esi, 0
menu_loop:
    lea edx, [menuArray + esi]
    call writestring
    call crlf

    add esi, 12

    loop menu_loop

     mov edx, offset menuMessage
     call writestring
     call readchar
     call crlf    
     ret
menuPrinter endp


addBook proc
 

    ; Read the book name
    mov ebx, offset BookName
    mov edi, offset BookCounter
    mov esi, ebx
    add esi, [edi]
    call readString
    mov eax,[esi]
    call writeint

   
    ; Increment the book counter
    add BookCounter,1

    ret

book_limit_reached:
    ; Handle the case where the maximum book limit is reached
    mov edx, offset max_book_limit_message
    call writestring
    call crlf
    ret

max_book_limit_message db "Maximum book limit reached.", 0
addBook endp


main proc
start:
    call waitmsg
    call Clrscr
    call header
    call menuPrinter
    mov oper,al

    cmp oper,'1'
    je PerformAdd

PerformAdd:
    call addBook
    mov eax,[BookCounter]
    call Writeint
    jmp start

;PerformDel:
    

;PerformUpd:


;PerformPri:


;PerformName:


    invoke ExitProcess, 0
main endp

end main

data segment
    choice db 10,13,"1.Addition 2.Subtraction 3.Multiplication 4.Division 5.Exit $"
    msg1 db 10,13,"Enter first number: $"
    msg2 db 10,13,"Enter second number:$"
    result db 10,13,"Result is $"
    r db 10,13,"Remainder is $"
    q db 10,13,"Quotient is $"
data ends
Code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    
    mov dx,offset choice
    mov ah,09h
    int 21h

    mov ah,01h
    int 21h
    
    cmp al,35h
    jnz skipe
    
    mov ah,4ch
    int 21h
    
skipe:
    mov ch,al
    mov dx,offset msg1
    mov ah,09h
    int 21h

    mov ah,01h
    int 21h
    call ASCIItoHEX
    mov bl,al
    rol bl,04h
    
    mov ah,01h
    int 21h
    call ASCIItoHEX
    add bl,al
    
    mov dx,offset msg2
    mov ah,09h
    int 21h
    
    mov ah,01h
    int 21h
    call ASCIItoHEX
    mov cl,al
    rol cl,04h
    
    mov ah,01h
    int 21h
    call ASCIItoHEX
    add cl,al
    
    mov al,ch
    cmp al,31h
    jnz skipa
    call myadd
    
skipa:
    cmp al,32h
    jnz skips
    call mysub
    
skips:
    cmp al,33h
    jnz skipm
    call mymul

skipm:
    cmp al,34h
    jnz skipd
    call mydiv

skipd:
    jmp start

myadd proc
    add bl,cl
    
    mov dx,offset result
    mov ah,09h
    int 21h
     
    mov cl,bl
    and bl,0f0h
    ror bl,04h
    call HEXtoASCII
    mov dl,bl
    mov ah,02h
    int 21h
   
    mov bl,cl
    and bl,0Fh
    call HEXtoASCII
    MOV DL,BL
    mov ah,02h
    int 21h
 ret
endp

mysub proc
    sub bl,cl
    
  mov dx,offset result
  mov ah,09h
  int 21h
  
  mov cl,bl
  and bl,0f0h
  ror bl,4
  call HEXtoASCII
  mov dl,bl
  mov ah,02h
  int 21h
  
  mov bl,cl
  and bl,0fh
  call HEXtoASCII
  mov dl,bl
  mov ah,02h
  int 21h
  mov al,00h
 ret
 endp  
mymul proc
    mov dx,offset result
    mov ah,09h
    int 21h
    
    mov ah,00h
    mov al,bl
    mul cl
    mov cx,ax
    
    mov bx,ax
    and bx,0f000h
    ror bx,12
    call HEXtoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov bx,cx
    and bx,0f00h
    ror bx,8
    call HEXtoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov bx,cx
    and bx,00f0h
    ror bx,4
    call HEXtoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
     mov bx,cx
    and bx,00fh
    call HEXtoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov al,00h
    ret
endp

mydiv proc
    mov ah,00h
      
    mov al,bl
    div cl
    mov cx,ax
    
    
    mov dx,offset r
    mov ah,09h
    int 21h
  
   mov bx,ax
    and bx,0f000h
    ror bx,12
    call HEXtoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov bx,cx
    and bx,0f00h
    ror bx,8
    call HEXtoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov dx,offset q
    mov ah,09h
    int 21h
    
    mov bx,cx
    and bx,00f0h
    ror bx,4
    call HEXtoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
     mov bx,cx
    and bx,00fh
    call HEXtoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov al,00h
    ret
endp

ASCIItoHEX proc
cmp al,41h
jc label1
sub al,07h
label1:
sub al,30h
ret
endp

HEXtoASCII proc
cmp bl,0ah
jc label2
add bl,07h
label2:
add bl,30h
ret 
endp
    
Code ends
end start
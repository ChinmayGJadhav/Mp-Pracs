DATA SEGMENT
    len db ?
    msg db,0dh,0ah,"Enter the string: $"
    res1 db,0dh,0ah,"String is palindrome $"
    res2 db,0dh,0ah,"String is not palindrome $"
DATA ENDS

CODE SEGMENT
    assume CS:code,DS:data 

start:  mov ax,data
        mov DS,ax
        
        mov si,5000h
            
        mov dx,offset msg
        mov ah,09h
        int 21h
        
accept:mov ah,01h
        int 21h
        mov [si],al
        cmp al,0dh
        jz lblb 
        inc si
        inc len 
        jmp accept
        
   lblb:mov cl,len
        mov ch,00h
        mov di,5000h
        dec si

  check:mov bl,[di]
        cmp[si],bl
        jnz npalin
        inc di
        dec si
        loop check
        
        mov dx,offset res1
        mov ah,09h
        int 21h
        jmp exit
        
 npalin:mov dx,offset res2
        mov ah,09h
        int 21h
        
   exit:mov ah,4ch
        int 21h
                
code ends
end start
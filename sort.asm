Data segment
    MSG1 db,0dh,0ah,"ENTER NO.OF ELEMENTS:$"
    MSG2 db,0dh,0ah,"ENTER ELEMENT:$"
    MSG3 db,0ah,0dh,"The Sorted array is:$"
    MSG4 db,0ah,0dh,"The Sum of the array is:$"
    cnt db ?
    sum db ?
Data ends
Code segment
assume CS:code,DS:data

start:mov ax,data
      mov DS,ax
      
      mov sum,00h
      mov dx,offset MSG1
      mov ah,09h
      int 21h
      call input
      mov cnt,bl
      mov bh,00h
      mov cx,bx
      mov si,5000h
    
      
accept:mov dx,offset MSG2
       mov ah,09h
       int 21h 
       call input
       add sum,bl
       mov [si],bl
       inc si
       loop accept
       mov bh,cnt
       sub bh,1
       
again:  mov bl,bh
       mov si,5000h
back:  mov al,[si]
       inc si
       cmp al,[si]
       jb next
       xchg al,[si]
       mov [si-1],al
next:  dec bl
       jnz back
       dec bh
       jnz again      

       mov si,5000h
       mov bh,00h
       mov bl,cnt
       mov cx,bx       
       mov dx,offset MSG3
       mov ah,09h
       int 21h
again2:mov bl,[si]
        mov dx,10
        mov ah,02h
        int 21h
        mov dx,13
        mov ah,02h
        int 21h
       call output
       inc si
       loop again2
       
       mov dx,offset MSG4
       mov ah,09h
       int 21h
       mov bl,sum
       and bl,0f0h
       ror bl,4
       call HextoASCII
       mov dl,bl
       mov ah,02h
       int 21h
       mov bl,sum
       and bl,0fh
       call HextoASCII
       mov dl,bl
       mov ah,02h
       int 21h
       
       
       

input proc
    mov ah,01h
    int 21h
    call ASCIItoHEX
    mov bl,al
    rol bl,4
    mov ah,01h
    int 21h
    call ASCIItoHEX
    add bl,al
    ret
endp

output proc
    mov bh,bl
    and bl,0f0h
    ror bl,4
    call HextoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    mov bl,bh
    and bl,0fh
    call HextoASCII   
    mov dl,bl
    mov ah,02h
    int 21h

ASCIItoHEX proc
            cmp al,41h
            jc lbl1
            sub al,07h
       lbl1:sub al,30h
            ret
endp
    
HextoASCII proc
        cmp bl,0ah
        jc lbl2
        add bl,07h
    lbl2:add bl,30h
        ret
endp   

    
code ends
end start    
    

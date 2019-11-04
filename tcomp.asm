DATA SEGMENT
    msg db,0dh,0ah,"Enter a number:$"
     msg1 db,0dh,0ah,"The 2's complement is:$"
    num db ?
DATA ENDS
CODE SEGMENT
  ASSUME CS:CODE,DS:DATA
  START: 
        mov ax,data
    mov ds,ax
    mov dx,offset msg
    mov ah,09h
    int 21h
    
    mov ah,01h
    int 21h
    call ASCIItoHex
    mov bl,al
    rol bl,04h
    mov ah,01h
    int 21h
    call ASCIItoHex
    add bl,al
    

    xor bl,0ffh
    add bl,01h
    mov cl,bl
    mov dx,offset msg1
    mov ah,09h
    int 21h
    
    and bl,0f0h
    ror bl,4
    call HextoASCII 
    mov dl,bl
    mov ah,02h
    int 21h
  
    mov bl,cl
    and bl,0fh
    call HextoASCII 
    mov dl,bl
    mov ah,02h
    int 21h 
    
    mov ah,4ch
    int 21h
    

ASCIItoHex proc
           cmp al,41h
           jb next1
           sub al,07h
           next1:sub al,30h
            ret
       endp    
    
HextoASCII proc
           cmp bl,0ah
           jb next
           add bl,07h
       next:add bl,30h
            ret
       endp
  CODE ENDS
  END START    
  
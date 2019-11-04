DATA SEGMENT
    msg db,0dh,0ah,"Enter a number:$"
    msg2 db,0dh,0ah,"Enter a number:$"
    msg3 db,0dh,0ah,"GCD of given nos is:$"
    lcm db,0dh,0ah,"LCM of the given nos is:$"
    fn db ?
    q db ?
    sn db ?
    GCD db ?

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
    mov fn,bl
    
    mov dx,offset msg2
    mov ah,09h
    int 21h
    
    mov ah,01h
    int 21h
    call ASCIItoHex
    mov cl,al
    rol cl,04h
    mov ah,01h
    int 21h
    call ASCIItoHex
    add cl,al
    mov sn,cl
     
again:cmp bl,cl
    jz exit
    jc next1
    sub bl,cl
  
    jmp again
next1:sub cl,bl
   
    jmp again
exit:mov GCD,bl


mov dx,offset lcm
mov ah,09h
int 21h
mov al,fn
mov bl,sn
mul bl
mov bl,GCD
div bl
mov q,al
mov bl,q
and bl,0f0h
ror bl,4
call HextoASCII
mov dl,bl
mov ah,02h
int 21h
mov bl,q
and bl,0fh
call HextoASCII
mov dl,bl
mov ah,02h
int 21h


mov dx,offset msg3
mov ah,09h
int 21h
mov bl,GCD
and bl,0f0h
ror bl,4
call HextoASCII
mov dl,bl
mov ah,02h
int 21h

mov bl,GCD
and bl,0fh
call HextoASCII
mov dl,bl
mov ah,02h
int 21h

mov ah,4ch
int 21h
        
    
    ASCIItoHex proc
        cmp al,41h
        jc lab
        sub al,07h
        lab:
            sub al,30h
        ret
        endp
        
   HEXtoASCII proc
        cmp bl,0ah
        jc next
        add bl,07h
    next:add bl,30h
        ret
    endp
        
  
  CODE ENDS
  END START
DATA SEGMENT
    msg db,0dh,0ah,"Enter a number:$"
    msg2 db,0dh,0ah,"Enter a number:$"
    result db,0dh,0ah,"Result is:$"
    
 
    fn dw ?
    sn dw ?


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
    mov bh,al
    rol bh,04h
    mov ah,01h
    int 21h
    call ASCIItoHex
    add bh,al
    
    mov ah,01h
    int 21h
    call ASCIItoHex
    mov bl,al
    rol bl,04h
    mov ah,01h
    int 21h
    call ASCIItoHex
    add bl,al
    
    mov fn,bx
    
 
    
    mov ah,01h
    int 21h
    call ASCIItoHex
    mov ch,al
    rol ch,04h
    mov ah,01h
    int 21h
    call ASCIItoHex
    add ch,al

    
    mov ah,01h
    int 21h
    call ASCIItoHex
    mov cl,al
    rol cl,04h
    mov ah,01h
    int 21h
    call ASCIItoHex
    add cl,al
    
    mov sn,cx
    
    
    mov dx,offset msg2
    mov ah,09h
    int 21h
    
    mov ah,01h
    int 21h
    call ASCIItoHex
    mov bh,al
    rol bh,04h
    mov ah,01h
    int 21h
    call ASCIItoHex
    add bh,al
    
    mov ah,01h
    int 21h
    call ASCIItoHex
    mov bl,al
    rol bl,04h
    mov ah,01h
    int 21h
    call ASCIItoHex
    add bl,al
    
    
    mov ah,01h
    int 21h
    call ASCIItoHex
    mov ch,al
    rol ch,04h
    mov ah,01h
    int 21h
    call ASCIItoHex
    add ch,al

    
    mov ah,01h
    int 21h
    call ASCIItoHex
    mov cl,al
    rol cl,04h
    mov ah,01h
    int 21h
    call ASCIItoHex
    add cl,al
    
    
    add cx,sn
    add bx,fn
    mov sn,cx
    mov fn,bx
    
    mov dx, offset result
    mov ah,09h
    int 21h
  
    
    and bx, 0f000h
    ror bx,12
    call HextoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov bx,fn
    and bx, 00f00h
    ror bx,8
    call HextoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov bx,fn
    and bx, 000f0h
    ror bx,4
    call HextoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov bx,fn
    and bx, 0000fh
    call HextoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov bx,sn
    and bx, 0f000h
    ror bx,12
    call HextoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov bx,sn
    and bx, 00f00h
    ror bx,8
    call HextoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov bx,sn
    and bx, 000f0h
    ror bx,4
    call HextoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov bx,sn
    and bx, 0000fh
    call HextoASCII
    mov dl,bl
    mov ah,02h
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
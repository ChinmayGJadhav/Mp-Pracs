Data segment
    msg db 10,13,"Enter a number:$"
    msg2 db 10,13,"Enter a number:$"
      result db 0dh,0ah,"Result is: $"
    smallest DB ?
Data Ends
Code Segment
    Assume cs:code,ds:data
Start:
    mov ax,data
    mov ds,ax
    
    mov dx,offset msg
    mov ah,09h
    int 21h
    
    mov ah,01h
    int 21h
    call convert
    mov bl,al
    rol bl,04h
    mov ah,01h
    int 21h
    call convert
    add bl,al
    
    mov dx,offset msg2
    mov ah,09h
    int 21h
    
    mov ah,01h
    int 21h
    call convert
    mov cl,al
    rol cl,04h
    mov ah,01h
    int 21h
    call convert
    add cl,al
    
    add bl,cl
    


           
            mov dx, offset result
            mov ah,09h
            int 21h
           
            mov cl,bl
           
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
  
    
    convert proc
        cmp al,41h
        jc lab
        sub al,07h
        lab:
            sub al,30h
        ret
        endp
        
    output proc
        cmp smallest,0ah
        jc labo
        add smallest,07h
        labo:
            add smallest,30h
            mov dl,smallest
            mov ah,02h
        int 21h
        ret
        endp
     HextoASCII proc
            cmp bl,0ah
            jc lbl2
            add bl,07h
       lbl2:add bl,30h
            ret
        endp
Code Ends
    End Start
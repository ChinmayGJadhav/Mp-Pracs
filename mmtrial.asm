Data segment
    MSG1 DB,10,13,"ENTER NO.OF ELEMENTS:$"
    MSG2 DB,10,13,"ENTER ELEMENT:$"
    RES1 DB,10,13,"MINIMUM IS:$"
    RES2 DB,10,13,"MAXIMUM IS:$"
    MIN DB ?
    MAX DB ?
    COUNT DB ?
Data Ends
Code Segment
    Assume cs:code,ds:data
Start:
    mov ax,data
    mov ds,ax
    
    MOV dx,OFFSET MSG1
    mov ah,09h
    int 21h
    call input
    mov COUNT,bl
    mov bh,00h
    mov cx,bx    
    mov si,5000H
       
    
    
 
    
    
again:
    MOV dx,OFFSET MSG2
    mov ah,09h
    int 21h
    call input
    mov [si],bl
    inc si
    
    loop again
    
    mov bh,00h
    mov bl,COUNT
    sub bl,01h
    mov cx,bx    
    mov si,5000h
    mov bl,[si]
    
    inc si
   
again1:cmp bl,[si]
    jb next
    mov bl,[si]
next:mov bh,[si]
    mov MAX,bh
    inc si
    loop again1

    
    
    mov dx,offset RES1
    mov ah,09h
    int 21h
    mov MIN,bl
    and bl,0f0h
    ror bl,4
    call HextoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    mov bl,MIN
    and bl,0fh
    call HextoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov dx,offset RES2
    mov ah,09h
    int 21h
    mov bl,MAX
    and bl,0f0h
    ror bl,4
    call HextoASCII
    mov dl,bl
    mov ah,02h
    int 21h
    mov bl,MAX
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
    rol bl,04h
    mov ah,01h
    int 21h
    call ASCIItoHEX
    add bl,al
    
    
 
    
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
Code Ends
    End Start
    
    
    
    
    
    
    
    
    
    
    
    
    
     
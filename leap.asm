Data segment
    MSG1 db,0dh,0ah,"ENTER THE YEAR:$"
    MSG2 db,0ah,0dh,"The YEAR IS LEAP YEAR$"
    MSG3 db,0ah,0dh,"The YEAR IS NOT A LEAP YEAR$"
    yr1 db ?
    f db ?
    yr2 db ?
Data ends
Code segment
    assume CS:code,DS:data
start:mov ax,data
      mov DS,ax
        
      mov dx,offset MSG1
      mov ah,09h
      int 21h
      call input
      mov yr1,bl
      mov ah,bl
      call input
      mov yr2,bl
      mov al,bl
      mov bl,04h
      div bl
      cmp ah,00h
      jnz skip
      mov ah,yr1
      mov al,yr2
      mov bl,64h
      div bl
      
  
      cmp ah,00h
      jnz skip1
      mov dx,0000h
      mov ah,yr1
      mov al,yr2
      mov bx,0190h
      div bx
      cmp dx,0000h
      jnz skip
      jmp skip1
      mov ah,4ch
      int 21h 
      
      
      
skip:mov dx,offset MSG3
      mov ah,09h
      int 21h
      mov ah,4ch
      int 21h

skip1:mov dx,offset MSG2
      mov ah,09h
      int 21h
      mov ah,4ch
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
   
   
   
Code ends
end start
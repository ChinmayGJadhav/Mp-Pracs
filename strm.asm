DATA SEGMENT
    len db ?
    c db ?
    msg db,0dh,0ah,"Enter the string: $"
    choice db,0dh,0ah,"Enter your choice: 1.Length of string 2.Print string 3.Reverse string 4.Exit : $"
    res1 db,0dh,0ah,"Length of string is: $"
    res2 db,0dh,0ah,"String entered is: $"
    res3 db,0dh,0ah,"Reverse of string is: $"
DATA ENDS

CODE SEGMENT
    assume CS:code,DS:data 

start:  mov ax,data
        mov DS,ax
        
        mov si,5000h
        mov len,00h
        
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
        
   lblb:mov dx,offset choice
        mov ah,09h
        int 21h
        mov ah,01h
        int 21h
        mov c,al
        
        cmp c,34h
        jnz cont
        mov ah,4ch
        int 21h
        
   cont:cmp c,31h
        jnz skipl
        call mylen
        
  skipl:cmp c,32h
        jnz skipp
        call print
        
  skipp:cmp c,33h
        jnz skipr
        call myrev
        
  skipr:jmp lblb
        
        
        mylen proc
            mov dx,offset res1
            mov ah,09h
            int 21h
            mov bl,len
            call disp
            ret
        endp
        
        print proc
            mov dx,offset res2
            mov ah,09h
            int 21h
            mov ch,00h
            mov cl,len
            mov si,5000h
         l1:mov dl,[si]
            mov ah,02h
            int 21h
            inc si
            loop l1
            ret
        endp
        
        myrev proc
            mov ch,00h
            mov cl,len
            mov si,5000h
         l2:inc si
            loop l2
            sub si,01h
            mov dx,offset res3
            mov ah,09h
            int 21h
            mov ch,00h
            mov cl,len
         l3:mov dl,[si]
            mov ah,02h
            int 21h
            dec si
            loop l3
            ret
        endp
        
        input proc
            mov ah,01h
            int 21h
            call ASCIItoHex
            mov bl,al
            rol bl,4
            mov ah,01h
            int 21h
            call ASCIItoHex
            add bl,al
            ret
        endp
        
        disp proc
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
        
code ends
end start
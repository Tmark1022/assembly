assume cs:codesg

codesg segment
	mov ax, cs
	mov ds, ax
	mov ax, 0020h
	mov es, ax
	mov bx, 0h
	mov cx, 23
s:	mov al, [bx]
	mov es:[bx], al
	inc bx
	loop s

	mov ax, 4c00h
	int 21h
codesg ends

end
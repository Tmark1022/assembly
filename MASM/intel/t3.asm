assume cs:codesg

codesg segment
	mov ax, 0020h
	mov ds, ax
	mov bx, 0h
	mov cx, 64
s:	mov [bx], bl
	inc bl
	loop s 

	mov ax,4c00h
	int 21h
codesg ends
end
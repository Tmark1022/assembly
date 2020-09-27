assume cs:code, ds:data, ss:stack
	
stack segment
		dw 0,0,0,0,0,0,0,0
stack ends

data segment
		db '1.hello         '
		db '2.tmark         '
		db '3.handsome      '
		db '4.male          '
data ends

code segment
start:	mov ax, data
		mov ds, ax

		mov ax, stack
		mov ss, ax
		mov sp, 10h

		mov bx, 0

		mov cx, 4
s1:		mov si, 0
		push cx

		mov cx, 4
s2:		mov al, [bx + 2 + si] 
		and al, 11011111b
		mov [bx + 2 + si], al
		inc si
		loop s2

		pop cx
		add bx, 10h
		loop s1

		mov ax, 4c00h
		int 21h

code ends

end start
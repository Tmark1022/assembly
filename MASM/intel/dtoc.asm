; 打印10进制整数

assume cs:code 
data segment
	db 10 dup (0)
data ends

code segment 
start:
	mov ax, 12666
	mov bx, data
	mov ds, bx
	mov si, 0
	call dtoc

	mov dh, 12
	mov dl, 10
	mov cl, 24h
	call show_str

	mov ax, 4c00h
	int 21h

dtoc:
	; 用到的寄存器入栈， 除了要传出的那几个
	push ax
	push dx
	push bx
	push cx

	; 初始si
	mov si, 10

	; 最后一位0
	dec si
	mov byte ptr ds:[si], 0

	mov bx, 10
dotcdo:
	mov dx, 0
	div bx

	; 保存余数
	add dx, 30H
	dec si
	mov byte ptr ds:[si], dl

	mov cx, ax
	jcxz dotcok

	jmp short dotcdo

dotcok:
	pop cx
	pop bx
	pop dx
	pop ax
	ret

show_str:
	; 用到的寄存器入栈
	push ax
	push dx
	push cx
	push bx
	push si
	push ds
	push es

	; 显存段地址
	mov ax, 0b800h
	mov es, ax

	; 计算行和列的偏移地址
	mov al, 160
	mul dh
	mov bx, ax					; 缓存行偏移地址

	mov al, 2
	mul dl
	add bx, ax					; 最终行列的偏移地址

	mov ax, cx					; 缓存颜色数据
do:
	mov cl, ds:[si]
	mov ch, 0
	jcxz ok

	mov es:[bx], cl
	mov es:[bx].1, al
	inc si
	add bx, 2
	jmp short do

ok:	
	pop es
	pop ds
	pop si 
	pop bx
	pop cx
	pop dx
	pop ax
	ret

code ends
end start


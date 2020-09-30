; show_str
; 功能 : 显示字符串, 字符串使用0结尾
; 参数 ==> 
; 	@ dh : 行号[0,24]
;	@ dl : 列号[0,79]
;	@ cl : 颜色
; 	@ ds:si : 指向字符串首地址

assume cs:code 
data segment
	db 'tmark is so handsome', 0
data ends

stack segment
	db 16 dup(0)
	db 16 dup(0)
stack ends

code segment 
start:
	mov dh, 12
	mov dl, 10
	mov cl, 24h
	mov ax, data
	mov ds, ax

	mov ax, stack
	mov ss, ax
	mov sp, 32
	
	mov si, 0
	call show_str

	mov ax, 4c00h
	int 21h

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


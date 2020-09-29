; ================= 实验九代码 ======================
assume cs:code 

data segment
	db 'welcome to masm!'
	db 02h, 24h, 71h
data ends

scene segment
	db 4000 dup(0)
scene ends

stack segment
	db 16 dup(0)
stack ends

code segment

start:
	; 对屏幕清空处理

	mov ax, scene
	mov ds, ax
	mov ax, 0b800h
	mov es, ax
	
	mov cx, 4000
	mov bx, 0
s:	mov al, [bx]
	mov es:[bx], al
	inc bx
	loop s

	; 输出三行数据
	mov ax, data
	mov ds, ax
	mov ax, stack
	mov ss, ax

	mov cx, 3
	mov bx, 780h
	add bx, 72
	mov bp, 0

s0:	push cx
	
	mov cx, 16
	mov si, 0
	mov di, 0
s1:	mov al, [di]
	mov es:[bx][si], al
	inc si
	mov al, ds:[bp + 16]
	mov byte ptr es:[bx][si], al
	inc si
	inc di
	loop s1

	pop cx
	add bx, 160
	inc bp
	loop s0

	mov ax, 4c00h
	int 21h

code ends

end start


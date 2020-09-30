; divdw
; 功能 : 不产生溢出的除法运算
; 参数 ==> 
; 	@ ax : dword型数据的低16位
;	@ dx : dword型数据的高16位
;	@ cx : 除数
; 返回 ==>
; 	@ ax : 结果低16位
;	@ dx : 结果高16位
;	@ cx : 余数


assume cs:code 
stack segment
	db 16 dup(0)
	db 16 dup(0)
stack ends

code segment 
start:
	mov ax, stack
	mov ss, ax
	mov sp, 32

	mov ax, 4240h
	mov dx, 000fh
	mov cx, 0ah
	call divdw

	mov ax, 4c00h
	int 21h


divdw:
	push bx
	push si

	mov si, ax			; 保存 低16位

	; int(H/N)
	mov ax, dx
	mov dx, 0
	div cx
	mov bx, ax			; 保存int(H/N)的商

	; [rem(H/N) * 65536 + L] / N
	; rem(H/N) 已经在dx中了
	mov ax, si
	div cx

	; 保存结果
	mov cx, dx

	; int(H/N) * 65536 就是高16位结果
	mov dx, bx

	pop si
	pop bx
	ret

code ends
end start


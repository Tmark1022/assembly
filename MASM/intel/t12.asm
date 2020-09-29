assume cs:codesg
codesg segment
		mov ax, 4c00h
		int 21h

start:	mov ax, 0
s:		nop
		nop

		mov di, offset s
		mov si, offset s2
		mov ax, cs:[si]
		mov cs:[di], ax					; s2:jmp short s1 的二进制指令是偏移距离， 会向前偏移10个字节， 
										; 所以， 当s: 为jmp 后， 下个指令位置在提前10个字节, 刚好就是cs:0000, 所以可以正确返回

s0: 	jmp short s

s1:		mov ax, 0
		int 21h
		mov ax, 0

s2:		jmp short s1
		nop

codesg ends

end start
; 解法2， 使用一个循环完成所有字段
assume cs:code

data segment
   db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
   db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
   db '1993','1994','1995'
   ; 以上是表示21年的21个字符串

   dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
   dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
   ; 以上是表示21年公司总收入的21个dword型数据

   dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
   dw 11542,11430,15257,17800
   ; 以上是表示21年公司雇员人数的21个word型数据

data ends

table segment
   db 21 dup ('year summ ne ?? ')
table ends

param segment
	dw 3 dup(0)
param ends

code segment
start:	mov ax, data
		mov ds, ax

		mov ax, table
		mov ss, ax

		mov ax, param
		mov es, ax
		mov word ptr es:[0], 0
		mov word ptr es:[2], 84
		mov word ptr es:[4], 168

		mov bx, 0
		mov bp, 0
		mov cx, 21
s:		
		; 年份
		mov si, es:[0]
		mov ax, [bx][si] 
		mov [bp].0h, ax		
		add si, 2
		mov ax, [bx][si] 
		mov [bp].2h, ax	
		add si, 2
		mov es:[0], si

		; 收入
		mov si, es:[2]
		mov ax, [bx][si] 
		mov [bp].5h, ax		
		add si, 2
		mov ax, [bx][si] 
		mov [bp].7h, ax	
		add si, 2
		mov es:[2], si

		; 人数
		mov si, es:[4]	
		mov ax, [bx][si] 
		mov [bp].0ah, ax		
		add si, 2
		mov es:[4], si


		mov ax, [bp].5h
		mov dx, [bp].7h
		div word ptr [bp].0ah
		mov [bp].0dh, ax			; 取商

		add bp, 10h	
		loop s

		mov ax, 4c00h
		int 21h

code ends

end start

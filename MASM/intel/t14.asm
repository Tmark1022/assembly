assume cs:code 

stack segment
stack ends

data segment 
data ends

code segment
start:

	mov ax, 4cooh
	int 21h
code ends

end start

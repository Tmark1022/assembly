
assume cs:codesg

codesg segment
	mov ax, 1000H
	add ax, ax
	add ax, ax
	
	mov ax, 4c00H
	int 21H

codesg ends

end	

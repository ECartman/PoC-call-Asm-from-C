; MS has... its way to do things. not only Calling convetion. but 
; it is also applicable to Asembler... https://left404.com/2011/01/04/converting-x86-assembly-from-masm-to-nasm-3/

;; good reads: https://codemachine.com/articles/x64_deep_dive.html
;;             https://sonictk.github.io/asm_tutorial/#otherprogramsegments

; Compiler directives and includes
; here you put your Includes. and Stuff. 


;data Section. here we define our constant and global vars. 
;more indepth : https://en.wikipedia.org/wiki/Data_segment
.data
msgCaption  db "Hi from MASM(microsoft Flavor of ASM)",0


; Here is where the program itself lives AKA your executable code. 
.code 
ALIGN 16

EXTERN GetMsgBoxType : PROC
; EXTERN MessageBoxA : PROC
EXTERN __imp_MessageBoxA : QWORD

asm_func PROC 
	;if the funtion required to move Non volatile Registers or call other functions is required of us too add a Prolog and Epilog
	;see more about this here: https://learn.microsoft.com/en-us/cpp/build/prolog-and-epilog?view=msvc-170

	;Prolog Example: 
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	push rbp                                                ;check prolog / epilog format, rbx may need to be saved
	mov rbp, r8
	push r8
	push r12
	push r13
	push r14
	sub rsp, 28h                                            ;check if code block needs to be repositioned above
	;Prolog Example END

	; so from here is where the fun "stuff" / magic might happen. 
	; so what we could do? 
	; refer to
	; https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf

	mov		[rsp], rcx
	NOP ; do you know what this is? (dont cheat. https://en.wikipedia.org/wiki/NOP_(code))
	call	GetMsgBoxType
	;lets force a access violation: uncoment the next line
	;mov		rax, QWORD PTR [0]
	mov		r9, rax
	mov		r8, [rsp]
	lea		rdx, [msgCaption]
	xor		ecx, ecx

	call	[__imp_MessageBoxA]


	;epilog Example
	; REMBER this is a STACK the order need to be REVERSE due FIFO order. 
	; also on this example, why 0x20? due we want to "jump" or safe the 4 home spaces.... (maybe even 1 more? ) or even more it will depend if there is data required to be "secured" 
	; on the stack. that was passed to this function. usually this is handled by the (pre)compiler 
	add rsp, 28h                                            ;xor ecx, ecx moved below
	pop r14
	pop r13
	pop r12
	pop r8
	pop rbp
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	;Epilog Example end 
	;RAX is a value relative to the respose of the Prior function call. the next line '0' it out. 
	xor eax, eax; 
	ret
asm_func ENDP


END


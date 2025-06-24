[bits 32]
[extern kernel_main]
call kernel_main
jmp $ ; Stay here when the kernel returns control to us (if ever)
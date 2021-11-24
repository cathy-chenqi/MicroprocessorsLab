	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw 	0x0
	movwf	TRISB, A	    ; Port C all outputs
	bra 	test
loop:

	movff 	0x06, PORTB
	incf 	0x06, W, A
	call	delay1
	
test:
	movwf	0x06, A	    ; Test for end of loop condition
	movlw 	0x05
	cpfsgt 	0x06, A	    ; compare literal in f with 0x05, skip the next branch if f > W
	bra 	loop		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start


delay1:
	movlw 0xFF
	movwf 0x12, A ; store 0x10 in file register 0x12
	call delay2

	decfsz 0x11, A

	bra delay1
	return

delay2:
	movlw 0xFF
	movwf 0x13, A ; store 0x10 in file register 0x13
	call delay3

	decfsz 0x12, A
	bra delay2
	return

delay3:
	decfsz 0x13, A
	bra delay3
	return
    
    end	main
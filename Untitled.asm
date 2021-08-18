	list P=16F84
	#include <p16f84.inc> ;biblio
	org 0x00   ;this adress indicate from where the code will be saved in memory

debut 
	clrw ;clear the work register w
;in this part i m setting RP0 and RP1 to get acess to bank 1 that contain TRIS
	bsf STATUS,RP0
	bcf STATUS,RP1
;setting PORTB as OUTPUT and the 4 first pins of porta as INPUT
	clrf TRISB
	movlw 0x0f
	movwf TRISA
;going back to bank 0 that contain port
	bcf STATUS,RP0
	bcf STATUS,RP1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;correct combination is 0011;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;testing bit nbr 0in porta if 1 we test the next one else we restart 
test1
	btfss PORTA,0 ;btfss:bit test file skip if set 
	goto notVerif
	goto test2
;testing bit nbr 1 in porta if 1 we test the next one else we restart
test2
	btfss PORTA,1  ;btfss:bit test file skip if set 
	goto notVerif
	goto test3	
;testing bit nbr 2 in porta if 0 we test the next one else we restart
test3
	btfsc PORTA,2  ;btfsc:bit test file skip if clear 
	goto notVerif
	goto test4	 
;testing bit nbr 3 in porta if 0 we test the next one else we restart
test4
	btfsc PORTA,2 ;btfsc:bit test file skip if clear 
	goto notVerif
	goto Verif
;function to set bit RB0 to high logic
Verif
	bsf PORTB,0
	goto test1
;function to set bit RB0 to low logic
notVerif
	bcf PORTB,0
	goto test1

 end

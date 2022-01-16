; Platform: 65C816 simulated in py65
; getc = fff0; putc = fff1

.p816
.a16
.i16

.include  "macros.inc"
.import   _Forth_initialize
.import   _Forth_ui
.import   _system_interface

.pushseg
.segment  "FStartup"
.proc     startup
          clc
          xce
          rep   #SHORT_A|SHORT_I
          lda   #$0300            ; direct page for Forth
          tcd
          lda   #.hiword($7000)   ; top of dictionary memory
          pha
          lda   #.loword($7000)
          pha
          lda   #.hiword($0A00)   ; bottom of dictionary
          pha
          lda   #.loword($0A00)
          pha
          lda   #$0300            ; first usable stack cell (relative to direct page)
          pha
          lda   #$0100            ; last usable stack cell+1 (relative to direct page)
          pha
          lda   #$09FF            ; return stack first usable byte
          pha
          lda   #.hiword(_system_interface)
          pha
          lda   #.loword(_system_interface)
          pha
          jsl   _Forth_initialize
          jsl   _Forth_ui
          brk
          .byte $00
.endproc

.segment "VECTORS"

; NATIVE VECTOR (65C816 Mode)
.word $0000 ; RESERVED
.word $0000 ; RESERVED
.word $0000 ; COP VECTOR   (COP Opcode)
.word $0000 ; BRK VECTOR   (BRK Opcode)
.word $0000 ; ABORT VECTOR (Unused)
.word $0000 ; NMI VECTOR   (V-Blank Interrupt)
.word $0000 ; RESET VECTOR (Unused)
.word $0000 ; IRQ VECTOR   (H/V-Timer/External Interrupt)

; EMU VECTOR (6502 Mode)
.word $0000 ; RESERVED
.word $0000 ; RESERVED
.word $0000 ; COP VECTOR   (COP Opcode)
.word $0000 ; BRK VECTOR   (Unused)
.word $0000 ; ABORT VECTOR (Unused)
.word $0000 ; NMI VECTOR   (V-Blank Interrupt)
.word startup ; RESET VECTOR (CPU is always in 6502 mode on RESET)
.word $0000 ; IRQ/BRK VECTOR

.popseg

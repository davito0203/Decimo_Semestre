# 1 "crt0ram.S"
# 1 "<interno>"
# 1 "<línea-de-orden>"
# 1 "crt0ram.S"
# 27 "crt0ram.S"
        .section .text, "ax", @progbits
        .global _start
  .global irq_enable, irq_disable, irq_mask, jump, halt
_start:
_reset_handler:
 xor r0, r0, r0
 wcsr IE, r0
 mvhi r1, hi(_reset_handler)
 ori r1, r1, lo(_reset_handler)
 wcsr EBA, r1
 calli _crt0
 nop
 nop

_crt0:

 mvhi sp, hi(_fstack)
 ori sp, sp, lo(_fstack)
 mvhi gp, hi(_gp)
 ori gp, gp, lo(_gp)


 mvhi r1, hi(_fbss)
 ori r1, r1, lo(_fbss)
 mvhi r3, hi(_ebss)
 ori r3, r3, lo(_ebss)
.clearBSS:
 be r1, r3, .callMain
 sw (r1+0), r0
 addi r1, r1, 4
 bi .clearBSS

.callMain:
 mvi r1, 0
 mvi r2, 0
 mvi r3, 0
 calli main

irq_enable:
 mvi r1, 1
 wcsr IE, r1
 ret

irq_mask:
 mvi r1, 0x0000000f
 wcsr IM, r1
 ret

irq_disable:
 mvi r1, 0
 wcsr IE, r1
 ret

jump:
 b r1

halt:
 bi halt

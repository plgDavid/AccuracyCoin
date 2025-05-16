
	
	
	;;;; HEADER AND COMPILER STUFF ;;;;
	.inesprg 2  ; 2 banks
	.ineschr 1  ; 
	.inesmap 0  ; mapper 0 = NROM
	.inesmir 1  ; background mirroring, vertical
	;;;; CONSTANTS ;;;;	

flag_c = $1
flag_z = $2
flag_i = $4
flag_d = $8
flag_v = $40
flag_n = $80
	
	
	
byte0 = $0
byte1 = $1
byte2 = $2
byte3 = $3

suitePointer = $5
dontSetPointer = $7

byte8 = $8
byte9 = $9

byteF = $F; immediate use. Store something here and use it in the same function. If a JSR happens, assume this value is stale.
currentSubTest = $10
menuTabXPos = $14
menuCursorXPos = $15
menuCursorYPos = $16
menuHeight = $17
controller = $18
controller_New = $19
JSRFromRAM = $1A
JSRFromRAM1 = $1B
JSRFromRAM2 = $1C
JSRFromRAM3 = $1D

TestResultPointer = $1E

Test_UnOp_OperandTargetAddrLo = $20
Test_UnOp_OperandTargetAddrHi = $21
Test_UnOp_ValueAtAddressForTest = $22
Test_UnOp_A = $23
Test_UnOp_X = $24
Test_UnOp_Y = $25
Test_UnOp_FlagsInit = $26
Test_UnOp_SP = $27
Test_UnOp_ExpectedResultAddrLo = $28
Test_UnOp_ExpectedResultAddrHi = $29
Test_UnOp_ValueAtAddressResult = $2A
Test_UnOp_CMP = $2B
Test_UnOp_CPX = $2C
Test_UnOp_CPY = $2D
Test_UnOp_CM_Flags = $2E
Test_UnOp_CPS = $2F
Test_UnOp_IndirectPointerLo = $30
Test_UnOp_IndirectPointerHi = $31
Test_UnOp_CycleDelayPostDMA = $32
PostDMACyclesUntilTestInstruction = 17


Test_ZeroPageReserved = $50 ; through $5F

TESTHighlightTextCopy = $7A

suiteAttributeCopy = $7E

suitePointerList = $80

suiteExecPointerList = $A0


PPUCTRL_COPY = $F0
PPUMASK_COPY = $F1


Copy_SP = $FA
Copy_SP2 = $FB
Copy_Flags = $FC
Copy_X = $FD
Copy_Y = $FE
Copy_A = $FF


PowerOnRAM = $300
PowerOnVRAM = $320
PowerOnPalette = $340
PowerOnTest_PPUReset = $360 ; 1 byte. Pass/fail the PPU Reset flag test.
PowerOn_A = $370
PowerOn_X = $371
PowerOn_Y = $372
PowerOn_SP = $373
PowerOn_P = $374

result_Unimplemented = $0400
result_CPUInstr = $0401
result_UnofficialInstr = $0402
result_RAMMirror = $0403
result_PPURegMirror = $0404
result_ROMnotWritable = $0405
result_DummyReads = $0406
result_DummyWrites = $0407
result_OpenBus = $0408

result_UnOp_SLO_03 = $409
result_UnOp_SLO_07 = $40A
result_UnOp_SLO_0F = $40B
result_UnOp_SLO_13 = $40C
result_UnOp_SLO_17 = $40D
result_UnOp_SLO_1B = $40E
result_UnOp_SLO_1F = $40F

result_UnOp_ANC_0B	= $410
result_UnOp_ANC_2B	= $411
result_UnOp_ASR_4B	= $412
result_UnOp_ARR_6B	= $413
result_UnOp_ANE_8B	= $414
result_UnOp_LXA_AB	= $415
result_UnOp_AXS_CB	= $416
result_UnOp_SBC_EB	= $417
result_UnOp_Magic = $418

result_UnOp_RLA_23 = $419
result_UnOp_RLA_27 = $41A
result_UnOp_RLA_2F = $41B
result_UnOp_RLA_33 = $41C
result_UnOp_RLA_37 = $41D
result_UnOp_RLA_3B = $41E
result_UnOp_RLA_3F = $41F

result_UnOp_SRE_43 = $420
result_UnOp_SRE_47 = $421
result_UnOp_SRE_4F = $422
result_UnOp_SRE_53 = $423
result_UnOp_SRE_57 = $424
result_UnOp_SRE_5B = $425
result_UnOp_SRE_5F = $426

result_UnOp_RRA_63 = $427
result_UnOp_RRA_67 = $428
result_UnOp_RRA_6F = $429
result_UnOp_RRA_73 = $42A
result_UnOp_RRA_77 = $42B
result_UnOp_RRA_7B = $42C
result_UnOp_RRA_7F = $42D

result_UnOp_SAX_83 = $42E
result_UnOp_SAX_87 = $42F
result_UnOp_SAX_8F = $430
result_UnOp_SAX_9F = $431
result_UnOp_LAX_A3 = $432
result_UnOp_LAX_A7 = $433
result_UnOp_LAX_AF = $434
result_UnOp_LAX_B3 = $435
result_UnOp_LAX_B7 = $436
result_UnOp_LAX_BF = $437

result_UnOp_DCP_C3 = $438
result_UnOp_DCP_C7 = $439
result_UnOp_DCP_CF = $43A
result_UnOp_DCP_D3 = $43B
result_UnOp_DCP_D7 = $43C
result_UnOp_DCP_DB = $43D
result_UnOp_DCP_DF = $43E

result_UnOp_ISC_E3 = $43F
result_UnOp_ISC_E7 = $440
result_UnOp_ISC_EF = $441
result_UnOp_ISC_F3 = $442
result_UnOp_ISC_F7 = $443
result_UnOp_ISC_FB = $444
result_UnOp_ISC_FF = $445

result_UnOp_SHA_93 = $446
result_UnOp_SHA_9F = $447
result_UnOp_SHS_9B = $448
result_UnOp_SHY_9C = $449
result_UnOp_SHX_9E = $44A
result_UnOp_LAE_BB = $44B

result_DMA_Plus_2007R = $44C
result_FFFF_Plus_X_Wraparound = $44D
result_PPUOpenBus = $044E


result_PowOn_CPURAM = $0480
result_PowOn_CPUReg = $0481
result_PowOn_PPURAM = $0482
result_PowOn_PPUPal = $0483
result_PowOn_PPUReset = $0484




;$500 is dedicated to RAM needed for tests.

;$600 is dedicated to the IRQ routine
;$700 is dedicated to the NMI routine.


	;;;; ASSEMBLY CODE ;;;;
	.org $8000
	; The open bus test needs to make sure an inaccurate emulation of open bus will fall into test code, so this function here is a fail condition of the open bus test.
OpenBusTestFakedOpenBusBehavior:
	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	; I put 17 $00's here for playing silent DPCM samples.
	; The 00's double as BRK instructions, which fail the open bus test.
	
CannotWriteToROM_01:
	.byte $01; This value is used in the "Cannot write to ROM" test.
	
RESET:
	STA PowerOn_A
	STY PowerOn_Y
	STX PowerOn_X
	TSX
	STX PowerOn_SP
	PHP
	PLA
	AND #$CF
	STA PowerOn_P
RESET_SkipPowerOnTests

	SEI
	CLD
	LDX #$EF ; Due to some tests modifying the stack pointer, it's convenient to put it at EF instead of FF.
	TXS		 ; This prevents some tests where the resulting stack pointer is 00 from pushing data, and overwriting the bottom of the stack.
	LDA #$40
	STA $4017
TEST_PPUResetFlag:
	;;; Test 1 [PPU Reset Flag]: Are PPU Registers writable before the first pre-render line? ;;;
	; They shouldn't be, as that's the job of the PPU Reset Flag!
	; Let's see if the PPU Reset flag exists.
	LDA #$27
	STA $2006 ; "magic address"
	LDA #$BF
	STA $2006 ; PPUADDR = $27BF
	LDA #$5A ; "magic number"
	STA $2007
	; Okay, I'll be back in 2 frames to check on you...
	LDX #$FF
	LDA $2002
VblLoop:
	LDA $2002
	BPL VblLoop
	INX
	BEQ VblLoop
	; Now that the PPU is responsive, let's copy the resting values.
	JSR Read32NametableBytes
	JSR ReadPaletteRAM
	
	; Let's also see if the magic number was written, to verify if the reset flag exists.
	LDA #$6
	STA PowerOnTest_PPUReset ; set to FAIL (error code $1) by default. Overwrite with PASS if it passes.
	LDA #$27
	STA $2006
	LDA #$BF
	STA $2006
	LDA $2007 ; load buffer
	LDA $2007 ; read buffer
	CMP #$5A
	BEQ PostResetFlagTest
	; The value of $5A was not written to VRAM, so the reset flag does exist!
	LDA #1
	STA PowerOnTest_PPUReset ; Store a passing result here.
	;; End of test ;;
PostResetFlagTest:
	
	; With those values copied for future reference, let's overwrite the nametable.
	JSR SetUpDefaultPalette
	JSR ClearNametable
	JSR ClearRAMExceptPage3
	LDA #02
	STA $4014 ; Set up OAM
	
	; set up the NMI routine.
	JSR SetUpNMIRoutineForMainMenu
	
	LDA #$20
	STA <JSRFromRAM
	LDA #$60
	STA <JSRFromRAM3
	
	LDA #0
	STA $100 ; initialize the placeholder test results.
	
	LDA #$FF
	STA <menuCursorYPos
	
	;JSR PrintTextCentered
	;.word $2100
	;.byte "Unofficial Instructions TEST ?", $FF

	;JSR Print32Bytes
	;.word $2244
	;.word PowerOnTest_PPUReset

	;LDA #01
	;STA result_CPUInstr
	;LDA #02
	;STA result_OpenBus

	LDA #Low(Suite_CPUBehavior)
	STA <suitePointer
	LDA #High(Suite_CPUBehavior)
	STA <suitePointer+1
	JSR LoadSuiteMenu


	JSR ResetScroll
	JSR EnableRendering
	JSR EnableNMI
		
InfiniteLoop:
	JMP InfiniteLoop
;;;;;;;;;;;;;;;;;;;;
	

	
	.org $8100
	; Menu Data

table .macro
	.byte \1
	.byte \2
	.word \3
	.word \4
	.endm

TableTable:
	.word Suite_CPUBehavior
	.word Suite_UnofficialOps_SLO
	.word Suite_UnofficialOps_RLA
	.word Suite_UnofficialOps_SRE
	.word Suite_UnofficialOps_RRA
	.word Suite_UnofficialOps__AX
	.word Suite_UnofficialOps_DCP
	.word Suite_UnofficialOps_ISC
	.word Suite_UnofficialOps_SH_
	.word Suite_UnofficialOps_Immediates
	.word Suite_CPUInterrupts
	.word Suite_DMATests
	.word Suite_PowerOnState
	.word Suite_PPUBehavior
EndTableTable:




	;; CPU Behavior ;;
Suite_CPUBehavior:
	.byte "CPU Behavior", $FF
	table "CPU Instructions", 		 $FF, result_CPUInstr, DebugTest
	table "Unofficial Instructions", $FF, result_UnofficialInstr, TEST_UnofficialInstructionsExist
	table "ROM is not writable", 	 $FF, result_ROMnotWritable, TEST_ROMnotWritable
	table "RAM Mirroring", 			 $FF, result_RAMMirror, TEST_RamMirroring
	table "PPU Register Mirroring",  $FF, result_PPURegMirror, TEST_PPURegMirroring
	table "PPU Open Bus",			 $FF, result_PPUOpenBus, TEST_PPU_Open_Bus
	table "$FFFF + X Wraparound", 	 $FF, result_FFFF_Plus_X_Wraparound, Test_FFFF_Plus_X_Wraparound
	table "Dummy read cycles", 		 $FF, result_DummyReads, TEST_DummyReads
	table "Dummy write cycles", 	 $FF, result_DummyWrites, TEST_DummyWrites
	table "Open Bus", 				 $FF, result_OpenBus, TEST_OpenBus
	.byte $FF
	
	;; Unofficial Instructions: SLO ;;
Suite_UnofficialOps_SLO:
	.byte "Unofficial Instructions: SLO", $FF
	table "$03   SLO indirect,X", $FF, result_UnOp_SLO_03, TEST_SLO_03
	table "$07   SLO zeropage",   $FF, result_UnOp_SLO_07, TEST_SLO_07
	table "$0F   SLO absolute",   $FF, result_UnOp_SLO_0F, TEST_SLO_0F
	table "$13   SLO indirect,Y", $FF, result_UnOp_SLO_13, TEST_SLO_13
	table "$17   SLO zeropage,X", $FF, result_UnOp_SLO_17, TEST_SLO_17
	table "$1B   SLO absolute,Y", $FF, result_UnOp_SLO_1B, TEST_SLO_1B
	table "$1F   SLO absolute,X", $FF, result_UnOp_SLO_1F, TEST_SLO_1F
	.byte $FF
	
	;; Unofficial Instructions: RLA ;;
Suite_UnofficialOps_RLA:
	.byte "Unofficial Instructions: RLA", $FF
	table "$23   RLA indirect,X", $FF, result_UnOp_RLA_23, TEST_RLA_23
	table "$27   RLA zeropage",   $FF, result_UnOp_RLA_27, TEST_RLA_27
	table "$2F   RLA absolute",   $FF, result_UnOp_RLA_2F, TEST_RLA_2F
	table "$33   RLA indirect,Y", $FF, result_UnOp_RLA_33, TEST_RLA_33
	table "$37   RLA zeropage,X", $FF, result_UnOp_RLA_37, TEST_RLA_37
	table "$3B   RLA absolute,Y", $FF, result_UnOp_RLA_3B, TEST_RLA_3B
	table "$3F   RLA absolute,X", $FF, result_UnOp_RLA_3F, TEST_RLA_3F
	.byte $FF
	
	;; Unofficial Instructions: SRE ;;
Suite_UnofficialOps_SRE:
	.byte "Unofficial Instructions: SRE", $FF
	table "$43   SRE indirect,X", $FF, result_UnOp_SRE_43, TEST_SRE_43
	table "$47   SRE zeropage",   $FF, result_UnOp_SRE_47, TEST_SRE_47
	table "$4F   SRE absolute",   $FF, result_UnOp_SRE_4F, TEST_SRE_4F
	table "$53   SRE indirect,Y", $FF, result_UnOp_SRE_53, TEST_SRE_53
	table "$57   SRE zeropage,X", $FF, result_UnOp_SRE_57, TEST_SRE_57
	table "$5B   SRE absolute,Y", $FF, result_UnOp_SRE_5B, TEST_SRE_5B
	table "$5F   SRE absolute,X", $FF, result_UnOp_SRE_5F, TEST_SRE_5F
	.byte $FF
	
	;; Unofficial Instructions: RRA ;;
Suite_UnofficialOps_RRA:
	.byte "Unofficial Instructions: RRA", $FF
	table "$63   RRA indirect,X", $FF, result_UnOp_RRA_63, TEST_RRA_63
	table "$67   RRA zeropage",   $FF, result_UnOp_RRA_67, TEST_RRA_67
	table "$6F   RRA absolute",   $FF, result_UnOp_RRA_6F, TEST_RRA_6F
	table "$73   RRA indirect,Y", $FF, result_UnOp_RRA_73, TEST_RRA_73
	table "$77   RRA zeropage,X", $FF, result_UnOp_RRA_77, TEST_RRA_77
	table "$7B   RRA absolute,Y", $FF, result_UnOp_RRA_7B, TEST_RRA_7B
	table "$7F   RRA absolute,X", $FF, result_UnOp_RRA_7F, TEST_RRA_7F
	.byte $FF
	
	;; Unofficial Instructions: .AX ;;
Suite_UnofficialOps__AX:
	.byte "Unofficial Instructions: *AX", $FF
	table "$83   SAX indirect,X", $FF, result_UnOp_SAX_83, TEST_SAX_83
	table "$87   SAX zeropage",   $FF, result_UnOp_SAX_87, TEST_SAX_87
	table "$8F   SAX absolute",   $FF, result_UnOp_SAX_8F, TEST_SAX_8F
	table "$97   SAX zeropage,Y", $FF, result_UnOp_SAX_9F, TEST_SAX_97
	table "$A3   LAX indirect,X", $FF, result_UnOp_LAX_A3, TEST_LAX_A3
	table "$A7   LAX zeropage",   $FF, result_UnOp_LAX_A7, TEST_LAX_A7
	table "$AF   LAX absolute",   $FF, result_UnOp_LAX_AF, TEST_LAX_AF
	table "$B3   LAX indirect,Y", $FF, result_UnOp_LAX_B3, TEST_LAX_B3
	table "$B7   LAX zeropage,X", $FF, result_UnOp_LAX_B7, TEST_LAX_B7
	table "$BF   LAX absolute,X", $FF, result_UnOp_LAX_BF, TEST_LAX_BF
	.byte $FF
	
	;; Unofficial Instructions: DCP ;;
Suite_UnofficialOps_DCP:
	.byte "Unofficial Instructions: DCP", $FF
	table "$C3   DCP indirect,X", $FF, result_UnOp_DCP_C3, TEST_DCP_C3
	table "$C7   DCP zeropage",   $FF, result_UnOp_DCP_C7, TEST_DCP_C7
	table "$CF   DCP absolute",   $FF, result_UnOp_DCP_CF, TEST_DCP_CF
	table "$C3   DCP indirect,Y", $FF, result_UnOp_DCP_D3, TEST_DCP_D3
	table "$B7   DCP zeropage,X", $FF, result_UnOp_DCP_D7, TEST_DCP_D7
	table "$BB   DCP absolute,Y", $FF, result_UnOp_DCP_DB, TEST_DCP_DB
	table "$BF   DCP absolute,X", $FF, result_UnOp_DCP_DF, TEST_DCP_DF
	.byte $FF
	
	;; Unofficial Instructions: DCP ;;
Suite_UnofficialOps_ISC:
	.byte "Unofficial Instructions: ISC", $FF
	table "$E3   ISC indirect,X", $FF, result_UnOp_ISC_E3, TEST_ISC_E3
	table "$E7   ISC zeropage",   $FF, result_UnOp_ISC_E7, TEST_ISC_E7
	table "$EF   ISC absolute",   $FF, result_UnOp_ISC_EF, TEST_ISC_EF
	table "$F3   ISC indirect,Y", $FF, result_UnOp_ISC_F3, TEST_ISC_F3
	table "$F7   ISC zeropage,X", $FF, result_UnOp_ISC_F7, TEST_ISC_F7
	table "$FB   ISC absolute,Y", $FF, result_UnOp_ISC_FB, TEST_ISC_FB
	table "$FF   ISC absolute,X", $FF, result_UnOp_ISC_FF, TEST_ISC_FF
	.byte $FF
	
	;; Unofficial Instructions: SH_ ;;
Suite_UnofficialOps_SH_:
	.byte "Unofficial Instructions: SH*", $FF
	table "$93   SHA indirect,Y", $FF, result_UnOp_SHA_93, TEST_SHA_93
	table "$9F   SHA absolute,Y", $FF, result_UnOp_SHA_9F, TEST_SHA_9F
	table "$9B   SHS absolute,Y", $FF, result_UnOp_SHS_9B, TEST_SHS_9B
	table "$9C   SHY absolute,X", $FF, result_UnOp_SHY_9C, TEST_SHY_9C
	table "$9E   SHX absolute,Y", $FF, result_UnOp_SHX_9E, TEST_SHX_9E
	table "$BB   LAE absolute,Y", $FF, result_UnOp_LAE_BB, TEST_LAE_BB
	.byte $FF
	
	;; Unofficial Instructions: The Immediate group ;;
Suite_UnofficialOps_Immediates:
	.byte "Unofficial Immediates", $FF
	table "$0B   ANC Immediate", $FF, result_UnOp_ANC_0B, TEST_ANC_0B
	table "$2B   ANC Immediate", $FF, result_UnOp_ANC_2B, TEST_ANC_2B
	table "$4B   ASR Immediate", $FF, result_UnOp_ASR_4B, TEST_ASR_4B
	table "$6B   ARR Immediate", $FF, result_UnOp_ARR_6B, TEST_ARR_6B
	table "$8B   ANE Immediate", $FF, result_UnOp_ANE_8B, TEST_ANE_8B
	table "$AB   LXA Immediate", $FF, result_UnOp_LXA_AB, TEST_LXA_AB
	table "$CB   AXS Immediate", $FF, result_UnOp_AXS_CB, TEST_AXS_CB
	table "$EB   SBC Immediate", $FF, result_UnOp_SBC_EB, TEST_SBC_EB
	table "Print magic values", $FF, result_UnOp_Magic, TEST_MAGIC
	.byte $FF
	
	
	;; CPU Interrupts ;;
Suite_CPUInterrupts:
	.byte "CPU Interrupts by Blargg", $FF
	table "CLI Latency", $FF, result_Unimplemented, DebugTest
	table "NMI AND BRK", $FF, result_Unimplemented, DebugTest
	table "NMI AND IRQ", $FF, result_Unimplemented, DebugTest
	table "IRQ AND DMA", $FF, result_Unimplemented, DebugTest
	table "Branch delays IRQ", $FF, result_Unimplemented, DebugTest
	.byte $FF
	
	;; DMA Tests ;;
Suite_DMATests:
	.byte "DMA tests", $FF	
	table "DMA + $2007 Read", $FF, result_DMA_Plus_2007R, TEST_DMA_Plus_2007R
	table "DMA + $2007 Write", $FF, result_Unimplemented, DebugTest
	table "DMA + $4016 Read", $FF, result_Unimplemented, DebugTest
	table "DMC DMA + OAM DMA", $FF, result_Unimplemented, DebugTest
	table "DMC DMA Implicit Stop", $FF, result_Unimplemented, DebugTest
	table "DMC DMA Explicit Stop", $FF, result_Unimplemented, DebugTest
	table "APU Register Activation", $FF, result_Unimplemented, DebugTest
	.byte $FF
	
	;; Power On State ;;
Suite_PowerOnState:
	.byte "Power On State", $FF
	table "CPU RAM", $FF, result_PowOn_CPURAM, TEST_PowerOnState_CPU_RAM
	table "CPU Registers", $FF, result_PowOn_CPUReg, TEST_PowerOnState_CPU_Registers
	table "PPU RAM", $FF, result_PowOn_PPURAM, TEST_PowerOnState_PPU_RAM
	table "Palette RAM", $FF, result_PowOn_PPUPal, TEST_PowerOnState_PPU_Palette
	table "PPU Reset Flag", $FF, result_PowOn_PPUReset, TEST_PowerOnState_PPU_ResetFlag
	.byte $FF
	
	;; PPU Stuff ;;
Suite_PPUBehavior:
	.byte "PPU Behavior", $FF
	table "$2002 Race condition", $FF, result_Unimplemented, DebugTest
	table "Palette Corruption", $FF, result_Unimplemented, DebugTest
	.byte $FF
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;              Error Codes                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






	
	.bank 1
	.org $A000
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 TESTS                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
DebugTest:
	LDA #02 ; FAIL! (Error code 0 will let me know the test isn't implemented yet, hence it ran DebugTest.)
	RTS
;;;;;;;
	
TEST_RamMirroring:
	; The $500 page is cleared to all zeroes before the test.
	
	;;; Test 1 [RAM Mirroring]: Reading from mirrors. ;;;
	; When the address bus is in the range $0000 to $1FFF, the CPU will read from RAM.
	; However, RAM only has $800 bytes of memory.
	; When reading from $800 through $1FFF, the CPU still reads from RAM, but only using the lower eleven bits for the address.
	; Therefore, reading from address $0800 is the same thing as reading from $0000. Likewise, $1000 and $1800 also read address $0000.
	; These are referred to as "mirrors" of address $0000. Likewise, $1FFF is a mirror of $07FF, and so on.
	LDA #1
	STA $501 ; Store 1 at $501
	LDA #2
	STA $580 ; Store 2 at $580
	LDA $D01 ; Read from a mirror of $501
	CMP #1
	BNE TEST_Fail ; if any value other than 1 is read, that's a fail.
	LDA $1D80 ; Read from a mirror of $580
	CMP #2
	BNE TEST_Fail ; if any value other than 2 is read, that's a fail.
	INC <currentSubTest 
	
	;;; Test 2 [RAM Mirroring]: writing to mirrors. ;;;
	; The description of test 1 only mentions reading from mirrors, but writing to them follows the exact same behavior.
	LDA #3
	STA $1D02 ; write to a mirror of $502
	LDA #4
	STA $DDD ; write to a mirror of $5DD
	LDA $502 ; Read $502
	CMP #3
	BNE TEST_Fail ; if any value other than 3 is read, that's a fail.
	LDA $5DD ; Read $5DD 
	CMP #4
	BNE TEST_Fail ; if any value other than 3 is read, that's a fail.
	;; END OF TEST ;;	
	LDA #01 ; PASS!
	RTS
;;;;;;;

TEST_Fail:
	LDA <currentSubTest
	ASL A
	ASL A
	ORA #02 ; Fail
	RTS
;;;;;;;

TEST_OpenBus:	
	;;; Test 1 [Open Bus]: Reading from open bus is not all zeroes. ;;;
	; Alright. What is "Open Bus"?
	; When reading from an address that isn't mapped to memory, the data pins are left "floating".
	; Let's learn about the data bus.
	; For instance, imagine LDA <$00. This is a 3 cycle instruction.
	; 1. Fetch the opcode:
	;	- The value of the PC is transferred to the Address Bus, and that address is read. The PC is also incremented.
	;	- When reading from memory, the value that gets read is placed on the data bus, which carries the 8-bit value to the CPU.
	;	- So in this example of LDA <$00, the value read is $A5, so the data bus holds $A5.
	; 2. Fetch the operand:
	;	- The value of the PC is transferred to the Address Bus, and that address is read. The PC is also incremented.
	;	- In this case, the value read is $00, which sets up the address bus for the third cycle of the LDA zeroPage instruction.
	; 3. Read from target address:
	;	- Read the value determined by the address bus. (in this case, that's address $0000)
	;	- The value at address $0000 is put on the data bus, and the CPU takes this value and overwrites the value of the A Register.
	;	
	; Great! So that's how the data bus works. But what happens if you read from somewhere not mapped to anything?
	; Let's see how LDA $5000 works. This has 4 cycles.
	; 1. Fetch the opcode: (The data bus now holds $AD)
	; 2. Fetch the first operand: (The data bus now holds $00)
	; 3. Fetch the second operand: (The data bus now holds $40)
	; 4. Read from target address:
	;	- Since there's nothing mapped to address $5000, the data bus is left floating, and nothing changes.
	;	- Since the value of the data bus is unchanged, it still holds the value $40, which was set during the third cycle.
	;
	; And that's how open bus works!
	; Open bus is typically from $4018 to $7FFF.
	; If the cartridge has "PRG RAM", which is typically from $6000 to $7FFF, then those addresses wouldn't be open bus since they are mapped to something.
	; This cartridge doesn't have any PRG RAM, but I'm only going to test from the $4018 to $5FFF range.
	; Most emulators assume that (unless specified) the cartridge has PRG RAM from $6000 to $7FFF.
	;
	; This test only checks for open bus from $4020 through $5FFF. 
	; Though I think it should be implied that $6000 through $7FFF should be open bus as well, the iNES format implies 8 KiB of PRG RAM at $6000–$7FFF
	; Therefore this ROM needs to be NES 2.0 just to guarantee the open bus there, assuming the emulator is NES 2.0 compliant.
	;
	; anyway, some emulators might just assume reading from this range always returns 00, which is incorrect. Let's test for that!
	LDA $5000
	BEQ TEST_Fail
	LDA $4654
	BEQ TEST_Fail
	INC <currentSubTest 
	
	;;; Test 2 [Open Bus]: Reading from open bus always returns the high byte of the address read. ;;;
	; As explained above, when reading from one of these addresses, the second operand is the value that remains on the databus.
	; so, reading from $5501 should set A to $55, as the high byte is the most recently read value.
	
	LDA $5501
	CMP #$55
	BNE TEST_Fail
	LDA $4020
	CMP #$40
	BNE TEST_Fail
	LDA $5FFF
	CMP #$5F
	BNE TEST_Fail
	INC <currentSubTest
	
	;;; Test 3 [Open Bus]: Reading from open bus with an offset crossing a page boundary. ;;;
	; But the rule of "the high byte is the value returned" isn't always the case.
	; As you can see, using an offset to cross a page boundary will not update the data bus!
	LDY #$10
	LDA $50F8, Y ; This offset changes the high byte of the value read, but not the data bus.
	CMP #$50
	BNE TEST_Fail
	INC <currentSubTest
	
	;;; Test 4 [Open Bus]: The upper 3 bits when reading from the controller are open bus. ;;;
	; This is just checking to see if the controllers have the open bus bits.
	LDA $4016
	AND #$E0
	CMP #$40 ; Bit 6 when reading a controller is pretty much always going to be set due to open bus.
	BNE TEST_Fail
	INC <currentSubTest
	
	;;; Test 5 [Open Bus]: The databus actually exists, and the open bus behavior isn't being faked. ;;;
	; This is tested by moving the program counter to open bus, and running a very choreographed function.
	; Here is what is expected to run in open bus:
	; LSR <$56, X
	; RTS
	;
	; Here's what could go wrong:
	; Open bus behavior is faked, specifically by always returning the high byte from this address range.
	; in which case, `LSR <$56, X` will run until $5700, running `SRE <$57, X` until $5800, running `CLI` until $5900, and so on.
	; In that case, once the PC reaches $6000, it will run RTS, however the falgs and stuff will be wrong, so we can check for that.
	; 
	; It's also possible the same thing will happen, but instead of RTS, it runs BRK. Either way, that's a fail.
	; Since that's a possibility, set up the IRQ routine.
	LDX #0
TEST_OpenBus_PrepIRQLoop:
	LDA TEST_OpenBus_IRQRoutine,X ; TEST_OpenBus_IRQRoutine can be found at the end of this test. It's just a bunch of PLA's and a JMP to TEST_Fail.
	STA $600, X
	INX
	CPX #8
	BNE TEST_OpenBus_PrepIRQLoop
	; and prep for the test:
	LDA #$C0 ; this will get ROR'ed into an RTS instruction... hopefully.
	STA <$56 ; store it in RAM, ready for the test.
	LDX #0	 ; X needs to be zero for this.
	JSR $5600; open bus!
	; We made it back safely
	; if a BRK occured, or if we rolled into $8000, we failed.
	; however, if we incorrectly executed address $6000 for the RTS, we can check for this by Loading $56
	LDA <$56
	CMP #$60
	BNE TEST_Fail
	INC <currentSubTest 
	
	;;; Test 6 [Open Bus]: Dummy Reads update databus, test by reading $4015 ;;;
	; This doubles as a test of dummy read cycles, and the PPU Databus. Here's what happens.
	; LDA $3FFF, X (X=$16)
	; 1: fetch opcode 
	; 2: fetch low byte
	; 3: fetch high byte, add the X offset to the low byte
	; 4: READ $3F15, then fix the high byte
	; 5: READ $4015.
	;
	; $3F15 is a mirror of $2005, which when read returns PPU Open Bus.
	; So we need to set the PPU Bus to something first.
	LDA #0
	STA $2002
	LDX #$16
	JMP TEST_OpenBus_ContinueTest6 ; Skip to TEST_OpenBus_ContinueTest6
	;; If you are reading this for test 6, just ignore these next few lines. ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_OpenBusA0A0:              ; This is a fail-safe for test 8. It needed to be at address $A0A0.	         ;;
	SEI						   ; The RTI instruction pulled off some junk and we need to re-set the i flag.  ;;
	LDX #1                     ; X=1, which is used to tell test 8 that it failed.                           ;;
	JMP TEST_OpenBus_PostTest8 ; Jump to the end of test 8.                                                  ;;
TEST_OpenBus_ContinueTest6:    ; Anyway, that was the greatest crime against programming I've ever commited. ;;
	;; And now, back to your regularly scheduled program. ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; let's run the test.
	LDA $3FFF,X 
	AND #$20 ; Let's only check bit 5, since that's the open bus bit of address $4015
	CMP #$00 ; bit 5 is a zero, since that was what was read from $3F15
	BNE TEST_Fail2
	; Let's set the PPU Bus to $FF and run it again!
	LDA #$FF
	STA $2002
	LDA $3FFF,X
	AND #$20 ; Again, only check bit 5.
	CMP #$20 ; Bit 5 was set when reading from the PPU Bus, so bit 5 of $4015 should be set.
	BNE TEST_Fail2 
	INC <currentSubTest 
	
	;;; Test 7 [Open Bus]: Reading from $4015 does not update the databus. ;;;
	; Address $4015 is special. All the values read here are internal to the 2A03 chip, so the databus isn't used. 
	;
	; LDA $40FF, X (X=$16)
	; 1: fetch opcode 
	; 2: fetch low byte
	; 3: fetch high byte, add the X offset to the low byte
	; 4: READ $4015, then fix the high byte
	; 5: READ $4115.
	;
	; The value read from $4015 will be zero, but that does NOT change the databus!
	; Therefore, the value read from $4115 will still be $40 from when the high byte was fetched.
	LDA $40FF,X
	CMP #$40
	BNE TEST_Fail2
	INC <currentSubTest 
	
	;;; Test 8 [Open Bus]: Writing always updates the databus, even writing to $4015 ;;;
	; LSR <56,X
	; 	$CD >> 1 = $66 + Carry set
	; ROR <$66
	;	$22 >> 1 = $91
	; STA ($91),Y
	; A=60 -> ($15, $40)
	;
	; How could this one go wrong? Well, if writing to $4015 does not update the databus, this will run RTI instead of RTS.
	; We can prep for this by pushing $A0 to the stack, so if an RTI occurs, we'll return to TEST_OpenBusA0A0
	LDX #0
	LDY #0
	LDA #$CD
	STA <$56 ; $56 = #$CD
	LDA #$22
	STA <$66 ; $66 = #$22
	LDA <$91 ; Push these to the stack
	PHA
	LDA <$92 ; These are important bytes for the test selection menu, so we'll restore these after the test.
	PHA
	LDA #$15
	STA <$91
	LDA #$40
	STA <$92 ; ($91) = $4015
	LDA #$A0
	PHA
	LDA #$60 ; A = the value of RTS
	JSR $5600 ; Jump to open bus to run this!
	; and if we made it back here, the test worked!
	; restore the values from $91 and $92
	PLA ; pull off the $A0 for the RTI guardrails.
TEST_OpenBus_PostTest8:
	PLA
	STA <$92
	PLA
	STA <$91
	TXA ; X = 0 if we ran RTS, X = 1 if we ran RTI.
	CPX #$01
	BEQ TEST_Fail2	
	;; END OF TEST ;;	
TEST_Pass2:
	LDA #1
	RTS
TEST_OpenBus_IRQRoutine: 
	; This is used in test 4 when we jump to open bus. If the behavior is inaccurate, a BRK is likely to run.
	; We want to run the following code if a BRK occurs, so this gets copied to the IRQ routine in RAM.
	PLA
	PLA
	PLA
	PLA
	PLA
TEST_Fail2:
	JMP TEST_Fail ; This is part of TEST_OpenBus_IRQRoutine, but I'm re-using this JMP to save bytes.
;;;;;;;
	
TEST_ROMnotWritable:
	;;; Test 1 [ROM is not Writable]: Writing to ROM does nothing. ;;;
	; This is an NROM cartridge, so there aren't banks to swap or anything
	LDA #$02 ; 02 = FAIL
	STA CannotWriteToROM_01 ; This address holds a $01
	LDA CannotWriteToROM_01 ; If ROM was updated, you read a 2, which fails the test.
	;; END OF TEST ;;
	RTS						; else, return 1, thus passing.
;;;;;;;

TEST_PPURegMirroring:
	;;; Test 1 [PPU Register Mirroring]: PPU Registers are mirrored through $3FFF ;;;
	; The registers from $2000 to $2007 get repeated every 8 bytes.
	; I'm only testing mirrors of PPUADDR and PPUDATA, but surely if those are implemented, the rest are too.
	LDX #$28     ; Move the PPU v register to $2800
	STX $2006+8  ; A mirror of PPUADDR
	LDY #$00
	STY $2006+16 
	LDA #$01
	STA $2007+32 ; A mirror of PPUDATA
	STX $2006+64 ; Move the PPU v register back to $2800
	STY $2006+128
	LDA $2007+256; Read the buffer
	LDA $3FFF    ; Read the value at VRAM $2800
	PHA	         ; Push the results to the stack
	STX $2006    ; The test has already concluded, so let's not bother with mirrors.
	STY $2006    ; Clear that value back to a $24
	LDA #$24
	STA $2007
	JSR ResetScroll
	PLA          ; Pull the results off the stack
	CMP #$01
	BNE TEST_Fail2
	;; END OF TEST ;;
	RTS
;;;;;;;;;;;;;;;;;;

TEST_DummyReads:
	; Pre-Test preparations.
	LDA #$20
	STA <$51
	LDA #$02
	STA <$50 ; ($50) points to $2002
	LDA #$3F
	STA <$53
	LDA #$F0
	STA <$52 ; ($52) points to $3FF0
	
	;;; Test 1 [Dummy Read Cycles]: LDA $2002, X (where X=0) reads $2002 twice. ;;;
	; Since reading $2002 clears bit 7 of PPUSTATUS, we can check if dummy reads are happening by running dummy reads on $2002, then checking bit 7.
	; Let's walk through the LDA $2002, X instruction cycle by cycle.
	; 1: fetch opcode 
	; 2: fetch low byte
	; 3: fetch high byte, add the X offset to the low byte
	; 4: Read $2002, if adding the offset crosses a page boundary (in this case it did not), update the high byte.
	; 5: Read $2002.
	;
	; Focus on cycle 4. That's the dummy read.
	
	LDX #$10
	JSR Clockslide_29780 ; Wait a frame so the VBlank flag (bit 7) gets set
	LDA $20F2, X ; If bit 7 of A gets set, then $2002 was only read once.
	BMI TEST_Fail2
	INC <currentSubTest 
	
	;;; Test 2 [Dummy Read Cycles]: The dummy read does NOT occur if a page boundary is not crossed ;;;	
	LDX #0
	JSR Clockslide_29780 ; Wait a frame so the VBlank flag (bit 7) gets set
	LDA $2002, X ; The page boundary is not crossed, so there should only have been 1 read.
	BPL TEST_Fail2
	INC <currentSubTest 
	
	;;; Test 3 [Dummy Read Cycles]: The dummy read is on the correct address ;;;	
	; The dummy read happens after the low byte is updated, but before the high byte.
	LDX #$62
	JSR Clockslide_29780 ; Wait a frame so the VBlank flag gets set
	LDA $3FF0, X ; Dummy read $3F52 (A mirror of $2002), then read $4052 (Open bus emulation is NOT needed to pass this test!)
	LDA $2002	 ; ; If bit 7 of A gets set, then the dummy read was from the wrong address (bit 7 of $2002 was not cleared by the dummy read).
	BMI TEST_Fail2
	INC <currentSubTest 	
	
	;;; Test 4 [Dummy Read Cycles]: STA $2002, X (where X=0) reads $2002 once. ;;;
	LDX #0
	JSR Clockslide_29780 ; Wait a frame so the VBlank flag gets set
	STA $2002, X ; The dummy read cycle will read from $2002.
	LDA $2002	 ; If bit 7 of A gets set, then $2002 was not read during the STA
	BMI TEST_Fail2
	INC <currentSubTest 	
	
	;;; Test 5 [Dummy Read Cycles]: STA dummy read is on the correct address ;;;
	LDX #$62
	JSR Clockslide_29750 ; Wait (slightly less than) a frame so the VBlank flag gets set
	STA $3FF0, X ; The dummy read cycle will read from $2002.
	LDA $2002	 ; If bit 7 of A gets set, then $2002 was not read during the STA
	BMI TEST_Fail3
	INC <currentSubTest 	

	;;; Test 6 [Dummy Read Cycles]: LDA ($2002),Y (where Y=3) does not have a dummy read. ;;;
	; The page boundary isn't crossed, so no dummy read.
	LDY #1

	JSR Clockslide_29750 ; Wait (slightly less than) a frame so the VBlank flag gets set
	LDA [$0050],Y  ; The dummy read does NOT happen because a page boundary was not crossed.
	LDA $2002 ; The dummy read didn't occur, so bit 7 should be set.
	BPL TEST_Fail3 
	INC <currentSubTest 	
	
	;;; Test 7 [Dummy Read Cycles]: LDA ($3FF0),Y (where Y=62) dummy read occurs, and is on the correct address ;;;
	LDY #$62
	JSR Clockslide_29750 ; Wait (slightly less than) a frame so the VBlank flag gets set
	LDA [$0052],Y
	LDA $2002	 ; If bit 7 of A gets set, then $2002 was not read during the LDA
	BMI TEST_Fail3
	INC <currentSubTest 
	
	;;; Test 8 [Dummy Read Cycles]: STA ($2002),Y (where Y=1) does not have a dummy read. ;;;
	; The page boundary isn't crossed, so no dummy read.
	LDY #1
	JSR Clockslide_29750 ; Wait (slightly less than) a frame so the VBlank flag gets set
	STA [$0050],Y
	LDA $2002	 ; The dummy read didn't occur, so bit 7 should be set.
	BPL TEST_Fail3
	INC <currentSubTest 
	
	;;; Test 9 [Dummy Read Cycles]: STA ($3FF0),Y (where Y=62) dummy read is on the correct address ;;;
	LDY #$62
	JSR Clockslide_29750 ; Wait (slightly less than) a frame so the VBlank flag gets set
	STA [$0052],Y
	LDA $2002	 ; If bit 7 of A gets set, then $2002 was not read during the STA
	BMI TEST_Fail3
	INC <currentSubTest 
	
	;;; Test A [Dummy Read Cycles]: LDA ($2002,X) does not dummy-read $2002 ;;;
	LDX #0
	JSR Clockslide_29750 ; Wait (slightly less than) a frame so the VBlank flag gets set
	LDA [$50,X]
	BPL TEST_Fail3 ; If bit 7 of A is set, then we pass the test. The dummy read was at $0050, which we can't test for.
	INC <currentSubTest 	
	
	;;; Test B [Dummy Read Cycles]: STA ($2002,X) does not dummy-read $2002 ;;;
	LDX #0
	JSR Clockslide_29780 ; Wait  a frame so the VBlank flag gets set
	STA [$50,X]
	BPL TEST_Fail3 ; If bit 7 of A is set, then we pass the test. The dummy read was at $0050, which we can't test for.	
	;; END OF TEST ;;
	LDA #1
	RTS
TEST_Fail3:
	JMP TEST_Fail
;;;;;;;

TEST_DummyWrites_Prep:
	; Load VRAM[2400] with #0
	; Load VRAM[2401] with #1
	; Load VRAM[2402] with #2
	; Load VRAM[2403] with #3
	; keep Y unchanged.
	STY <$FE
	LDA $2002
	LDA #$24
	STA $2006
	LDA #0
	STA $2006
	TAX
	LDY #10
TEST_DummyWritesPrepLoop:
	STX $2007
	INX
	DEY
	BNE TEST_DummyWritesPrepLoop
	LDA #$24
	STA $2006
	LDA #0
	STA $2006
	LDY <$FE
	RTS
;;;;;;;
TEST_PPU_Open_Bus:
	;;; Test 1 [PPU Open Bus]: Verify PPU Open Bus exists. ;;;
	; Don't worry, this this is remarkably simple.
	LDX #0
	LDY #1
	LDA #$5A
	STA $2002 ; Address $2002 is read-only. This puts $5A on the ppu bus.
	TXA	  ; clear A for the test.
	LDA $2000 ; Address $2000 is write-only, so teh value read is the value of the PPU bus. ($5A)
	CMP #$5A
	BNE TEST_FailPPUOpenBus
	INC <currentSubTest 
	
	;;; Test 2 [PPU Open Bus]: All PPU Registers update PPU Open Bus. ;;;
	; Writing to $2000 updates the PPU Databus
	LDA <PPUCTRL_COPY
	STA $2000 ; this updates the PPU bus and changes nothing with the register... hopefully.
	TXA
	LDA $2001 ; read a different write-only register.
	CMP <PPUCTRL_COPY
	BNE TEST_FailPPUOpenBus
	
	; Writing to $2001 updates the PPU Databus
	LDA <PPUMASK_COPY
	STA $2001
	TXA
	LDA $2000
	CMP <PPUMASK_COPY
	BNE TEST_FailPPUOpenBus

	; we've already tested writing to $2002
	
	; Writing to $2003 updates the PPU Databus
	LDA #04
	STA $2003
	TXA
	LDA $2000
	CMP #04
	BNE TEST_FailPPUOpenBus
	
	; Writing to $2004 updates the PPU Databus
	LDA #$FF
	STA $2004
	TXA
	LDA $2000
	CMP #$FF
	BNE TEST_FailPPUOpenBus
	
	; Writing to $2005 updates the PPU Databus
	LDA $2002
	LDA #$00
	STA $2005
	TYA
	LDA $2000
	CMP #$00
	BNE TEST_FailPPUOpenBus
	
	; Writing to $2006 updates the PPU Databus
	LDA $2002
	LDA #$20
	STA $2006
	TXA
	LDA $2000
	CMP #$20
	BNE TEST_FailPPUOpenBus
	
	; Writing to $2007 updates the PPU Databus
	LDA #$24
	STA $2007
	TYA
	LDA $2000
	CMP #$24
	BNE TEST_FailPPUOpenBus
	INC <currentSubTest 
	
	;;; Test 3 [PPU Open Bus]: Address $2002, bits 0 through 4 are open bus ;;;
	LDA $2002
	LDA #$15
	STA $2006
	LDA $2002
	AND #$1F
	CMP #$15
	BNE TEST_FailPPUOpenBus

	;; END OF TEST ;;
	LDA #01
	RTS
;;;;;;;
TEST_FailPPUOpenBus:
	JMP TEST_Fail

TEST_DummyWritePrep_SetUpV:
	LDA #$25
	STA $2006
	LDA #$FA
	STA $2006
	RTS
;;;;;;;

TEST_DummyWritePrep_PPUADDR25FA: ; This exists to save bytes
	JSR SetPPUADDRFromWord
	.byte $25, $FA
	LDA #$25
	STA $2002 ; Set the PPU Open bus value to 25
	RTS
;;;;;;;

TEST_DummyWritePrep_26: ; This exists to save bytes
	JSR TEST_DummyWritePrep_PPUADDR25FA ; just leech off this to save bytes.
	LDA #$26
	STA $2002 ; Set the PPU Open bus value to 26
	RTS
;;;;;;;

TEST_DummyWrites:
	; Special thanks to bisqwit and blargg for creating a test for dummy writes. (I'm pretty much just doing what they did.)
	; Consider the ASL instruction.
	; This is a "Read-Modify-Write" instruction, for it does the following:
	; Read target address, modify the value, and write it back.
	; But that's not the whole story, as this instruction has "Dummy Writes", and it can have dummy reads too!
	; Consider ASL $0400. Let's see every cycle of this instruction.
	; 1: fetch opcode 
	; 2: fetch low byte
	; 3: fetch high byte
	; 4: Read $0400.
	; 5: Write the value back to $0400, then do the operation on this value. (arithmetic shift left)
	; 6: Write this new value to $0400.
	;
	; Focus on cycle 5. That's the dummy write.
	
	;;; Test 1 [Dummy Write Cycles]: Verify PPU Open Bus exists. ;;;
	; This Dummy Write test relies on PPU Open Bus, so if it's not emulated we cannot check for dummy writes accurately.
	JSR TEST_PPU_Open_Bus	; It feels pretty silly running another test inside this test.
	CMP #$01				; But hey, it saves on bytes.
	BNE TEST_FailPPUOpenBus
	INC <currentSubTest 
	
	; Here's how the test works.
	; Prep the PPU databus with a specific value, usually 25 or 26.
	; RMW $2006. Read $2006 (PPU open bus), Dummy Write $2006 and modify value read, write $2006 again.
	; If we know where the writes will take the 'v' register, then we can simply read $2007 twice after this test to verify the dummy writes occured.
	
	; Let's make some preparations...
	JSR ResetScrollAndWaitForVBlank
	
	; Let me explain this subroutine real quick.
	; The return address is modified inside this subroutine, so it returns to the polit after the following bytes.
	; Basically, WriteToPPUADDRWithByte will read the two bytes after it, and store them to $2006, then the third byte is stored at $2007.
	; Then, if the following byte if $FF, exit the subroutine. Othwerwise, grab the next 3 bytes and do it again.
	JSR WriteToPPUADDRWithByte
	.byte $25, $4A, $5A ; VRAM[$254A] = $5A
	.byte $25, $4B, $5C ; VRAM[$254B] = $5C
	.byte $25, $12, $F1 ; VRAM[$2512] = $F1
	.byte $25, $92, $7E ; VRAM[$2592] = $7E
	.byte $25, $24, $11 ; VRAM[$2524] = $11
	.byte $25, $26, $22 ; VRAM[$2526] = $22
	
	.byte $26, $4C, $8D ; VRAM[$264C] = $8D
	.byte $26, $4D, $A5 ; VRAM[$264D] = $A5
	.byte $26, $13, $F0 ; VRAM[$2613] = $F0
	.byte $26, $93, $36 ; VRAM[$2693] = $36
	.byte $26, $25, $98 ; VRAM[$2625] = $98
	.byte $26, $27, $4F ; VRAM[$2627] = $4F
	.byte $FF ; Terminator.
	JSR ResetScrollAndWaitForVBlank

	;;; Test 2 [Dummy Write Cycles]: See if Read-Modify-Write instructions write to $2006 twice. ;;;
	JSR TEST_DummyWritePrep_PPUADDR25FA ; v = 25FA, PpuBus = $25
	ASL $2006							; v = 254A
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$5A
	BNE TEST_FailDummyWrites
	
	JSR TEST_DummyWritePrep_PPUADDR25FA ; v = 25FA, PpuBus = $25
	SEC
	ROL $2006							; v = 254B
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$5C
	BNE TEST_FailDummyWrites
	
	JSR TEST_DummyWritePrep_PPUADDR25FA ; v = 25FA, PpuBus = $25
	LSR $2006							; v = 2512
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$F1
	BNE TEST_FailDummyWrites
	
	JSR TEST_DummyWritePrep_PPUADDR25FA ; v = 25FA, PpuBus = $25
	SEC
	ROR $2006							; v = 2592
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$7E
	BNE TEST_FailDummyWrites
	
	JSR TEST_DummyWritePrep_PPUADDR25FA ; v = 25FA, PpuBus = $25
	DEC $2006							; v = 2524
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$11 ;
	BNE TEST_FailDummyWrites
	
	JSR TEST_DummyWritePrep_PPUADDR25FA ; v = 25FA, PpuBus = $25
	INC $2006							; v = 2526
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$22 ;
	BNE TEST_FailDummyWrites
	INC <currentSubTest 
	JMP TEST_DummyWritesPt2
;;;;;;;
TEST_FailDummyWrites:
	JMP TEST_Fail
TEST_DummyWritesPt2:
	JSR ResetScrollAndWaitForVBlank
	;;; Test 3 [Dummy Write Cycles]: See if Read-Modify-Write instructions with X indexing write to $2006 twice. ;;;
	LDX #6
	JSR TEST_DummyWritePrep_26 ; v = 25FA, PpuBus = $26
	ASL $2000,X			       ; v = 264C
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$8D
	BNE TEST_FailDummyWrites
	
	JSR TEST_DummyWritePrep_26 ; v = 25FA, PpuBus = $26
	SEC
	ROL $2000,X			       ; v = 264D
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$A5
	BNE TEST_FailDummyWrites
	
	JSR TEST_DummyWritePrep_26 ; v = 25FA, PpuBus = $26
	LSR $2000,X			       ; v = 2613
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$F0
	BNE TEST_FailDummyWrites
	
	JSR TEST_DummyWritePrep_26 ; v = 25FA, PpuBus = $26
	SEC
	ROR $2000,X			       ; v = 2693
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$36
	BNE TEST_FailDummyWrites
	
	JSR TEST_DummyWritePrep_26 ; v = 25FA, PpuBus = $26
	DEC $2000,X			       ; v = 2625
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$98 ;
	BNE TEST_FailDummyWrites
	
	JSR TEST_DummyWritePrep_26 ; v = 25FA, PpuBus = $26
	INC $2000,X			       ; v = 2627
	JSR DoubleLDA2007 ; Read from VRAM
	CMP #$4F ;
	BNE TEST_FailDummyWrites
	
	;; END OF TEST ;;
	LDA #01
	RTS


TEST_PowerOnState_CPU_RAM:
	;;; Test 1 [CPU RAM Power On State]: Print the values recorded at power on ;;;
	JSR ClearNametableFrom2240
	JSR ResetScrollAndWaitForVBlank
	JSR Print32Bytes
	.word $2244
	.word PowerOnRAM
	JSR ResetScroll
	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;	

TEST_PowerOnState_PPU_RAM:
	;;; Test 1 [PPU RAM Power On State]: Print the values recorded at power on ;;;
	JSR ClearNametableFrom2240
	JSR ResetScrollAndWaitForVBlank
	JSR Print32Bytes
	.word $2244
	.word PowerOnVRAM
	JSR ResetScroll
	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;	

TEST_PowerOnState_PPU_Palette:
	;;; Test 1 [Palette RAM Power On State]: Print the values recorded at power on ;;;
	JSR ClearNametableFrom2240
	JSR ResetScrollAndWaitForVBlank
	JSR Print32Bytes
	.word $2244
	.word PowerOnPalette
	JSR ResetScroll
	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;	

TEST_PowerOnState_PPU_ResetFlag:
	;;; Test 1 [PPU Reset Flag]: Print the value recorded at power on ;;;
	JSR ClearNametableFrom2240
	JSR ResetScrollAndWaitForVBlank
	LDA PowerOnTest_PPUReset
	;; END OF TEST ;;
	RTS
;;;;;;;

TEST_PowerOnState_CPU_Registers:
	;;; Test 1 [CPU Registers Power On State]: Print the values recorded at power on ;;;
	JSR ClearNametableFrom2240
	JSR ResetScrollAndWaitForVBlank
	LDA #0
	STA <dontSetPointer
	
	JSR PrintText
	.word $2252
	.byte "A ", $FF
	LDA PowerOn_A
	JSR PrintByte
	
	JSR PrintText
	.word $2272
	.byte "X ", $FF
	LDA PowerOn_X
	JSR PrintByte
	
	JSR PrintText
	.word $2292
	.byte "Y ", $FF
	LDA PowerOn_Y
	JSR PrintByte

	JSR ResetScrollAndWaitForVBlank

	JSR PrintText
	.word $22A6
	.byte "Stack Pointer ", $FF
	LDA PowerOn_SP
	JSR PrintByte
	
	JSR PrintText
	.word $22C4
	.byte "Processor flags ", $FF
	LDA PowerOn_P
	JSR PrintByte
	;; END OF TEST ;;
	JSR ResetScroll
	LDA #1
	STA <dontSetPointer
	RTS
;;;;;;;

TEST_Fail4:
	JMP TEST_Fail
TEST_UnofficialInstructions_Prep:
	LDA #$42
	STA $500
	STA <$50
	LDA #0
	TAX
	TAY
	RTS
TEST_UnofficialInstructionsExist:
	;;; Test 1 [Unofficial Instructions Exist]: What happens when we run an unofficial opcode? ;;;
	; This test does NOT verify accurate emulation of every one of these instructions.
	; It just makes sure they all vaguely perform what's expected of them, instead of NOP.
	; For instructions with many different addressing modes, This only checks the Immediate mode if it exists, or Absolute.
	; let's run a 3-byte NOP, and check if it was actually 3 bytes.
	LDA #0
	LDX #0
	LDY #$0F
	; The following should be: NOP $98A2	
	.byte $0C, $A2, $98
	; But if this was treated as a 1-byte NOP, X=98
	CPX #$98
	BEQ TEST_Fail4
	INC <currentSubTest 
	
	;;; Test 2 [Unofficial Instructions Exist]: Was it a 2-byte nop? ;;;
	; And if this was treated as a 2-byte NOP, A=0F
	CMP #$0F
	BEQ TEST_Fail4
	; Alright! It was treated as a 3-byte NOP, which is what it should be.
	INC <currentSubTest 
	
	;;; Test 3 [Unofficial Instructions Exist]: NOP Absolute updates PPUSTATUS ;;;
	JSR Clockslide_29780 ; wait for next frame.
	.byte $0C, $02, $20 ; NOP $2002
	LDA $2002
	BMI TEST_Fail4 ; if bit 7 was still set after that NOP $2002, that's a fail!
	INC <currentSubTest 
	
	;;; Test 4 [Unofficial Instructions Exist]: Does SLO exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$0F
	.byte $0F ; SLO Absolute
	.word $0500; $SLO $0500
	; A |= ($42 << 1) -> $8F
	CMP #$8F
	BNE TEST_Fail4
	LDA $0500
	CMP #$84
	BNE TEST_Fail4
	; SLO exists!
	INC <currentSubTest 

	;;; Test 5 [Unofficial Instructions Exist]: Does ANC exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$8F
	CLC
	.byte $0B, $8C ; ANC #$8C
	; A &= $8C -> $8C
	BCC TEST_Fail4
	CMP #$8C
	BNE TEST_Fail4
	; ANC exists!
	INC <currentSubTest
	
	;;; Test 6 [Unofficial Instructions Exist]: Does RLA exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$F1
	SEC
	.byte $2F ; RLA Absolute
	.word $0500; $RLA $0500
	; A &= (($42 << 1) | Carry) -> $81
	CMP #$81
	BNE TEST_Fail4
	LDA $0500
	CMP #$85
	BNE TEST_Fail4
	; RLA exists!
	INC <currentSubTest 
	
	;;; Test 7 [Unofficial Instructions Exist]: Does SRE exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$FF
	SEC
	.byte $4F ; SRE Absolute
	.word $0500; $SRE $0500
	; A ^= ($42 >> 1) -> $DE
	CMP #$DE
	BNE TEST_Fail4	
	; SRE exists!
	INC <currentSubTest 
	
	;;; Test 8 [Unofficial Instructions Exist]: Does ASR exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$F0
	.byte $4B, $42 ; ASR #$42
	; A = (A & $42) >> 1 = $20
	CMP #$20
	BNE TEST_Fail5	
	; ASR exists!
	INC <currentSubTest
	
	;;; Test 9 [Unofficial Instructions Exist]: Does RRA exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$20
	SEC
	.byte $6F ; RRA Absolute
	.word $0500; $RRA $0500
	; A += ($42 >> 1) | $80*Carry = $C1
	CMP #$C1
	BNE TEST_Fail5	
	; RRA exists!
	INC <currentSubTest 
	
	;;; Test A [Unofficial Instructions Exist]: Does ARR exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$F0
	SEC
	.byte $6B, $42 ; ARR #$42
	; A = ((A & $42) >> 1) | $80*Carry = $A0
	; NOTE: This instruction also changes the flags in a unique way.
	; I'm not testing for hte flag stuff here.
	CMP #$A0
	BNE TEST_Fail5		
	; ARR exists!
	INC <currentSubTest
	
	;;; Test B [Unofficial Instructions Exist]: Does SAX exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$F0
	LDX #$2F
	.byte $8F ; SAX $0500
	.word $0500
	;$500 = (A&X)
	LDA $0500
	CMP #$20
	BNE TEST_Fail5
	; SAX exists!
	INC <currentSubTest
	
	;;; Test C [Unofficial Instructions Exist]: Does ANE exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$FF
	LDX #$F0
	.byte $8B, $30 ; ANE #$30
	; Due to the way this instruction varies on different CPUs, let's just confirm A is no longer $FF
	CMP #$FF
	BEQ TEST_Fail5	
	; ANE exists!
	INC <currentSubTest
	
	;;; Test D [Unofficial Instructions Exist]: Does SHA exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	; Test the unstable part too, why not.
	LDA #$0D
	LDX #$15
	LDY #$80
	.byte $9F ; SHA $0500
	.word $1E80 ; Use a mirror
	; This goes unstable, so the high byte of the target address will be changed.
	; Hi = ($1E+1) & A & X;
	; 	 = $05
	; $500 = A & X & H
	;	   = $0D & $15 & $1F
	;	   = 5
	; H is the high byte of the target address +1.
	; So we should write $05 to $0500
	LDA $0500
	CMP #$05
	BNE TEST_Fail5
	; SHA exists!
	INC <currentSubTest
	
	;;; Test E [Unofficial Instructions Exist]: Does SHX exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$00
	LDX #$05
	LDY #$80
	.byte $9E ; SHX $0500
	.word $1E80 ; Use a mirror
	; This goes unstable, so the high byte of the target address will be changed.
	; Hi = ($1E+1) & X;
	; 	 = $05
	; $500 = X & H
	; H is the high byte of the target address +1.
	; So we should write $05 to $0500
	LDA $0500
	CMP #$05
	BNE TEST_Fail5
	; SHX exists!
	INC <currentSubTest
	
	JMP TEST_UnofficialInstructions_Continue
TEST_Fail5:	; This is in the middle of the test, since it saves bytes to branch here.
	JMP TEST_Fail
TEST_UnofficialInstructions_Continue:

	;;; Test F [Unofficial Instructions Exist]: Does SHY exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$00
	LDX #$80
	LDY #$05
	.byte $9C ; SHY $0500
	.word $1E80 ; Use a mirror
	; This goes unstable, so the high byte of the target address will be changed.
	; Hi = ($1E+1) & Y;
	; 	 = $05
	; $500 = Y & H
	; H is the high byte of the target address +1.
	; So we should write $05 to $0500
	LDA $0500
	CMP #$05
	BNE TEST_Fail5
	; SHY exists!
	INC <currentSubTest
	
	;;; Test G [Unofficial Instructions Exist]: Does SHS exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	TSX
	STX $501
	LDA #$0D
	LDX #$15
	LDY #$80
	.byte $9B ; SHS $0500
	.word $1E80 ; Use a mirror
	; This goes unstable, so the high byte of the target address will be changed.
	; Hi = ($1E+1) & A & X;
	; 	 = $05
	; $500 = X & H
	; H is the high byte of the target address before adding the Y offset.
	; So we should write $05 to $0500
	; Before we check $0500, this instruction just destroyed the stack pointer.
	TSX
	CPX $0501
	BNE TEST_UnofficialInstructions_SHS_Continue
	; The stack pointer was unchanged?!
	JMP TEST_Fail
TEST_UnofficialInstructions_SHS_Continue:
	LDX $501
	TXS ; Fix the stack pointer.
	LDA $0500
	CMP #$05 ; See if this was the right value too.
	BNE TEST_Fail5
	; SHS exists!
	INC <currentSubTest
	
	;;; Test H [Unofficial Instructions Exist]: Does SHA ($zp), Y exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	; Test the unstable part too, why not.
	LDA #$80
	STA <$50
	LDA #$1E
	STA <$51 ; ($51) = $1E80
	LDA #$0D
	LDX #$15
	LDY #$80
	.byte $93, $50 ; SHA ($50) -> $1E80
	; This goes unstable, so the high byte of the target address will be changed.
	; Hi = ($1E+1) & A & X;
	; 	 = $05
	; $500 = A & X & H
	;	   = $0D & $15 & $1F
	;	   = 5
	; H is the high byte of the target address +1.
	; So we should write $05 to $0500
	LDA $0500
	CMP #$05
	BNE TEST_Fail5
	; SHA ($zp), Y exists!
	INC <currentSubTest

	;;; Test I [Unofficial Instructions Exist]: Does LAX exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	.byte $AF ; LAX $0500
	.word $0500
	;A = $0500; X = $0500
	CMP $0500
	BNE TEST_Fail5
	CPX $0500
	BNE TEST_Fail5
	; LAX exists!
	INC <currentSubTest
	
	;;; Test J [Unofficial Instructions Exist]: Does LXA exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$1F 
	LDX #$F0
	.byte $AB, $30 ; LXA #$30
	; A = (A|MAGIC) & $30; X = A;
	; another one where we'll just check to see if these changed at all.
	CMP #$1F
	BEQ TEST_Fail5
	CPX #$F0
	BEQ TEST_Fail5
	; LXA exists!
	INC <currentSubTest
	
	;;; Test K [Unofficial Instructions Exist]: Does LAE exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	; This also destroys the stack pointer, so...
	TSX
	STX $501
	LDA #$33
	STA $500
	LDX #$82
	TXS
	; The stack pointer is now $83 for this test.
	.byte $BB ; LAE $500
	.word $0500 
	; A = StackPointer & Immediate
	; And then transfer A to X and StackPointer.
	; So let's fix the stack pointer first.
	STX <$FD
	LDX $501
	TXS	; Fix the stack pointer
	CMP #$02
	BNE TEST_Fail6
	LDX <$FD
	CPX #$02
	BNE TEST_Fail6
	; LAE exists!
	INC <currentSubTest
	
	;;; Test L [Unofficial Instructions Exist]: Does DCP exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$41
	.byte $CF	; DCP $0500
	.word $0500
	BNE TEST_Fail6	
	; DCP exists!
	INC <currentSubTest
	
	;;; Test M [Unofficial Instructions Exist]: Does AXS exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$F0
	LDX #$66
	.byte $CB, $40; AXS #$40
	; X = (A&X)-M
	CPX #$20
	BNE TEST_Fail6	
	; AXS exists!
	INC <currentSubTest
	
	;;; Test N [Unofficial Instructions Exist]: Does ISC exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$22
	.byte $EF	; ISC $0500
	.word $0500
	; Increment $0500, then subtract it from A
	CMP #$DF
	BNE TEST_Fail6	
	; LAE exists!
	INC <currentSubTest
	;; END OF TEST ;;
	LDA #1
	RTS
TEST_Fail6:	; This is in the middle of the test, since it saves bytes to branch here.
	JMP TEST_Fail
;;;;;;;;;;;;;;;;;

TEST_UnOp_RamFunc: ; this gets copy/pasted into RAM at address $0580
	NOP	; These can be replaced with a JSR instruction.
	NOP	; Certain operations have different behavior if a DMA occurs in the 2nd to last cycle.
	NOP	; So those instructions might put a JSR here to set things up and precisely time time a DMA. 
	TSX			; Some unofficial instructions modify the stack pointer
	STX <Copy_SP; make a copy of the stack pointer
	LDX <Test_UnOp_SP
	TXS	
	LDX <Copy_X ; restore X for the test.
	LDA <Test_UnOp_FlagsInit
	PHA
	LDA <Copy_A	
	PLP	; Get init flags ready for the test. The T flag isn't a concern.
TEST_UnOp_RamFuncTest: ; Ram Function TEST
	NOP	; Overwrite this with the test.
	NOP	; Overwrite this with the test.
	NOP	; Overwrite this with the test.
	PHA
	PHP	; push the flags from the test
	PLA ; Pull the status flags off into A
	AND #$CF ; mask away the B and T flag, which is set by PHP
	STA <Copy_Flags	; and store the flags here for later
	PLA
	STA <Copy_A  ; Store A
	STX <Copy_X	 ; Store X
	TSX
	STX <Copy_SP2; Store Stack Pointer
	STY <Copy_Y	 ; Store Y
	LDX <Copy_SP; Fix the stack pointer in case it was modified.
	TXS
	LDX <Copy_X ; restore X for the test results.
	RTS
TEST_UnOp_RamFuncEnd:
;;;;;;;;;;;;;;;;;;;;;
; It's a bit cursed to be creating constants here, but labels need to be defined before you can use them to create constants.
UnOpTest_Opcode = $0580+(TEST_UnOp_RamFuncTest-TEST_UnOp_RamFunc)
UnOpTest_Operand = UnOpTest_Opcode+1
UnOpTest_Operand2 = UnOpTest_Opcode+2
;;;;;;;	
TEST_UnOp_Setup:
	; The tests of the Unofficial Instructions will be using this function to set everything up.
	; Copy/Paste the test function into RAM.
	PHA
	LDX #0
TEST_UnOp_SetupLoop:
	LDA TEST_UnOp_RamFunc, X
	STA $580, X
	INX
	CPX #(TEST_UnOp_RamFuncEnd-TEST_UnOp_RamFunc)
	BNE TEST_UnOp_SetupLoop
	PLA
	STA UnOpTest_Opcode
	RTS
;;;;;;;
TEST_UnOp_SetupByAddressingMode:
	; Setting up RAM for the test!
	; The goal: around address $580, we have the code to run the test, but the operands are currently EA EA
	; This function will determine the addressing mode of the test based on the value of the opcode (The A Register)
	; Then a jump table is used to set up the operands of the test around $580.
	; For instance, if you want to test LDA $0500, it will jump to TEST_UnOp_SetupAddressingMode_Absolute
	; ... where the values $00 and $05 will be stored in the operands of the test.
	; Suppose the test is LDA $0500, X. The value stored will be ($0500-X) so the X offset would reach the correct byte. 
	; For zero page instructions, the second operand byte is intentionally left as a NOP.
	;
	; NOTE: These tests assume you have correct implementation of the various addressing modes.
	; In other words, the (indirect), Y tests will always use the exact same operands (always using Test_UnOp_IndirectPointerLo)
	; And the offset for (indirect, X)  test will always land on Test_UnOp_IndirectPointerLo
	
	STA <$FF
	STX <$FD
	; Determine the addressing mode of this instruction by examining the lower 6 bits.	
	; Assume A is the opcode
	STA <$02 ; 2 = opcode
	; get lower 5 bits.
	AND #$1F
	; store this in a temp location
	STA <$03 ; 3 = lower 5 bits of opcode.
	; check if we need to flip from an X offset to a Y offset;
	AND #$17
	CMP #$17
	BNE Test_UnOp_DontFlipXtoY
	LDA <$02 ; A = opcode
	AND #$C0 ; A = upper 2 bits of opcode
	CMP #$80 ; ; if only bit 7 is set, flip X to Y
	BNE Test_UnOp_DontFlipXtoY
	LDA <$03
	AND #$1E
	STA <$03	
Test_UnOp_DontFlipXtoY:
	LDA <$03
	ASL A
	TAX
	LDA Test_UnOp_SetupJumpTable,X
	STA <$0
	LDA Test_UnOp_SetupJumpTable+1,X
	STA <$1
	LDA <$FF
	LDX <$FD
	JMP [$0000]
	
Test_UnOp_SetupJumpTable:
	.word TEST_UnOp_SetupAddrMode_Immediate  ; 0 - Immediate
	.word TEST_Fail							 ; 1 - N/A
	.word TEST_UnOp_SetupAddrMode_Immediate  ; 2 - Immediate
	.word TEST_UnOp_SetupAddrMode_IndX  	 ; 3 - (Indirect, X)
	.word TEST_UnOp_SetupAddrMode_ZP 		 ; 4 - ZeroPage
	.word TEST_Fail							 ; 5 - N/A
	.word TEST_Fail							 ; 6 - N/A
	.word TEST_UnOp_SetupAddrMode_ZP 		 ; 7 - ZeroPage
	.word TEST_Fail							 ; 8 - N/A
	.word TEST_UnOp_SetupAddrMode_Immediate  ; 9 - Immediate
	.word TEST_Fail							 ; A - N/A
	.word TEST_UnOp_SetupAddrMode_Immediate  ; B - Immediate
	.word TEST_UnOp_SetupAddrMode_Abs  		 ; C - Absolute
	.word TEST_Fail							 ; D - N/A
	.word TEST_Fail							 ; E - N/A
	.word TEST_UnOp_SetupAddrMode_Abs  		 ; F - Absolute
	.word TEST_Fail							 ; 10- N/A
	.word TEST_Fail							 ; 11- N/A
	.word TEST_Fail							 ; 12- N/A (HLT is tested elsewhere)
	.word TEST_UnOp_SetupAddrMode_IndY  	 ; 13- (Indirect), Y
	.word TEST_UnOp_SetupAddrMode_ZPX		 ; 14- ZeroPage, X
	.word TEST_Fail							 ; 15- N/A
	.word TEST_UnOp_SetupAddrMode_ZPY		 ; 16- ZeroPage, Y !! Not always the case for the official instructions, but it's convenient for this jump table.
	.word TEST_UnOp_SetupAddrMode_ZPX		 ; 17- ZeroPage, X (or Y if bit 7 is set and bit 6 is not)
	.word TEST_Fail							 ; 18- N/A
	.word TEST_Fail							 ; 19- N/A
	.word TEST_UnOp_SetupAddrMode_Implied    ; 1A- Implied
	.word TEST_UnOp_SetupAddrMode_AbsY 		 ; 1B- Absolute, Y
	.word TEST_UnOp_SetupAddrMode_AbsX 		 ; 1C- Absolute, X
	.word TEST_Fail							 ; 1D- N/A
	.word TEST_UnOp_SetupAddrMode_AbsY 		 ; 1E- Absolute, Y !! Not always the case for the official instructions, but we don't care about that here.
	.word TEST_UnOp_SetupAddrMode_AbsX 		 ; 1F- Absolute, X (or Y if bit 7 is set and bit 6 is not)


TEST_UnOp_SetupAddrMode_Implied:
TEST_UnOp_SetupAddrMode_Immediate:
	LDA Test_UnOp_ValueAtAddressForTest
	STA UnOpTest_Operand
	RTS

TEST_UnOp_SetupAddrMode_IndX:
	STX <Copy_X
	LDA #Test_UnOp_IndirectPointerLo
	SEC
	SBC <Copy_X
	STA UnOpTest_Operand
	LDA <Test_UnOp_OperandTargetAddrHi
	STA <Test_UnOp_IndirectPointerHi
	LDA <Test_UnOp_OperandTargetAddrLo
	STA <Test_UnOp_IndirectPointerLo
	LDA <Test_UnOp_ValueAtAddressForTest
	LDY #0
	STA [Test_UnOp_ExpectedResultAddrLo],Y
	LDY <Copy_Y
	RTS

TEST_UnOp_SetupAddrMode_IndY:
	;;; Set up the test for (Indirect), Y addressed ;;;
	LDA #Test_UnOp_IndirectPointerLo
	STA UnOpTest_Operand	
	STY <Copy_Y
	LDA <Test_UnOp_OperandTargetAddrHi
	STA <Test_UnOp_IndirectPointerHi
	LDA <Test_UnOp_OperandTargetAddrLo
	SEC
	SBC <Copy_Y	
	STA Test_UnOp_IndirectPointerLo
	BCS TEST_UnOp_IndY_DontDecHigh
	DEC <Test_UnOp_IndirectPointerHi
TEST_UnOp_IndY_DontDecHigh	
	LDA <Test_UnOp_ValueAtAddressForTest
	LDY #0
	STA [Test_UnOp_ExpectedResultAddrLo],Y
	LDY <Copy_Y
	RTS

TEST_UnOp_SetupAddrMode_ZP:
	;;; Set up the test for Zero Page addressed ;;;
	LDA <Test_UnOp_OperandTargetAddrLo
	; Only ever test from $50 to $5F
	AND #$0F
	ORA #$50
	STA UnOpTest_Operand
	STA <Test_UnOp_ExpectedResultAddrLo; Modify the pointers
	STA <Test_UnOp_OperandTargetAddrLo ; Modify the pointers
	LDA #0
	STA <Test_UnOp_ExpectedResultAddrHi; Modify the pointers
	STA <Test_UnOp_OperandTargetAddrHi; Modify the pointers
	LDA <Test_UnOp_ValueAtAddressForTest; Load the initial value for the test.
	STY <Copy_Y
	LDY #0
	STA [Test_UnOp_OperandTargetAddrLo],Y
	STA [Test_UnOp_ExpectedResultAddrLo],Y
	LDY <Copy_Y
	RTS

TEST_UnOp_SetupAddrMode_ZPX:
	;;; Set up the test for Zero Page addressed ;;;
	STX <Copy_X
	LDA <Test_UnOp_OperandTargetAddrLo
	; Only ever test from $50 to $5F
	AND #$0F
	ORA #$50
	STA <Test_UnOp_ExpectedResultAddrLo; Modify the pointers
	SEC
	SBC <Copy_X	
	STA UnOpTest_Operand
	STA <Test_UnOp_OperandTargetAddrLo ; Modify the pointers
	LDA #0
	STA <Test_UnOp_ExpectedResultAddrHi; Modify the pointers
	STA <Test_UnOp_OperandTargetAddrHi; Modify the pointers
	LDA <Test_UnOp_ValueAtAddressForTest; Load the initial value for the test.
	STY <Copy_Y
	LDY #0
	STA [Test_UnOp_ExpectedResultAddrLo],Y
	LDY <Copy_Y
	RTS

TEST_UnOp_SetupAddrMode_ZPY:
	;;; Set up the test for Zero Page addressed ;;;
	STY <Copy_Y
	LDA <Test_UnOp_OperandTargetAddrLo
	; Only ever test from $50 to $5F
	AND #$0F
	ORA #$50
	STA <Test_UnOp_ExpectedResultAddrLo; Modify the pointers
	SEC
	SBC <Copy_Y	
	STA UnOpTest_Operand
	STA <Test_UnOp_OperandTargetAddrLo ; Modify the pointers
	LDA #0
	STA <Test_UnOp_ExpectedResultAddrHi; Modify the pointers
	STA <Test_UnOp_OperandTargetAddrHi; Modify the pointers
	LDA <Test_UnOp_ValueAtAddressForTest; Load the initial value for the test.
	LDY #0
	STA [Test_UnOp_ExpectedResultAddrLo],Y
	LDY <Copy_Y
	RTS
;;;;;;;
TEST_UnOp_SetupAddrMode_Abs:
	;;; Set up the test for Absolute addressed ;;;
	LDA <Test_UnOp_OperandTargetAddrLo
	STA UnOpTest_Operand
	LDA <Test_UnOp_OperandTargetAddrHi
	STA UnOpTest_Operand2
	LDA <Test_UnOp_ValueAtAddressForTest
	STY <Copy_Y
	LDY #0
	STA [Test_UnOp_OperandTargetAddrLo],Y
	STA [Test_UnOp_ExpectedResultAddrLo],Y
	LDY <Copy_Y
	RTS
;;;;;;;
TEST_UnOp_SetupAddrMode_AbsX:
;;; Set up the test for Absolute, X addressed ;;;
	STX <Copy_X
	LDA <Test_UnOp_OperandTargetAddrHi
	STA UnOpTest_Operand2
	LDA <Test_UnOp_OperandTargetAddrLo
	SEC
	SBC <Copy_X	
	STA UnOpTest_Operand
	BCS TEST_UnOp_AbsX_DontDecHigh
	DEC UnOpTest_Operand2
TEST_UnOp_AbsX_DontDecHigh	
	LDA <Test_UnOp_ValueAtAddressForTest
	STY <Copy_Y
	LDY #0
	STA [Test_UnOp_OperandTargetAddrLo],Y
	STA [Test_UnOp_ExpectedResultAddrLo],Y
	LDY <Copy_Y
	RTS
TEST_UnOp_SetupAddrMode_AbsY:
	STY <Copy_Y
	LDA <Test_UnOp_OperandTargetAddrHi
	STA UnOpTest_Operand2
	LDA <Test_UnOp_OperandTargetAddrLo
	SEC
	SBC <Copy_Y	
	STA UnOpTest_Operand
	BCS TEST_UnOp_AbsY_DontDecHigh
	DEC UnOpTest_Operand2
TEST_UnOp_AbsY_DontDecHigh	
	LDA <Test_UnOp_ValueAtAddressForTest
	LDY #0
	STA [Test_UnOp_OperandTargetAddrLo],Y
	STA [Test_UnOp_ExpectedResultAddrLo],Y
	LDY <Copy_Y
	RTS
;;;;;;;

TEST_PrepAXYForTest:
	LDX <Test_UnOp_X
	LDY <Test_UnOp_Y
	LDA <Test_UnOp_A
	RTS
;;;;;;;

TEST_UnOpRunTest:
	JSR TEST_PrepAXYForTest
	LDA <$FF ; the opcode
	JSR TEST_UnOp_SetupByAddressingMode ; Set up the operands around $580
	JSR TEST_PrepAXYForTest
	STA <Copy_A
	STX <Copy_X
	JSR $0580	; Run the test!
	RTS
;;;;;;;

Test_UnOpEvaluateResults:
	LDY #0
	LDA [Test_UnOp_ExpectedResultAddrLo],Y
	CMP <Test_UnOp_ValueAtAddressResult
	BNE FAIL_UnOpTest ; Error code 1: The result at the expected address was incorrect
	INC <currentSubTest
Test_UnOpEvaluateResults_StartA:
	LDA <Copy_A
	CMP <Test_UnOp_CMP
	BNE FAIL_UnOpTest ; Error code 2: The result of the A register was incorrect
	INC <currentSubTest
	LDX <Copy_X
	CPX <Test_UnOp_CPX
	BNE FAIL_UnOpTest ; Error code 3: The result of the X register was incorrect
	INC <currentSubTest
	LDY <Copy_Y
	CPY <Test_UnOp_CPY
	BNE FAIL_UnOpTest ; Error code 4: The result of the Y register was incorrect
	INC <currentSubTest
	LDA <Copy_Flags
	CMP <Test_UnOp_CM_Flags
	BNE FAIL_UnOpTest ; Error code 5: The result of the flags were incorrect
	RTS ; Pass!
FAIL_UnOpTest:
	; Uncomment this to print the value that failed, and the expected value. Really only works for error 1.
	;PHA
	;JSR WaitForVBlank
	;LDA #$23
	;STA $2006
	;LDA #$70
	;STA $2006
	;PLA
	;JSR PrintByte
	;LDA #$24
	;STA $2007
	;LDA <Test_UnOp_ValueAtAddressResult
	;JSR PrintByte

	PLA	; Pull of the Return Address
	PLA	;
	PLA
	PLA
	JMP TEST_Fail ; and fail the test.
	
Test_UnOpEvaluateResultsIncludingStackPointer:
	LDY #0
	LDA [Test_UnOp_ExpectedResultAddrLo],Y
	CMP <Test_UnOp_ValueAtAddressResult
	BNE FAIL_UnOpTest ; Error code 1: The result at the expected address was incorrect
	INC <currentSubTest
	LDA <Copy_A
	CMP <Test_UnOp_CMP
	BNE FAIL_UnOpTest ; Error code 2: The result of the A register was incorrect
	INC <currentSubTest
	LDX <Copy_X
	CPX <Test_UnOp_CPX
	BNE FAIL_UnOpTest ; Error code 3: The result of the X register was incorrect
	INC <currentSubTest
	LDY <Copy_Y
	CPY <Test_UnOp_CPY
	BNE FAIL_UnOpTest ; Error code 4: The result of the Y register was incorrect
	INC <currentSubTest
	LDA <Copy_Flags
	CMP <Test_UnOp_CM_Flags
	BNE FAIL_UnOpTest ; Error code 5: The result of the flags were incorrect
	INC <currentSubTest
	LDA <Copy_SP2
	CMP <Test_UnOp_CPS
	BNE FAIL_UnOpTest ; Error code 6: The result of the stack pointer was incorrect
	RTS ; Pass!

TEST_RunTest_AddrInitAXYF:
	;.word TargetAddress
	;.byte Initial, A, X, Y, Flags
	;.word ResultAddress
	;.byte result, r_A, r_X, r_Y, r_Flags
	STA <$FF
	JSR CopyReturnAddressToByte0
	LDY #0
	LDX #0
TEST_AddrInitAXYF_PreLoop:
	LDA [$0000],Y
	STA <Test_UnOp_OperandTargetAddrLo,X
	INY
	INX
	CPX #7 ; Set up $20 through $26
	BNE TEST_AddrInitAXYF_PreLoop
	LDX #0
TEST_AddrInitAXYF_PreLoop2:
	LDA [$0000],Y
	STA <Test_UnOp_ExpectedResultAddrLo,X
	INY
	INX
	CPX #7 ; Set up $28 through $2E
	BNE TEST_AddrInitAXYF_PreLoop2
	; With the varaibles all set up, let's prep the test:
	JSR FixRTS
	JSR TEST_UnOpRunTest
	; Evaluating the test.
	LDA #1
	STA <currentSubTest	
	JSR Test_UnOpEvaluateResults
	; If you made it this far, we passed this test!
	; (not necessarily the entire suite, but this specific test, at least)
	LDA UnOpTest_Opcode ; reset this value before the next test, assuming another one follows
	RTS
;;;;;;;

TEST_RunTest_AddrInitAXYFS:
	;.word TargetAddress
	;.byte Initial, A, X, Y, Flags, StackPointer
	;.word ResultAddress
	;.byte result, r_A, r_X, r_Y, r_Flags, r_StackPointer
	STA <$FF
	JSR CopyReturnAddressToByte0
	LDY #0
	LDX #0
TEST_AddrInitAXYFS_PreLoop:
	LDA [$0000],Y
	STA <Test_UnOp_OperandTargetAddrLo,X
	INY
	INX
	CPX #16 ; Set up $28 through $2F
	BNE TEST_AddrInitAXYFS_PreLoop
	; With the varaibles all set up, let's prep the test:
	JSR FixRTS
	JSR TEST_UnOpRunTest
	; Evaluating the test.
	LDA #1
	STA <currentSubTest	
	JSR Test_UnOpEvaluateResultsIncludingStackPointer
	; If you made it this far, we passed this test!
	; (not necessarily the entire suite, but this specific test, at least)
	LDA UnOpTest_Opcode ; reset this value before the next test, assuming another one follows
	RTS
;;;;;;;
	
TEST_RunTest_ImmOperandAXYF:
	STA <$FF
	JSR CopyReturnAddressToByte0
	LDY #0
	LDX #0
TEST_ImmOperandAXYF_PreLoop:
	LDA [$0000],Y
	STA <Test_UnOp_ValueAtAddressForTest,X
	INY
	INX
	CPX #5 ; Set up $22 through $26
	BNE TEST_ImmOperandAXYF_PreLoop
	LDX #0
TEST_ImmOperandAXYF_PreLoop2:
	LDA [$0000],Y
	STA <Test_UnOp_CMP,X
	INY
	INX
	CPX #4 ; Set up $22 through $26
	BNE TEST_ImmOperandAXYF_PreLoop2
	JSR FixRTS
	JSR TEST_UnOpRunTest
	LDA #2
	STA <currentSubTest	
	JSR Test_UnOpEvaluateResults_StartA
	; If you made it this far, we passed this test!
	; (not necessarily the entire suite, but this specific test, at least)
	LDA UnOpTest_Opcode ; reset this value before the next test, assuming another one follows
	RTS
;;;;;;;

;Test_UnOp_OperandTargetAddrLo = $20
;Test_UnOp_OperandTargetAddrHi = $21
;Test_UnOp_ValueAtAddressForTest = $22
;Test_UnOp_A = $23
;Test_UnOp_X = $24
;Test_UnOp_Y = $25
;Test_UnOp_FlagsInit = $26
;Test_UnOp_SP = $27
;Test_UnOp_ExpectedResultAddrLo = $28
;Test_UnOp_ExpectedResultAddrHi = $29
;Test_UnOp_ValueAtAddressResult = $2A
;Test_UnOp_CMP = $2B
;Test_UnOp_CPX = $2C
;Test_UnOp_CPY = $2D
;Test_UnOp_CM_Flags = $2E
;Test_UnOp_CPS = $2F

;Test_UnOp_IndirectPointerLo = $30
;Test_UnOp_IndirectPointerHi = $31




TEST_SLO_03:
	LDA #$03
	BNE TEST_SLO
TEST_SLO_07:
	LDA #$07
	BNE TEST_SLO
TEST_SLO_0F:
	LDA #$0F
	BNE TEST_SLO
TEST_SLO_13:
	LDA #$13
	BNE TEST_SLO
TEST_SLO_17:
	LDA #$17
	BNE TEST_SLO
TEST_SLO_1B:
	LDA #$1B
	BNE TEST_SLO
TEST_SLO_1F:
	LDA #$1F
TEST_SLO:
	JSR TEST_UnOp_Setup; Set the opcode
	
	; A lot of these unofficial instruction tests will tell you to "see TEST_SLO" for an explanation. Here it is!
	
	; The ASM code in this section might look a little confusing...
	; These JSR instructions lead to subroutines that modify the return address
	; so the .word and .byte parts don't get executed.
	; The format of these tests look like this:	
	;
	; JSR TEST_RunTest_AddrInitAXYF
	; iAddress
	; iValue 
	; iA,   iX,   iY,   iflags
	; rAddress
	; rValue 
	; rA,   rX,   rY,   rflags
	;
	; The address at "iAddress" will be assigned the value of "iValue". 
	; The A register will be assigned the value of iA, the X register will be assigned the value of iX, and so on.
	; Then the test runs, which is pretty much just running the instruction in question. In this case, it's some form of SLO.
	; Then, the value of rAddress is compared with rValue. (If it doesn't match, return error code 1)
	; Then, the value of the A register is compared with rA. (If it doesn't match, return error code 2)
	; Then, the value of the X register is compared with rX. (If it doesn't match, return error code 3)
	; Then, the value of the Y register is compared with rY. (If it doesn't match, return error code 4)
	; Then, the value of the status flags are compared with rflags. (If they don't match, return error code 5)
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $0500
	.byte $40
	.byte $01, $64, $45, (flag_i | flag_c | flag_z)
	.word $0500
	.byte $80
	.byte $81, $64, $45, (flag_i | flag_n)
	; SLO ;
	; Let's walk through this one for the sake of documentation.
	; $0500 = $40, A = $01
	; SLO will shift the value at $0500 to the left.
	; $40 << 1 = $80, so that's the new value at $0500
	; then, bitwise OR the A register with the result of that previous step.
	; $01 | $80 = $81.
	; So the result is, $0500 = $80, and A = $81.
	; The Negative, Carry, and Zero are the only flags modified, and they behave like ORA in this instance.
	; So in this case, the negative flag is set, carry is cleared, and zero is cleared.	
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $057F
	.byte $FF
	.byte $00, $21, $9E, (flag_i | flag_v)
	.word $057F
	.byte $FE
	.byte $FE, $21, $9E, (flag_i | flag_n | flag_c | flag_v)
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $05FF
	.byte $00
	.byte $00, $FF, $FF, (flag_i | flag_c)
	.word $05FF
	.byte $00
	.byte $00, $FF, $FF, (flag_i | flag_z)	
	; This one really doesn't have any wild edge cases or anything.
	; it's probably a safe bet to assume if your emulator made it this far, then it's good.	
	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;

TEST_RLA_23:
	LDA #$23
	BNE TEST_RLA
TEST_RLA_27:
	LDA #$27
	BNE TEST_RLA
TEST_RLA_2F:
	LDA #$2F
	BNE TEST_RLA
TEST_RLA_33:
	LDA #$33
	BNE TEST_RLA
TEST_RLA_37:
	LDA #$37
	BNE TEST_RLA
TEST_RLA_3B:
	LDA #$3B
	BNE TEST_RLA
TEST_RLA_3F:
	LDA #$3F
TEST_RLA:
	JSR TEST_UnOp_Setup; Set the opcode
	
	; see TEST_SLO for an explanation of the format here.
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $0500
	.byte $44
	.byte $C1, $64, $45, (flag_i | flag_c | flag_z)
	.word $0500
	.byte $89
	.byte $81, $64, $45, (flag_i | flag_n)
	; RLA ;
	; ROL, then AND ;

	JSR TEST_RunTest_AddrInitAXYF
	.word $0544
	.byte $0F
	.byte $33, $7B, $FE, (flag_i | flag_z | flag_v)
	.word $0544
	.byte $1E
	.byte $12, $7B, $FE, (flag_i | flag_v)

	JSR TEST_RunTest_AddrInitAXYF
	.word $05BF
	.byte $00
	.byte $A5, $E1, $00, (flag_i | flag_z | flag_n)
	.word $05BF
	.byte $00
	.byte $00, $E1, $00, (flag_i | flag_z)

	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;

TEST_SRE_43:
	LDA #$43
	BNE TEST_SRE
TEST_SRE_47:
	LDA #$47
	BNE TEST_SRE
TEST_SRE_4F:
	LDA #$4F
	BNE TEST_SRE
TEST_SRE_53:
	LDA #$53
	BNE TEST_SRE
TEST_SRE_57:
	LDA #$57
	BNE TEST_SRE
TEST_SRE_5B:
	LDA #$5B
	BNE TEST_SRE
TEST_SRE_5F:
	LDA #$5F
TEST_SRE:
	JSR TEST_UnOp_Setup; Set the opcode
	
	; see TEST_SLO for an explanation of the format here.
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $0500
	.byte $F0
	.byte $5A, $64, $45, (flag_i | flag_c | flag_z)
	.word $0500
	.byte $78
	.byte $22, $64, $45, (flag_i)
	; SRE ;
	; LSR, then EOR ;

	JSR TEST_RunTest_AddrInitAXYF
	.word $053A
	.byte $48
	.byte $24, $8C, $8D, (flag_i | flag_v)
	.word $053A
	.byte $24
	.byte $00, $8C, $8D, (flag_i | flag_v | flag_z)
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $05B1
	.byte $01
	.byte $00, $00, $00, (flag_i)
	.word $05B1
	.byte $00
	.byte $00, $00, $00, (flag_i | flag_c | flag_z)

	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;

TEST_RRA_63:
	LDA #$63
	BNE TEST_RRA
TEST_RRA_67:
	LDA #$67
	BNE TEST_RRA
TEST_RRA_6F:
	LDA #$6F
	BNE TEST_RRA
TEST_RRA_73:
	LDA #$73
	BNE TEST_RRA
TEST_RRA_77:
	LDA #$77
	BNE TEST_RRA
TEST_RRA_7B:
	LDA #$7B
	BNE TEST_RRA
TEST_RRA_7F:
	LDA #$7F
TEST_RRA:
	JSR TEST_UnOp_Setup; Set the opcode
	
	; see TEST_SLO for an explanation of the format here.
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $0500
	.byte $D0
	.byte $07, $64, $45, (flag_i | flag_c | flag_z)
	.word $0500
	.byte $E8
	.byte $EF, $64, $45, (flag_i | flag_n)
	; RRA ;
	; ROR, then ADC ;
	; Notably, the ROR behavior updates the carry flag before the ADC.
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $0566
	.byte $11
	.byte $F7, $12, $34, (flag_i | flag_z | flag_v)
	.word $0566
	.byte $08
	.byte $00, $12, $34, (flag_i | flag_z | flag_c)
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $05E1
	.byte $20
	.byte $90, $7B, $F2, (flag_i | flag_z | flag_c)
	.word $05E1
	.byte $90
	.byte $20, $7B, $F2, (flag_i | flag_v | flag_c)



	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;

TEST_SAX_83:
	LDA #$83
	BNE TEST_SAX
TEST_SAX_87:
	LDA #$87
	BNE TEST_SAX
TEST_SAX_8F:
	LDA #$8F
	BNE TEST_SAX
TEST_SAX_97:
	LDA #$97
TEST_SAX:
	JSR TEST_UnOp_Setup; Set the opcode
	
	; see TEST_SLO for an explanation of the format here.
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $0500
	.byte $5A
	.byte $F3, $3F, $45, (flag_i | flag_c | flag_z | flag_v)
	.word $0500
	.byte $33
	.byte $F3, $3F, $45, (flag_i | flag_c | flag_z | flag_v)
	; SAX ;
	; Store A & X;
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $05D2
	.byte $21
	.byte $5A, $A5, $45, (flag_i)
	.word $05D2
	.byte $00
	.byte $5A, $A5, $45, (flag_i)
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $05EC
	.byte $21
	.byte $90, $E0, $45, (flag_i | flag_c)
	.word $05EC
	.byte $80
	.byte $90, $E0, $45, (flag_i | flag_c)

	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;

TEST_LAX_A3:
	LDA #$A3
	BNE TEST_LAX
TEST_LAX_A7:
	LDA #$A7
	BNE TEST_LAX
TEST_LAX_AF:
	LDA #$AF
	BNE TEST_LAX
TEST_LAX_B3:
	LDA #$B3
	BNE TEST_LAX
TEST_LAX_B7:
	LDA #$B7
	BNE TEST_LAX
TEST_LAX_BF:
	LDA #$BF
TEST_LAX:
	JSR TEST_UnOp_Setup; Set the opcode
	
	; see TEST_SLO for an explanation of the format here.
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $0500
	.byte $00
	.byte $07, $64, $45, (flag_i | flag_c | flag_v)
	.word $0500
	.byte $00
	.byte $00, $00, $45, (flag_i | flag_c | flag_z | flag_v)
	; LAX ;
	; Load A and X ;

	JSR TEST_RunTest_AddrInitAXYF
	.word $05B3
	.byte $9F
	.byte $00, $00, $88, (flag_i | flag_z)
	.word $05B3
	.byte $9F
	.byte $9F, $9F, $88, (flag_i | flag_n)

	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;

TEST_DCP_C3:
	LDA #$C3
	BNE TEST_DCP
TEST_DCP_C7:
	LDA #$C7
	BNE TEST_DCP
TEST_DCP_CF:
	LDA #$CF
	BNE TEST_DCP
TEST_DCP_D3:
	LDA #$D3
	BNE TEST_DCP
TEST_DCP_D7:
	LDA #$D7
	BNE TEST_DCP
TEST_DCP_DB:
	LDA #$DB
	BNE TEST_DCP
TEST_DCP_DF:
	LDA #$DF
TEST_DCP:
	JSR TEST_UnOp_Setup; Set the opcode
	
	; see TEST_SLO for an explanation of the format here.
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $0500
	.byte $F5
	.byte $F4, $64, $45, (flag_i)
	.word $0500
	.byte $F4
	.byte $F4, $64, $45, (flag_i | flag_c | flag_z)
	; DCP ;
	; DEC, then  CMP ;
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $05F0
	.byte $00
	.byte $F2, $00, $11, (flag_i)
	.word $05F0
	.byte $FF
	.byte $F2, $00, $11, (flag_i | flag_n)
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $0522
	.byte $80
	.byte $80, $8F, $E3, (flag_i)
	.word $0522
	.byte $7F
	.byte $80, $8F, $E3, (flag_i | flag_c)
	

	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;

TEST_ISC_E3:
	LDA #$E3
	BNE TEST_ISC
TEST_ISC_E7:
	LDA #$E7
	BNE TEST_ISC
TEST_ISC_EF:
	LDA #$EF
	BNE TEST_ISC
TEST_ISC_F3:
	LDA #$F3
	BNE TEST_ISC
TEST_ISC_F7:
	LDA #$F7
	BNE TEST_ISC
TEST_ISC_FB:
	LDA #$FB
	BNE TEST_ISC
TEST_ISC_FF:
	LDA #$FF
TEST_ISC:
	JSR TEST_UnOp_Setup; Set the opcode
	
	; see TEST_SLO for an explanation of the format here.
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $0500
	.byte $3F
	.byte $75, $64, $45, (flag_i)
	.word $0500
	.byte $40
	.byte $34, $64, $45, (flag_i | flag_c)
	; ISC ;
	; INC, then SBC ;
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $05BB
	.byte $96
	.byte $98, $15, $8F, (flag_i)
	.word $05BB
	.byte $97
	.byte $00, $15, $8F, (flag_i | flag_z | flag_c)
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $05BB
	.byte $7F
	.byte $05, $15, $8F, (flag_i)
	.word $05BB
	.byte $80
	.byte $84, $15, $8F, (flag_i | flag_v | flag_n)

	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;


TEST_SHA_93:
	LDA #PostDMACyclesUntilTestInstruction+5
	STA <Test_UnOp_CycleDelayPostDMA	
	; Determine if this instruction is using behavior 1 or 2. (or not implemented)
	LDA #$F0
	STA <Test_UnOp_IndirectPointerLo
	LDA #$1D
	STA <Test_UnOp_IndirectPointerHi
	LDA #$02
	LDX #$FF
	LDY #$10
	.byte $93, Test_UnOp_IndirectPointerLo
	LDA $1E00
	CMP #$02
	BEQ TEST_SHA_Behavior2_93_JMP
	LDA $200
	CMP #$02
	BEQ TEST_SHA_Behavior1_93_JMP
	LDA #$02
	RTS
	
TEST_SHA_Behavior2_93_JMP:
	JMP TEST_SHA_Behavior2_93
TEST_SHA_Behavior1_93_JMP:
	JMP TEST_SHA_Behavior1_93
	
TEST_SHA_9F:
	LDA #PostDMACyclesUntilTestInstruction+4
	STA <Test_UnOp_CycleDelayPostDMA
	; Determine if this instruction is using behavior 1 or 2. (or not implemented)
	LDA #$02
	LDX #$FF
	LDY #$10
	.byte $9F, $F0, $1D
	LDA $1E00
	CMP #$02
	BEQ TEST_SHA_Behavior2_9F_JMP
	LDA $200
	CMP #$02
	BEQ TEST_SHA_Behavior1_9F_JMP
	LDA #$02
	RTS
	
TEST_SHA_Behavior2_9F_JMP:
	JMP TEST_SHA_Behavior2_9F
TEST_SHA_Behavior1_9F_JMP:
	JMP TEST_SHA_Behavior1_9F
	
	; So there are 2 different behaviors you can expect here.
	; H is the high byte of the address bus before indexing, +1
	; 1. Write: A & X & H
	; 2. Write: A & (X | Magic) & H :: *Magic CAN CHANGE!
	;		Magic has been seen to be 00, F5, F9, FA, and FF.
	
	; When the Y register is used as an offset and causes the high byte to change, the high byte becomes "unstable".
	; The behavior here IS correlated to the other set of behaviors.
	; 1. Hi = Hi & A & X
	; 2. Hi = Hi & X
TEST_SHA_Behavior1_93
	LDA #$93
	BNE TEST_SHA_Behavior1
TEST_SHA_Behavior1_9F:
	LDA #$9F
TEST_SHA_Behavior1:
	JSR TEST_UnOp_Setup; Set the opcode
	; This test follows the documented behavior of these instructions. Most emulators probably go here.
	; Special thanks to 8BitLord64 for help researching this.
	; Write: A & X & H
	; Hi = Hi & A & X
	JSR TEST_RunTest_AddrInitAXYF
	.word $0525
	.byte $FF
	.byte $FF, $FF, $00, (flag_i)
	.word $0525
	.byte $06
	.byte $FF, $FF, $00, (flag_i)
	; SHA ;
	; This test needs to be VERY carefully made
	; the high byte of the target address can be modified "unexpectedly"
	; let's run some tests where the high byte doesn't change.
	; Store (A & X & H), where "H" is the high byte of the target address + 1.
	JSR TEST_RunTest_AddrInitAXYF
	.word $1D00	; If someone is testing for this instruction, they would surely have RAM mirroring implemented.
	.byte $FF
	.byte $3F, $F5, $00, (flag_i | flag_c | flag_z | flag_v)
	.word $0500
	.byte $14
	.byte $3F, $F5, $00, (flag_i | flag_c | flag_z | flag_v)
	
	; Now to make the high byte go unstable.
	JSR TEST_RunTest_AddrInitAXYF
	.word $1F10 ; $1E90 will be the operand.
	.byte $FF
	.byte $0D, $15, $80, (flag_i | flag_c | flag_z | flag_v)
	.word $0510
	.byte $05
	.byte $0D, $15, $80, (flag_i | flag_c | flag_z | flag_v)
	; Hi = ($1E+1) & A & X;
	; 	 = $05
	; $510 = A & X & H
	;	   = $0D & $15 & $1F
	;	   = 5
	INC <$55 ; make this non-zero for the test.	
	JSR TEST_RunTest_AddrInitAXYF
	.word $0555 ; $0402 will be the operand.
	.byte $FF
	.byte $F0, $09, $FF, (flag_i)
	.word $0055
	.byte $00
	.byte $F0, $09, $FF, (flag_i)
	; Hi = ($1E+1) & A & X;
	; 	 = $00
	; $510 = A & X & H
	;	   = $0D & $15 & $1F
	;	   = 5
	
	; And now to test if the high byte instability occurs if the cycle before the write had a DMA.
	; LDA #$20
	; STA $0580
	; LDA #Low(DMASync_50MinusACyclesRemaining)
	; STA $0581
	; LDA #High(DMASync_50MinusACyclesRemaining)
	; STA $0582		
	
	; TODO: this.
	
;; END OF TEST ;;
	JSR WaitForVBlank
	LDA #0
	STA <dontSetPointer
	JSR PrintTextCentered
	.word $22B0
	.byte " SHA Behavior 1", $FF
	JSR ResetScroll
	LDA #1
	RTS
	
TEST_SHA_Behavior2_93
	LDA #$93
	BNE TEST_SHA_Behavior2
TEST_SHA_Behavior2_9F:
	LDA #$9F
TEST_SHA_Behavior2:
	JSR TEST_UnOp_Setup; Set the opcode
	; This test follows the behavior of many consoles I tested, though differs from the documentation.
	; Special thanks to GTAce, Fiskbit, and Lain for helping research this.
	; Write: A & (X | Magic) & H
	; Hi = Hi & X
	
	; We can not make any assumptions on what "magic" is. Therefore, X needs to always be FF.
	JSR TEST_RunTest_AddrInitAXYF
	.word $0525
	.byte $FF
	.byte $FF, $FF, $00, (flag_i)
	.word $0525
	.byte $06
	.byte $FF, $FF, $00, (flag_i)
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $1D00
	.byte $FF
	.byte $03, $FF, $00, (flag_i)
	.word $0500
	.byte $02
	.byte $03, $FF, $00, (flag_i)
	
	; Now to make the high byte go unstable.
	JSR TEST_RunTest_AddrInitAXYF
	.word $1F10 ; $1E90 will be the operand.
	.byte $FF
	.byte $0A, $FF, $80, (flag_i | flag_c | flag_z | flag_v)
	.word $0710
	.byte $0A
	.byte $0A, $FF, $80, (flag_i | flag_c | flag_z | flag_v)
	; the high byte will only be ANDed with X (FF in this case)
	
	; And now to test if the high byte instability occurs if the cycle before the write had a DMA.
	; LDA #$20
	; STA $0580
	; LDA #Low(DMASync_50MinusACyclesRemaining)
	; STA $0581
	; LDA #High(DMASync_50MinusACyclesRemaining)
	; STA $0582	
	
	JSR WaitForVBlank
	LDA #0
	STA <dontSetPointer
	JSR PrintTextCentered
	.word $22B0
	.byte " SHA Behavior 2", $FF
	JSR PrintTextCentered
	.word $2330
	.byte "SHA magic = $", $FF
	LDA #$FF
	LDX #$00
	LDY #$60
	.byte $9F, $F0, $FE ; SHA $FEF0, Y
	LDA <$50
	JSR PrintByte
	
	JSR ResetScroll
	LDA #1
	RTS


TEST_SHS_9B:
	LDA #PostDMACyclesUntilTestInstruction+4
	STA <Test_UnOp_CycleDelayPostDMA
	; Determine if this instruction is using behavior 1 or 2. (or not implemented)
	TSX
	STX <Copy_SP
	LDA #$02
	LDX #$FF
	LDY #$10
	.byte $9F, $F0, $1D
	LDX <Copy_SP
	TXS
	LDA $1E00
	CMP #$02
	BEQ TEST_SHS_Behavior2_9B_JMP
	LDA $200
	CMP #$02
	BEQ TEST_SHS_Behavior1_9B
	LDA #$02
	RTS
	
TEST_SHS_Behavior2_9B_JMP:
	JMP TEST_SHS_Behavior2_9B
	
TEST_SHS_Behavior1_9B:
	LDA #$9B
	JSR TEST_UnOp_Setup; Set the opcode
	; This test follows the documented behavior of these instructions. Most emulators probably go here.
	; Special thanks to 8BitLord64 for help researching this.
	; Write: A & X & H
	; Hi = Hi & A & X
	JSR TEST_RunTest_AddrInitAXYFS
	.word $0525
	.byte $FF
	.byte $FF, $FF, $00, (flag_i), $FF
	.word $0525
	.byte $06
	.byte $FF, $FF, $00, (flag_i), $FF
	; SHS ;
	; This test needs to be VERY carefully made
	; This test also modifies the stack pointer.
	; the high byte of the target address can be modified "unexpectedly"
	; let's run some tests where the high byte doesn't change.
	; Store (A & X & H), where "H" is the high byte of the target address + 1.
	JSR TEST_RunTest_AddrInitAXYFS
	.word $1D00	; If someone is testing for this instruction, they would surely have RAM mirroring implemented.
	.byte $FF
	.byte $3F, $F5, $00, (flag_i | flag_c | flag_z | flag_v), $35
	.word $0500
	.byte $14
	.byte $3F, $F5, $00, (flag_i | flag_c | flag_z | flag_v), $35
	
	; Now to make the high byte go unstable.
	JSR TEST_RunTest_AddrInitAXYFS
	.word $1F10 ; $1E90 will be the operand.
	.byte $FF
	.byte $0D, $15, $80, (flag_i | flag_c | flag_z | flag_v), $05
	.word $0510
	.byte $05
	.byte $0D, $15, $80, (flag_i | flag_c | flag_z | flag_v), $05
	; Hi = ($1E+1) & A & X;
	; 	 = $05
	; $510 = A & X & H
	;	   = $0D & $15 & $1F
	;	   = 5
	INC <$55 ; make this non-zero for the test.	
	JSR TEST_RunTest_AddrInitAXYFS
	.word $0555 ; $0402 will be the operand.
	.byte $FF
	.byte $F0, $09, $FF, (flag_i), $00
	.word $0055
	.byte $00
	.byte $F0, $09, $FF, (flag_i), $00
	; Hi = ($1E+1) & A & X;
	; 	 = $00
	; $510 = A & X & H
	;	   = $0D & $15 & $1F
	;	   = 5
	
;; END OF TEST ;;
	JSR WaitForVBlank
	LDA #0
	STA <dontSetPointer
	JSR PrintTextCentered
	.word $22D0
	.byte " SHS Behavior 1", $FF
	JSR ResetScroll
	LDA #1
	RTS
TEST_SHS_Behavior2_9B:
	LDA #$9B
	JSR TEST_UnOp_Setup; Set the opcode
	JSR TEST_RunTest_AddrInitAXYFS
	.word $0525
	.byte $FF
	.byte $FF, $FF, $00, (flag_i), $FF
	.word $0525
	.byte $06
	.byte $FF, $FF, $00, (flag_i), $FF
	
	JSR TEST_RunTest_AddrInitAXYFS
	.word $1D00
	.byte $FF
	.byte $03, $FF, $00, (flag_i), $03
	.word $0500
	.byte $02
	.byte $03, $FF, $00, (flag_i), $03
	
	JSR TEST_RunTest_AddrInitAXYFS
	.word $1F10 ; $1E90 will be the operand.
	.byte $FF
	.byte $0A, $FF, $80, (flag_i | flag_c | flag_z | flag_v), $0A
	.word $0710
	.byte $0A
	.byte $0A, $FF, $80, (flag_i | flag_c | flag_z | flag_v), $0A

;; END OF TEST ;;
	JSR WaitForVBlank
	LDA #0
	STA <dontSetPointer
	JSR PrintTextCentered
	.word $22D0
	.byte " SHS Behavior 2", $FF
	JSR PrintTextCentered
	.word $2350
	.byte "SHS magic = $", $FF
	TSX
	STX <Copy_SP
	LDA #$FF
	LDX #$00
	LDY #$60
	.byte $9B, $F0, $FE ; SHS $FEF0, Y
	LDX <Copy_SP
	TXS
	LDA <$50
	JSR PrintByte
	JSR ResetScroll
	LDA #1
	RTS

	


TEST_SHY_9C:
	LDA #PostDMACyclesUntilTestInstruction+4
	STA <Test_UnOp_CycleDelayPostDMA
	LDA #$9C
	JSR TEST_UnOp_Setup; Set the opcode
	JSR TEST_RunTest_AddrInitAXYF
	.word $15BB
	.byte $7F
	.byte $11, $00, $FF, (flag_i)
	.word $15BB
	.byte $16
	.byte $11, $00, $FF, (flag_i)
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $1D00
	.byte $7F
	.byte $33, $00, $0F, (flag_i)
	.word $1D00
	.byte $0E
	.byte $33, $00, $0F, (flag_i)

	; Goes unstable.
	JSR TEST_RunTest_AddrInitAXYF
	.word $1F10
	.byte $7F
	.byte $77, $80, $05, (flag_i)
	.word $510
	.byte $05
	.byte $77, $80, $05, (flag_i)

	; And now to test if the high byte instability occurs if the cycle before the write had a DMA.
	LDA #$20
	STA $0580
	LDA #Low(DMASync_50MinusACyclesRemaining)
	STA $0581
	LDA #High(DMASync_50MinusACyclesRemaining)
	STA $0582	
	
	;JSR TEST_RunTest_AddrInitAXYF
	;.word $0550
	;.byte $7F
	;.byte $00, $5A, $00, (flag_i)
	;.word $0550
	;.byte $5A
	;.byte $00, $5A, $00, (flag_i)

	; I honestly cannot tell if this is still writing somewhere, but it sure isn't where I thought it would be.

	;; END OF TEST ;;
	LDA #1
	RTS

TEST_SHX_9E:
	LDA #PostDMACyclesUntilTestInstruction+4
	STA <Test_UnOp_CycleDelayPostDMA
	LDA #$9E
	JSR TEST_UnOp_Setup; Set the opcode
	JSR TEST_RunTest_AddrInitAXYF
	.word $15BB
	.byte $7F
	.byte $11, $FF, $00, (flag_i)
	.word $15BB
	.byte $16
	.byte $11, $FF, $00, (flag_i)
	
	JSR TEST_RunTest_AddrInitAXYF
	.word $1D00
	.byte $7F
	.byte $33, $0F, $00, (flag_i)
	.word $1D00
	.byte $0E
	.byte $33, $0F, $00, (flag_i)

	; Goes unstable.
	JSR TEST_RunTest_AddrInitAXYF
	.word $1F10
	.byte $7F
	.byte $77, $05, $80, (flag_i)
	.word $510
	.byte $05
	.byte $77, $05, $80, (flag_i)

	; And now to test if the high byte instability occurs if the cycle before the write had a DMA.
	LDA #$20
	STA $0580
	LDA #Low(DMASync_50MinusACyclesRemaining)
	STA $0581
	LDA #High(DMASync_50MinusACyclesRemaining)
	STA $0582	
	
	;JSR TEST_RunTest_AddrInitAXYF
	;.word $0550
	;.byte $7F
	;.byte $00, $5A, $00, (flag_i)
	;.word $0550
	;.byte $5A
	;.byte $00, $5A, $00, (flag_i)

	; I honestly cannot tell if this is still writing somewhere, but it sure isn't where I thought it would be.

	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;

TEST_LAE_BB:
	LDA #$BB
	JSR TEST_UnOp_Setup; Set the opcode
	JSR TEST_RunTest_AddrInitAXYFS
	.word $500
	.byte $5A
	.byte $11, $FF, $00, (flag_i | flag_v), $CA
	.word $500
	.byte $5A
	.byte $4A, $4A, $00, (flag_i | flag_v), $4A

	JSR TEST_RunTest_AddrInitAXYFS
	.word $5C3
	.byte $C3
	.byte $7C, $99, $52, (flag_i), $9A
	.word $5C3
	.byte $C3
	.byte $82, $82, $52, (flag_i | flag_n), $82
	
	JSR TEST_RunTest_AddrInitAXYFS
	.word $5C3
	.byte $04
	.byte $AB, $CD, $EF, (flag_i | flag_c | flag_n), $90
	.word $5C3
	.byte $04
	.byte $00, $00, $EF, (flag_i | flag_c | flag_z), $00 ;
	; NOTE: Yes, the stack pointer will be set to 00;
	;       Yes, the test will then PHA and PHP.
	;       No, this will not corrupt the bottom of the stack, for the stack pointer is initialized to $EF during the reset routine I wrote.
	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;










TEST_ANC_0B:
	LDA #$0B
	BNE TEST_ANC
TEST_ANC_2B:
	LDA #$2B
TEST_ANC:
	; see TEST_SLO for an explanation of how these tests work.
	; Except this one is slightly different, so let me explain.
	; TEST_RunTest_ImmOperandAXYF is similar to TEST_RunTest_AddrInitAXYF,
	; but instead of iAddress, iValue, iA, iX, iY, iFlags, rAddress, rValue, rA, rX, rY, rFlags
	; this function uses operand, iA, iX, iY, iFlags, rA, rX, rY, rFlags.
	; Error code 2 means A didn't match the expected result.
	; Error code 3 means X didn't match the expected result.
	; Error code 4 means Y didn't match the expected result.
	; Error code 5 means the flags didn't match the expected result.
	JSR TEST_UnOp_Setup ; Set the opcode
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $F0
	.byte $5A, $64, $45, (flag_i | flag_z | flag_c)
	.byte $50, $64, $45, (flag_i)
	; ANC ;
	; Bitwise AND with Accumulator then Set Carry if Negative
	; $5A & $F0 = 50	
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $F5
	.byte $81, $00, $01, (flag_i | flag_v)
	.byte $81, $00, $01, (flag_i | flag_c | flag_n | flag_v)
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $5A
	.byte $A5, $FF, $5A, (flag_i | flag_c)
	.byte $00, $FF, $5A, (flag_i | flag_z)	
	
	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;	
	
TEST_ASR_4B:
	LDA #$4B
	JSR TEST_UnOp_Setup ; Set the opcode
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $F0
	.byte $81, $64, $45, (flag_i | flag_z | flag_c)
	.byte $40, $64, $45, (flag_i)
	; ASR ;
	; Bitwise AND with Accumulator then Logical Shift Right Accumulator
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $52
	.byte $43, $00, $01, (flag_i | flag_c | flag_v)
	.byte $21, $00, $01, (flag_i | flag_v)
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $41
	.byte $BF, $55, $AA, (flag_i | flag_z | flag_c)
	.byte $00, $55, $AA, (flag_i | flag_z | flag_c)	
	
	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;

TEST_ARR_6B:
	LDA #$6B
	JSR TEST_UnOp_Setup ; Set the opcode
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $F2
	.byte $EE, $64, $45, (flag_i | flag_z | flag_v)
	.byte $71, $64, $45, (flag_i | flag_c)
	; ARR ;
	; Bitwise AND with A then Rotate A and check bits
	; Negative flag = bit 7
	; Carry flag = bit 6
	; Overflow flag = bit 5
	; Zero flag = result is zero
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $01
	.byte $59, $64, $45, (flag_i | flag_z)
	.byte $00, $64, $45, (flag_i | flag_z)
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $4F
	.byte $F3, $64, $45, (flag_i | flag_z | flag_c)
	.byte $A1, $64, $45, (flag_i | flag_v | flag_n)
	
	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;

TEST_ANE_8B:
	LDA #$8B
	JSR TEST_UnOp_Setup ; Set the opcode
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $00
	.byte $5A, $3B, $45, (flag_i | flag_z | flag_c)
	.byte $00, $3B, $45, (flag_i | flag_z | flag_c)
	; ANE ;
	; A = (((A | Magic) & X) & Immediate)
	; The "Magic" value is not consistent, and so this test cannot rely on any specific value.
	; It is possible to test and see what this value is, but it could be different between tests.
	; Because of this, the tests used here need to specifically verify behavior only in cases where the magic value does not alter the outcome.
	; Basically, unless Immediate is $00, or A is $FF, the outcome is not guaranteed.
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $CF
	.byte $FF, $9F, $99, (flag_i | flag_z | flag_v)
	.byte $8F, $9F, $99, (flag_i | flag_n | flag_v)
	
	; That's pretty much all we can test with this instruction, so we're good to go!
	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;

TEST_LXA_AB:
	LDA #$AB
	JSR TEST_UnOp_Setup ; Set the opcode
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $00
	.byte $5A, $3B, $45, (flag_i | flag_z | flag_c)
	.byte $00, $00, $45, (flag_i | flag_z | flag_c)
	; LXA ;
	; A = ((A | Magic) & Immediate), X = A
	; The "Magic" value is not consistent, and so this test cannot rely on any specific value.
	; It is possible to test and see what this value is, but it could be different between tests.
	; Because of this, the tests used here need to specifically verify behavior only in cases where the magic value does not alter the outcome.
	; Basically, unless Immediate is $00, or A is $FF, the outcome is not guaranteed.
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $A5
	.byte $FF, $8F, $99, (flag_i | flag_z | flag_v)
	.byte $A5, $A5, $99, (flag_i | flag_n | flag_v)
	
	; That's pretty much all we can test with this instruction, so we're good to go!
	;; END OF TEST ;;
	LDA #1
	RTS
	
	
TEST_AXS_CB:
	LDA #$CB
	JSR TEST_UnOp_Setup ; Set the opcode
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $10
	.byte $F0, $B0, $45, (flag_i | flag_z | flag_c)
	.byte $F0, $A0, $45, (flag_i | flag_c | flag_n)
	; AXS ;
	; X = (A&X) - Immediate
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $00
	.byte $5A, $CC, $FF, (flag_i | flag_z | flag_c)
	.byte $5A, $48, $FF, (flag_i | flag_c)
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $E5
	.byte $00, $66, $45, (flag_i | flag_z | flag_c | flag_v)
	.byte $00, $1B, $45, (flag_i | flag_v)
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $45
	.byte $C5, $5F, $00, (flag_i | flag_n)
	.byte $C5, $00, $00, (flag_i | flag_z | flag_c)
	
	;; END OF TEST ;;
	LDA #1
	RTS

TEST_SBC_EB:
	LDA #$EB
	JSR TEST_UnOp_Setup ; Set the opcode
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $10
	.byte $F0, $22, $75, (flag_i | flag_z | flag_c | flag_v)
	.byte $E0, $22, $75, (flag_i | flag_c | flag_n)
	; SBC ;
	; It's the same as the official SBC Immediate instruction.
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $EE
	.byte $52, $93, $B2, (flag_i)
	.byte $63, $93, $B2, (flag_i)
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $80
	.byte $05, $C0, $1F, (flag_i | flag_z | flag_c | flag_v | flag_n)
	.byte $85, $C0, $1F, (flag_i| flag_v | flag_n)
	
	JSR TEST_RunTest_ImmOperandAXYF
	.byte $43
	.byte $44, $C0, $1F, (flag_i)
	.byte $00, $C0, $1F, (flag_i| flag_z | flag_c)
	
	;; END OF TEST ;;
	LDA #1
	RTS

TEST_MAGIC:
	; The ANE and LXA instructions have "magic values".
	; The value is typically $EE or $FF.
	; This test just prints what the value is for both instructions.	
	LDA #0
	STA <dontSetPointer
	JSR PrintTextCentered
	.word $2330
	.byte "ANE magic = $", $FF
	LDA #0
	LDX #$FF
	.byte $8B, $FF ; ANE #$FF
	JSR PrintByte
	
	JSR PrintTextCentered
	.word $2350
	.byte "LXA magic = $", $FF
	LDA #0
	.byte $AB, $FF ; LXA #$FF
	JSR PrintByte
	
;; END OF TEST ;;
	JSR ResetScroll
	LDA #1
	RTS

TEST_DMA_Plus_2007R:
	; Here's the set up:
	; VRAM will read 0 1 2 3 4
	; The LDA $2007 instruction has 4 read cycles.
	; [Opcode] [Operand1] [Operand2] [Read $2007]
	; if the DMA occurs between [Operand2] and [Read $2007], the ppu 'v' register will be incremented twice due to the DMA's dummy cycles.
	JSR WaitForVBlank
	JSR DisableRendering ; let's disable rendering for this one.
	LDX #$24
	STX $2006
	LDX #0
	STX $2006
	STX $2007 ; write 0 to VRAM $2800
	INX
	STX $2007 ; write 1 to VRAM $2801
	INX
	STX $2007 ; write 2 to VRAM $2802
	INX
	STX $2007 ; write 3 to VRAM $2803
	INX
	STX $2007 ; write 4 to VRAM $2804
	LDX #$24
	STX $2006
	LDX #$01
	STX $2006 ; and set 'v' back to $2800
	LDA $2007 ; read $2007 and prep the buffer.
	
	JSR DMASync_50CyclesRemaining	; sync DMA
	; We have 50 CPU cycles until the DMA occurs.
	JSR Clockslide_47
	LDA $2007 ; <------- [Opcode] [Operand1] [Operand2] [*DMA*] [Read]
	NOP 
	NOP	
	
	;;; Test 1 [DMA + $2007 Read]: verify PPU buffer behavior ;;;
	CMP #$00
	BEQ TEST_Fail7 ; if the value of A is $00, then your PPU buffer is probably not implemented correctly.
	INC <currentSubTest
	
	;;; Test 2 [DMA + $2007 Read]: Check DMA timing ;;;
	CMP #$01
	BEQ TEST_Fail7 ; if the value of A is $01, then the timing of the DMA is off.
	INC <currentSubTest
	
	;;; Test 3 [DMA + $2007 Read]: Check the DMA dummy reads occured the correct number of times ;;;	
	CMP #$03
	BMI TEST_Fail7
	INC <currentSubTest
	;; END OF TEST ;;
	
	JSR ResetScrollAndWaitForVBlank
	JSR EnableRendering	
	LDA #1
	RTS

TEST_Fail7:
	JSR ResetScrollAndWaitForVBlank
TEST_Fail8:
	JSR EnableRendering	
	JMP TEST_Fail

Test_FFFF_Plus_X_Wraparound:
	;;; Test 1 [$FFFF + X Wraparound]: LDA $FFFF + X (X=1) wraps around to $0000 ;;;
	LDA #$5A
	STA <$00
	LDX #$01
	LDA $FFFF,X
	CMP #$5A
	BNE TEST_Fail8
	INC <currentSubTest
	;;; Test 2 [$FFFF + X Wraparound]: LDA $FFFF + Y (Y=1) wraps around to $0000 ;;;
	LDA #$A5
	STA <$00
	LDY #$01
	LDA $FFFF,Y
	CMP #$A5
	BNE TEST_Fail8
	INC <currentSubTest
	;;; Test 3 [$FFFF + X Wraparound]: Branching from $FFF4 to $0050 ;;;
	; Depending on poor implementation, this very-well might crash an emulator.
	LDA #$F0
	STA <$50
	LDA #$A7
	STA <$51
	JSR TEST_FFFF_Branch_Wraparound
	INC <currentSubTest
	;;; Test 4 [$FFFF + X Wraparound]: Executing from $FFFF to $0000 ;;;
	LDA #$00
	STA <$00
	LDA #$60
	STA <$01
	JSR $FFFF ; .word $0600 = ASL <$00; $00 = 60, RTS
	
	;; END OF TEST ;;
	LDA #1
	RTS
;;;;;;;
	
	.bank 3
	.org $F000

EnableRendering:
	PHA
	LDA <PPUMASK_COPY
	ORA #$18
	STA <PPUMASK_COPY
	STA $2001
	PLA
	RTS
;;;;;;;

DisableRendering:
	PHA
	LDA <PPUMASK_COPY
	AND #$E7
	STA <PPUMASK_COPY
	STA $2001
	PLA
	RTS
;;;;;;;

EnableNMI:
	PHA
	LDA <PPUCTRL_COPY
	ORA #$80
	STA <PPUCTRL_COPY
	STA $2000
	PLA
	RTS
;;;;;;;

DisableNMI:
	PHA
	LDA <PPUCTRL_COPY
	AND #$7F
	STA <PPUCTRL_COPY
	STA $2000
	PLA
	RTS
;;;;;;;

ResetScroll:
	LDA #$20
	STA $2006
	LDA #$00
	STA $2006
	STA $2005
	STA $2005
	RTS
;;;;;;;

ClearNametable:
	PHA
	LDA #$20
	STA $2006
	LDA #$00
	STA $2006
	LDA #$24
	LDX #$08
	LDY #$00
NTLoop1:
	STA $2007
	DEY
	BNE NTLoop1
	DEX
	BNE NTLoop1
	; Now set up the attributes properly
	LDA #$23
	STA $2006
	LDA #$C0
	STA $2006
	LDA #$00
	LDX #$40
NTLoop2:
	STA $2007
	DEX
	BNE NTLoop2
	; And the other attributes
	LDA #$27
	STA $2006
	LDA #$C0
	STA $2006
	LDA #$00
	LDX #$40
NTLoop3:
	STA $2007
	DEX
	BNE NTLoop3
	PLA
	RTS
;;;;;;;

ClearRAMExceptPage3:
	; page 3 is where I'm keeping the uninitialized RAM values, so don't clear that.
	; also don't clear the stack, ha.
	LDA #0
	LDX #0
ClearRamLoop:
	STA <$00,X
	STA $200,X
	STA $400,X
	STA $500,X
	STA $600,X
	STA $700,X
	INX
	BNE ClearRamLoop	
	RTS
;;;;;;;

ClearPage5: ; Page 5 is reserved for RAM used by tests. It's a good idea to clear this before any tests.
	LDA #0
	LDX #0
ClearPage5Loop:
	STA $500,X
	STA $600,X ; it also clears page 6.
	INX
	BNE ClearPage5Loop
	RTS
;;;;;;;

PrintText:
	STA <Copy_A
	STY <Copy_Y
	STX <Copy_X
	LDA <dontSetPointer
	BNE PT_dontSetPointer
	JSR CopyReturnAddressToByte0
	LDY #1
	LDA $2002
	LDA [$0000],Y ; Read from the pointer
	STA <$03
	DEY
	LDA [$0000],Y
	STA <$04
	LDA #02
	JSR AddAToByte0
PT_dontSetPointer:
	LDA <$03
	STA $2006
	LDA <$04
	STA $2006
PTloop:
	LDA [$0000],Y
	CMP #$FF
	BEQ PTpostLoop
	TAX
	LDA AsciiToCHR, X ; convert from ascii to my 0123456789ABCDEFGHI... format
	STA $2007
	INY
	BNE PTloop ; Branch always to the loop
PTpostLoop:	
	INY
	LDA <dontSetPointer
	BNE PTskipFixRTS
	JSR FixRTS
	LDY <Copy_Y
PTskipFixRTS:
	LDX <Copy_X
	LDA <Copy_A
	RTS
;;;;;;;

PrintTextCentered:
	STA <Copy_A
	STY <Copy_Y
	STX <Copy_X
	LDA <dontSetPointer
	BNE PTC_dontSetPointer
	JSR CopyReturnAddressToByte0
	LDY #1
	LDA $2002
	LDA [$0000],Y ; Read from the pointer
	STA <$03
	DEY
	LDA [$0000],Y
	STA <$04
	LDA #02
	JSR AddAToByte0
	; Get length of the string.
PTC_dontSetPointer:
	LDY #0
PTCGetLength:
	INY
	LDA [$0000],Y
	CMP #$FF
	BNE PTCGetLength	
	LDA <$04 ; take pointer low byte
	AND #$E0  ; remove low 5 bits
	ORA #$10  ; add bit 5
	STA <$04
	TYA
	LSR A ; divide length by 2
	EOR #$FF ; make negative
	CLC
	ADC #01
	CLC
	ADC <$04 ; Add the low byte
	STA <$04
	LDA <$03
	STA $2006
	LDA <$04
	STA $2006	
	LDY #0
PTCloop:
	LDA [$0000],Y
	CMP #$FF
	BEQ PTCpostLoop
	TAX
	LDA AsciiToCHR, X ; convert from ascii to my 0123456789ABCDEFGHI... format
	STA $2007
	INY
	BNE PTCloop ; Branch always to the loop
PTCpostLoop:	
	INY
	LDA <dontSetPointer
	BNE PTCskipFixRTS
	JSR FixRTS
	LDY <Copy_Y
PTCskipFixRTS:
	LDX <Copy_X
	LDA <Copy_A
	RTS
;;;;;;;


Print32Bytes:
	; print the 32 bytes found at the target address.
	STA <Copy_A
	STY <Copy_Y
	STX <Copy_X
	JSR CopyReturnAddressToByte0
	LDA $2002
	LDY #$01
	LDA [$0000],Y ; update PPUADDR
	STA $2006
	STA <$02
	DEY
	LDA [$0000],Y
	STA $2006
	STA <$03
	LDA #02
	JSR AddAToByte0	
	LDA [$0000],Y ; copy new pointer to $04 and $05
	STA <$04
	INY
	LDA [$0000],Y ; copy new pointer to $04 and $05
	STA <$05	
	LDY #0	
	LDX #0
P32Loop:
	LDA [$0004],Y	
	PHA ; get left nybble
	AND #$F0
	LSR A
	LSR A
	LSR A
	LSR A
	STA $2007	
	PLA ; get right nybble
	AND #$0F
	STA $2007
	LDA $2007 ; add a space
	INX
	CPX #08
	BNE P32SkipADDR
	LDX #0
	LDA <$03
	CLC
	ADC #$20
	STA <$03
	BCC P32SkipADDRHi
	INC <$02
P32SkipADDRHi:
	LDA <$02
	STA $2006
	LDA <$03
	STA $2006
P32SkipADDR:
	INY
	CPY #32
	BNE P32Loop
	; post loop
	LDY #02
	JSR FixRTS
	LDX <Copy_X
	LDY <Copy_Y
	LDA <Copy_A
	RTS
;;;;;;;

Read32NametableBytes:
	LDA #$20
	STA $2006
	LDA #$00
	STA $2006
	LDA $2007	
	LDX #0
ReadNametableLoop:	
	LDA $2007
	STA PowerOnVRAM, X
	INX
	CPX #$20
	BNE ReadNametableLoop
	RTS
;;;;;;;

ReadPaletteRAM:
	LDA #$3F
	STA $2006
	LDA #$00
	STA $2006	
	LDX #0
ReadPalLoop:	
	LDA $2007
	STA PowerOnPalette, X
	INX
	CPX #$20
	BNE ReadPalLoop
	RTS
;;;;;;;

DefaultPalette:
	.byte $2D,$30,$30,$30,$0F,$21,$21,$21,$0F,$26,$26,$26,$0F,$2A,$2A,$2A
	.byte $2D,$30,$30,$30,$0F,$30,$30,$30,$0F,$30,$30,$30,$0F,$30,$30,$30	
SetUpDefaultPalette:
	LDA #$3F
	STA $2006
	LDA #$00
	STA $2006
	LDY #0
SetUpPaletteLoop:
	LDA DefaultPalette,Y
	STA $2007
	INY
	CPY #32
	BNE SetUpPaletteLoop
	RTS
;;;;;;;
	
CopyReturnAddressToByte0:
	PLA
	STA <$02
	PLA
	STA <$03
	PLA
	STA <$00
	PLA
	STA <$01
	INC <$00 ; INC the low byte
	BNE CPYRTS0
	INC <$01 ; If needed, INC the high byte
CPYRTS0:	
	LDA <$03
	PHA
	LDA <$02
	PHA
	RTS
;;;;;;;
AddAToByte0:
	CLC
	ADC <$00
	STA <$00
	BCC ADDRTS0
	INC <$01 ; If needed, INC the high byte
ADDRTS0:
	RTS
;;;;;;;
FixRTS:	; Correct the return address so any stack modifications for other functions won't cause issues
	PLA ; pull off the current return address	
	STA <$02
	PLA
	STA <$03 
	DEY ; the RTS address needs to be -1 of the following instruction.
	TYA
	JSR AddAToByte0
	LDA <$01 ; add byte0 to the return stack
	PHA
	LDA <$00
	PHA
	LDA <$03 ; add back the return address from this function
	PHA
	LDA <$02
	PHA
	RTS
;;;;;;;

LoadSuiteMenu:
	; assume the beginning of the suite is currently stored at suitePointer
	; print the name of the suite.
	; set up the PPU address to $2050
	LDA #$20
	STA <$03
	LDA #$70
	STA <$04
	LDA #01
	STA <dontSetPointer
	;suitepointer is already set up, so...
	LDA <suitePointer
	STA <$00
	LDA <suitePointer+1
	STA <$01
	JSR PrintTextCentered
	; set up the PPU address to $2096
	LDA #$20
	STA <$03
	LDA #$A8
	STA <$04
	LDX #0
LSM_Loop:
	; add Y to suitePointer
	TYA
	CLC
	ADC <suitePointer
	STA <suitePointer
	BCC LSM_SkipInc
	INC <suitePointer+1
LSM_SkipInc:
	LDA <$04
	CLC
	ADC #$40
	STA <$04
	BCC LSM_SkipInc2
	INC <$03
LSM_SkipInc2:
	LDA <suitePointer
	STA <$00
	LDA <suitePointer+1
	STA <$01
	LDY #0
	LDA [$0000],Y
	CMP #$FF
	BNE LSM_DontExitLoop
	TXA
	LSR A
	STA menuHeight
	RTS
LSM_DontExitLoop:
	JSR PrintText
	; then store the test results pointer
	LDA [$0000],Y
	STA <suitePointerList, X
	INY
	INX
	LDA [$0000],Y
	STA <suitePointerList, X
	INY
	DEX
	LDA [$0000],Y
	STA <suiteExecPointerList, X
	INY
	INX
	LDA [$0000],Y
	STA <suiteExecPointerList, X
	INY
	DEX
	
	; let's also update the attribute tables before prepping X for the next loop.
	TXA
	PHA
	LSR A
	TAX
	JSR DrawTEST	

	JSR UpdateTESTAttributes
	PLA
	TAX
	INX
	INX	
	JMP LSM_Loop
;;;;;;;;;;;;;;;;
	
DrawTEST:
	STY <$FE
	STX <$FD
	; relocate the PPU v register
	JSR GetVRegisterByXIndexForMenu
	; read the test results
	TXA
	ASL A
	TAX	
	LDA [suitePointerList,X]
	STA <currentSubTest
	; 0 = "TEST"
	; 1 = "PASS"
	; 2 = "FAIL"
	; 3 = "...." for a test in progress.
	;;;;;;;;;;;;
	AND #$3 ; bits 0 and 1 hold the results. Bits 3+ hold error codes for printing what failed.
	TAX
	TAY
	LDA TestPassFailBlend,Y
	TAY
	LDA AsciiToCHR,Y
	STA $2007
	TXA
	TAY
	LDA TestPassFailBlend+4,Y
	TAY
	LDA AsciiToCHR,Y
	STA $2007
	TXA
	TAY
	LDA TestPassFailBlend+8,Y
	TAY
	LDA AsciiToCHR,Y
	STA $2007
	TXA
	TAY
	LDA TestPassFailBlend+12,Y
	TAY
	LDA AsciiToCHR,Y
	STA $2007
	TXA
	AND #$3
	CMP #2 ; check if we failed.
	BNE DrawTestEnd
	; we failed, so print an error code.
	LDA #$24
	STA $2007
	lda <currentSubTest
	AND #$FC
	LSR A
	LSR A
	STA $2007	
DrawTestEnd:
	LDY <$FE
	LDX <$FD
	RTS
;;;;;;;

UpdateTESTAttributes:
	STY <$FE
	STX <$FD
	; convert the x value to the attribute address, and determine top/bottom.
	LDA #$23
	STA <byte8
	STA $2006
	INX
	TXA
	AND #$FE
	; n = ((x+1)/2)
	ASL A
	ASL A
	; n *= 8
	CLC
	ADC #$C8
	; $23c8 + n
	STA <byte9
	STA $2006	
	LDA $2007
	LDA $2007
	STA <suiteAttributeCopy
	LDA $2007
	STA <suiteAttributeCopy+1
	LDA <byte8
	STA $2006
	LDA <byte9
	STA $2006
	; is this top or bottom?
	DEX
	TXA
	AND #01
	TAY
	LDA AttributeNybblesInverse, Y
	AND <suiteAttributeCopy
	STA <suiteAttributeCopy
	LDA AttributeNybblesInverse, Y
	AND <suiteAttributeCopy+1
	STA <suiteAttributeCopy+1
	
	; read the test results
	LDX <$FD
	TXA
	ASL A
	TAX	
	LDA [suitePointerList,X]
	AND #3
	TAX

	; the palette will be the results.
	LDA AttributePaletteNybbles,X
	AND AttributeNybbles, Y
	ORA <suiteAttributeCopy
	STA <suiteAttributeCopy
	LDA AttributePaletteNybbles,X
	AND AttributeNybbles, Y
	ORA <suiteAttributeCopy+1
	STA <suiteAttributeCopy+1
	
	LDA <suiteAttributeCopy
	STA $2007
	LDA <suiteAttributeCopy+1
	STA $2007
	
	LDY <$FE
	LDX <$FD
	RTS
;;;;;;;

HighlightTest:
	JSR GetVRegisterByXIndexForMenu
	LDA $2007
	LDY #$00
CopyTestTextLoop:
	LDA $2007
	STA TESTHighlightTextCopy,Y
	INY
	CPY #$04
	BNE CopyTestTextLoop
	JSR GetVRegisterByXIndexForMenu
	LDY #$00
HighlightLoop:
	LDA TESTHighlightTextCopy,Y
	EOR #$80
	STA $2007
	INY
	CPY #$04
	BNE HighlightLoop
	RTS
;;;;;;;

GetVRegisterByXIndexForMenu:
	; $20E1 + $40*X
	; High = ((X+3) >> 2) + 20
	TYA
	PHA
	TXA
	CLC
	ADC #$03
	LSR A
	LSR A
	CLC
	ADC #$20
	STA $2006
	; Low = VRegisterByXIndexLowLUT[X&3]
	TXA
	AND #$03
	TAY
	LDA VRegisterByXIndexLowLUT,Y
	STA $2006
	PLA
	TAY
	RTS
;;;;;;;

ReadPPUADDRFromWord: ; Takes the two bytes after the JSR instruction and stores them in $2006. Then reads $2007 twice.
	STY <$FE
	JSR CopyReturnAddressToByte0
	LDA $2002
	LDY #0
	LDA [$0000],Y
	STA $2006
	INY
	LDA [$0000],Y
	STA $2006
	INY
	JSR FixRTS
	LDY <$FE
	LDA $2007
	LDA $2007
	RTS
;;;;;;;
SetPPUADDRFromWord:	; pretty much the same as ReadPPUADDRFromWord, but it doesn't run LDA $2007 twice at the end.
	STA <$FF
	STY <$FE
	JSR CopyReturnAddressToByte0
	LDA $2002
	LDY #0
	LDA [$0000],Y
	STA $2006
	INY
	LDA [$0000],Y
	STA $2006
	INY
	JSR FixRTS
	LDY <$FE
	LDA <$FF
	RTS
;;;;;;;
WriteToPPUADDRWithByte:	; Sets up v then writes n to it, where n is the third bytes after the JSR
	STA <$FF
	STY <$FE
	JSR CopyReturnAddressToByte0
	LDA $2002
	LDY #0
WriteToPPUADDRWithByteLoop:
	LDA [$0000],Y
	CMP #$FF
	BEQ WriteToPPUADDRWithByteExit
	STA $2006
	INY
	LDA [$0000],Y
	STA $2006
	INY
	LDA [$0000],Y
	STA $2007
	INY
	JMP WriteToPPUADDRWithByteLoop
WriteToPPUADDRWithByteExit:
	INY
	JSR FixRTS
	LDY <$FE
	LDA <$FF
	RTS
;;;;;;;

DoubleLDA2007:	; There are a few tests that need to read the contents of a PPU address.
	LDA $2007	; and instead of actually writing out LDA $2007 twice (6 bytes)
	LDA $2007	; you can just jump here instead. (3 bytes)
	RTS
;;;;;;;


VRegisterByXIndexLowLUT:
	.byte $E1, $21, $61, $A1

AttributeNybbles:
	.byte $F0, $0F
AttributeNybblesInverse:
	.byte $0F, $F0
	
AttributePaletteNybbles:
	.byte $00, $55, $AA, $FF
	
TestPassFailBlend:
	.byte "TPF."
	.byte "EAA."
	.byte "SSI."
	.byte "TSL."

AsciiToCHR:
	.byte $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24
	.byte $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24, $24
	.byte $24, $26, $24, $24, $35, $24, $24, $24, $24, $24, $32, $30, $29, $31, $25, $33
	.byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $28, $24, $24, $34, $24, $27
	.byte $24, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13, $14, $15, $16, $17, $18
	.byte $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $24, $24, $24, $24, $24
	.byte $24, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13, $14, $15, $16, $17, $18
	.byte $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23;, $24, $24, $24, $24, $24


NMI_Routine:
	; This is the NMI routine for the main menu.
	JSR ReadController1
	JSR MaskDpadConflicts
	LDA <menuCursorYPos
	LDX <menuCursorYPos
	BMI NMI_Menu_CursorAtTop
	; cursor is not at the top.
	LDA <controller_New
	AND #$80 ; A
	BEQ NMI_Menu_NotBeginningTest
	; Run test!
	JSR RunTest	
	JMP ExitNMI
NMI_Menu_NotBeginningTest:
	LDA <controller_New
	AND #$04 ; Down
	BEQ NMI_Menu_NotMovingDown
	INC <menuCursorYPos
	LDA <menuCursorYPos
	CMP <menuHeight
	BNE NMI_Menu_DownNotAtLength
	DEC <menuCursorYPos ; menuCursorYPos = menuHeight-1;
NMI_Menu_DownNotAtLength:
	JSR HighlightTest
	LDX <menuCursorYPos
	JSR HighlightTest
	JMP ExitNMI
	;;;
NMI_Menu_NotMovingDown:
	LDA <controller_New
	AND #$08 ; Up
	BEQ NMI_Menu_NotMovingUp
	; move cursor up
	DEC <menuCursorYPos
	JSR HighlightTest
	LDX <menuCursorYPos
	BMI NMI_Menu_DontPokeTextAgain
	JSR HighlightTest
NMI_Menu_DontPokeTextAgain:
NMI_Menu_NotMovingUp:
	JMP ExitNMI
	;;;
NMI_Menu_CursorAtTop
	; cursor is at the top. if we press left or right, swamp in a different set
	LDA <controller_New
	AND #$01 ; right
	BEQ NMI_Menu_Top_NotPressingRight
	; pressing Right
	LDA <menuTabXPos
	CMP #((EndTableTable - TableTable)/2)-1
	BNE NMI_Menu_SwapSuiteRight_SkipReset
	LDA #$FF
	STA <menuTabXPos
NMI_Menu_SwapSuiteRight_SkipReset:	
	INC <menuTabXPos	
	JSR DrawNewSuiteTable
	JMP ExitNMI
	
NMI_Menu_Top_NotPressingRight:
	LDA <controller_New
	AND #$02 ; left
	BEQ NMI_Menu_Top_NotPressingLeft
	; pressing Left
	LDA <menuTabXPos
	BNE NMI_Menu_SwapSuiteLeft_SkipReset
	LDA #((EndTableTable - TableTable)/2)
	STA <menuTabXPos
NMI_Menu_SwapSuiteLeft_SkipReset:
	DEC <menuTabXPos
	JSR DrawNewSuiteTable
	JMP ExitNMI	
	
NMI_Menu_Top_NotPressingLeft:
	; pressing down moves the cursor to 0.
	LDA <controller_New
	AND #$04 ; down
	BEQ NMI_Menu_Top_NotPressingDown
	LDA #0
	STA <menuCursorYPos
	LDX #0
	JSR HighlightTest
NMI_Menu_Top_NotPressingDown:

ExitNMI:
	JSR ResetScroll
	RTI
;;;;;;;

DrawNewSuiteTable:
	JSR DisableNMI
	JSR DisableRendering
	JSR ClearNametable
	LDA <menuTabXPos
	ASL A
	TAX	
	LDA TableTable,X
	STA <suitePointer
	LDA TableTable+1,X
	STA <suitePointer+1
	JSR LoadSuiteMenu
	; wait for vblank.
	JSR WaitForVBlank	
	JSR EnableRendering
	JSR EnableNMI
	RTS
;;;;;;;
	
WaitForVBlank:
	LDA $2002
WaitForVblLoop:
	LDA $2002
	BPL WaitForVblLoop
	RTS
;;;;;;;

ResetScrollAndWaitForVBlank:
	JSR ResetScroll
	JSR WaitForVBlank
	RTS
;;;;;;;

ReadController1:
	LDA <controller
	STA <controller_New
	LDA #$01
	STA $4016
	LSR A
	STA $4016
	LDX #$08
RC_Loop:
	LDA $4016
	LSR A
	ROL <controller
	DEX
	BNE RC_Loop
	LDA <controller
	EOR <controller_New
	AND <controller
	STA <controller_New
	RTS
;;;;;;;

MaskDpadConflicts:
	LDA <controller
	AND <$F0
	STA <byteF
	LDA <controller
	AND #$0F
	TAY
	LDA DpadConflictMask,Y
	ORA <byteF
	STA <controller
	LDA <controller_New
	AND <$F0
	STA <byteF
	LDA <controller_New
	AND #$0F
	TAY
	LDA DpadConflictMask,Y
	ORA <byteF
	STA <controller_New
	RTS
;;;;;;;
	
DpadConflictMask:
	.byte $00, $01, $02, $00, $04, $05, $06, $00, $08, $09, $0A, $08, $00, $01, $02, $00

RunTest:
	; This function sets things up, then jumps to "JSRFromRAM" where a JSR to the test occurs.
	; Basically, this makes a bunch of preparations for tests, like clearing page 5 of RAM, halting the NMI, etc.
	STY <$FE	                  ; Store the Y register
	STX <$FD	                  ; Store the X register
	JSR DisableNMI	              ; We don't want the NMI occuring during the tests. (and if we do, overwrite the NMI function in RAM before enabling it)
	LDX <menuCursorYPos           ; X = which test from the current suite we're running
	TXA
	ASL A				          ; Double X, since we're reading a 2-byte word from a list of 2-byte words.
	TAX
	LDA <suiteExecPointerList,X	  ; read the low byte of where the test occurs.
	STA <JSRFromRAM+1			  ; and store it in RAM next to a JSR opcode.
	LDA <suiteExecPointerList+1,X ; read the high byte of where the test occurs.
	STA <JSRFromRAM+2			  ; and store it in RAM next to the low byte.
								  ; `JSR [Test], RTS` now exists in RAM at "JSRFromRAM"
	LDA <suitePointerList,X	      ; read the low byte of where to store the test results.
	STA <TestResultPointer        ; and store it in RAM
	LDA <suitePointerList+1,X     ; read the high byte of where to store the test results.
	STA <TestResultPointer+1      ; and store it in RAM next to the low byte.
	LDY #0
	LDA #3	                      ; a value of 3 here is used to draw "...." as the test status.
	STA [TestResultPointer],Y     ; mark this test as "in progress"
	LDX <menuCursorYPos           ; load X for the upcoming subroutines.
	JSR DrawTEST	              ; replace the word "TEST" with "...."
	JSR HighlightTest             ; and highlight it, since the cursor is still here.
	LDA #1
	STA <currentSubTest           ; set this to 1 before running any tests.
	LDA #$80
	STA <Test_UnOp_SP			  ; Some tests might modify the stack pointer. The test will use a value of $80 just to be sure it's not overwriting other stack data.
	JSR ResetScroll		          ; Reset the scroll before the test, since we just modified 'v' inside the previous subroutines.
	JSR ClearPage5		          ; clear RAM from $500 to $5FF. That RAM is dedicated for running tests, so we want it clean.
	JSR WaitForVBlank             ; this makes debugging your own emulator with this ROM much easier, since the test should always begin at the start of a frame.
	JSR JSRFromRAM                ; !! This is where the test occurs. "JSRFromRAM" is at address $001A. !!
	                              ; The A Register holds the results of the test.
	LDY #0
	STA [TestResultPointer],Y     ; store the test results in RAM.
	JSR ResetScrollAndWaitForVBlank; and wait for VBlank before updating the "...." text with the results.
	LDX <menuCursorYPos		      ; load X for the upcoming subroutines.
	JSR DrawTEST			      ; draw "PASS" or "FAIL x"
	JSR UpdateTESTAttributes      ; and update the colors for that text.
	JSR HighlightTest		      ; and also highlight it, as the cursor is still there.
	JSR SetUpNMIRoutineForMainMenu; Recreate the NMI routine JMP, since some tests need their own NMI routine.
	JSR EnableNMI			      ; With the test over, re-enable the NMI
	JSR EnableRendering		      ; and enable rendering too. This should still occur during Vblank.
	LDY <$FE				      ; Restore the Y register
	LDX <$FD				      ; Restore the X register
	RTS
;;;;;;;

ClearNametableFrom2240:
	LDA #$22
	STA $2006
	LDA #$40
	STA $2006
	LDX #$10
	LDA #$24
ClearNTFrom2240Loop:
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	STA $2007
	DEX
	BNE ClearNTFrom2240Loop
	RTS
;;;;;;;

PrintByte:
	PHA
	AND #$F0
	LSR A
	LSR A
	LSR A
	LSR A
	STA $2007
	PLA
	AND #$0F
	STA $2007
	RTS
;;;;;;;

SetUpNMIRoutineForMainMenu:
	LDA #$4C
	STA $700
	LDA #Low(NMI_Routine)
	STA $701
	LDA #High(NMI_Routine)
	STA $702
	RTS
;;;;;;;

DMASync:
	LDA #$80
	STA $4010 ; Enable DMC IRQ
	LDA #$00
	STA $4013 ; Length = 0 (+1)
	STA $4015 ; Disable DMC
	LDA #$10
	STA $4015 ; Enable DMC (clear the DMC buffer)
	NOP
	STA $4015 ; Enable DMC a second time.
sync_dmc_loop:
	BIT $4015
	BNE sync_dmc_loop ; wait for DMC Interrupt
	NOP
	NOP
	NOP
	LDA #$E2
	BNE sync_dmc_first ; branch always to sync_dmc_first
sync_dmc_wait:
	LDA #$E3
sync_dmc_first:
	NOP
	NOP
	NOP
	NOP
	SEC
	SBC #$01
	BNE sync_dmc_first
	LDA #$10
	STA $4015
	NOP
	BIT $4015
	BNE sync_dmc_wait
	; The DMA is now synced!
	LDA <Copy_A ; waste 3 cycles
	LDA <Copy_A ; waste 3 cycles
	NOP
	LDX #$A3
	LDA #$03
sync_dmc_loop2:
	DEX
	BNE sync_dmc_loop2
	SEC
	SBC #$01
	BNE sync_dmc_loop2
	LDA <Copy_A ; waste 3 cycles
	LDA <Copy_A ; waste 3 cycles
	LDA #$10
	STA $4015 ; start DMC
	LDA #$10
	STA $4015 ; start DMC again
	RTS ; You got 3404 cycles until the DMA, and this RTS takes 6 of them.
	; in other words, 3398 cycles after this RTS, a DMA will occur.


DMASync_50CyclesRemaining:
	JSR DMASync
	; the DMA is in 3398 cycles;
	JSR Clockslide_3000
	JSR Clockslide_100
	JSR Clockslide_100
	JSR Clockslide_100
	LDA #16 ;+2
	JSR Clockslide36_Plus_A
	RTS ; 50 cycles after this RTS, a DMA will occur.
	
DMASync_50MinusACyclesRemaining:
	JSR DMASync
	; the DMA is in 3398 cycles;
	JSR Clockslide_3000
	JSR Clockslide_100
	JSR Clockslide_100
	JSR Clockslide_50
	JSR Clockslide_49
	JSR Clockslide_16 ; there is no clockSlide 13, so...
	LDA <Test_UnOp_CycleDelayPostDMA ; +3
	JSR Clockslide36_Plus_A
	RTS ; 50-A cycles after this RTS, a DMA will occur.

	.org $FF00
Clockslide:
	; JSR takes 6 cycles.
	; The following bytes are labeled with the total cycles until the RTS instruction ends.
	; Clockslide has a minimum of 12 cycles.
	; EXAMPLE: Let's count CPU cycles!
	; LDA #00            ; +2 cycles
	; STA $0100          ; +4 cycles
	; JSR Clockslide_45  ; +45 cycles
	; LDA $2002			 ; +3 cycles
	
Clockslide_50:
	.byte $C9
Clockslide_49:
	.byte $C9
Clockslide_48:
	.byte $C9
Clockslide_47:
	.byte $C9
Clockslide_46:
	.byte $C9
Clockslide_45:
	.byte $C9
Clockslide_44:
	.byte $C9
Clockslide_43:
	.byte $C9
Clockslide_42:
	.byte $C9
Clockslide_41:
	.byte $C9
Clockslide_40:
	.byte $C9
Clockslide_39:
	.byte $C9
Clockslide_38:
	.byte $C9
Clockslide_37:
	.byte $C9
Clockslide_36:
	.byte $C9
Clockslide_35:
	.byte $C9
Clockslide_34:
	.byte $C9
Clockslide_33:
	.byte $C9
Clockslide_32:
	.byte $C9
Clockslide_31:
	.byte $C9
Clockslide_30:
	.byte $C9
Clockslide_29:
	.byte $C9
Clockslide_28:
	.byte $C9
Clockslide_27:
	.byte $C9
Clockslide_26:
	.byte $C9
Clockslide_25:
	.byte $C9
Clockslide_24:
	.byte $C9
Clockslide_23:
	.byte $C9
Clockslide_22:
	.byte $C9
Clockslide_21:
	.byte $C9
Clockslide_20:
	.byte $C9
Clockslide_19:
	.byte $C9
Clockslide_18:
	.byte $C9
Clockslide_17:
	.byte $C9
Clockslide_16:
	.byte $C9
Clockslide_15:
	.byte $C5
Clockslide_14:
	.byte $EA
Clockslide_12:
	.byte $60
;;;;;;;;;;;;;
	; Even larger clockslides!
Clockslide_100:       ;=6
	JSR Clockslide_38 ;=44
	JSR Clockslide_50 ;=94
	RTS			      ;=100
;;;;;;;
Clockslide_500:        ;=6
	JSR Clockslide_38  ;=44
	JSR Clockslide_50  ;=94
	JSR Clockslide_100 ;=194
	JSR Clockslide_100 ;=294
	JSR Clockslide_100 ;=394
	JSR Clockslide_100 ;=494
	RTS			       ;=500
;;;;;;;
Clockslide_3000:       ;=6
	JSR Clockslide_38  ;=44
	JSR Clockslide_50  ;=94
	JSR Clockslide_100 ;=194
	JSR Clockslide_100 ;=294
	JSR Clockslide_100 ;=394
	JSR Clockslide_100 ;=494
	JSR Clockslide_500 ;=0994
	JSR Clockslide_500 ;=1494
	JSR Clockslide_500 ;=1994
	JSR Clockslide_500 ;=2494
	JSR Clockslide_500 ;=2994
	RTS			       ;=3000
;;;;;;;
;A frame has about 29780 cycles, so let's make a few around that number.
Clockslide_29750:		;=6
	JSR Clockslide_38 	;=44
	JSR Clockslide_100	;=144
	JSR Clockslide_100	;=244
	JSR Clockslide_500	;=744
	JSR Clockslide_500	;=1244
	JSR Clockslide_500	;=1744
	JSR Clockslide_500	;=2244
	JSR Clockslide_500	;=2744
	JSR Clockslide_3000	;=5744
	JSR Clockslide_3000	;=8744
	JSR Clockslide_3000	;=11744
	JSR Clockslide_3000	;=14744
	JSR Clockslide_3000	;=17744
	JSR Clockslide_3000	;=20744
	JSR Clockslide_3000	;=23744
	JSR Clockslide_3000	;=26744
	JSR Clockslide_3000	;=29744
	RTS					;=29750
;;;;;;;
Clockslide_29780:		;=6
	JSR Clockslide_18	;=24
	JSR Clockslide_29750;=29774
	RTS					;=29780
;;;;;;;
Clockslide36_Plus_A:;+6
	STA <$00	; +3
	LDX #$FF	; +2
	STX <$01	; +3
	LDA #37		; +2
	SEC			; +2
	SBC <$00	; +3
	STA <$00	; +3
	JMP [$0000]	; 5 + A + 6
;;;;;;;;;;;;;;; ;




	.bank 3
	.org $FFF5
TEST_FFFF_Branch_Wraparound:
	; A = 0, so this branch to $0050 is always taken.
	LDA #0
	.byte $F0, $57; BNE $0050
	RTS
;;;;;;;
	.org $FFFA	; Interrupt vectors go here:
	.word $0700 ; NMI
	.word RESET ; Reset
	.word $0600 ; IRQ

	;;;; MORE COMPILER STUFF, ADDING THE PATTERN DATA ;;;;

	.incchr "Sprites.pcx"
	.incchr "Tiles.pcx"
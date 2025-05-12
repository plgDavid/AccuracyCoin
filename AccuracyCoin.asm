
	
	
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


result_PowOn_CPURAM = $0480
result_PowOn_CPUReg = $0481
result_PowOn_PPURAM = $0482
result_PowOn_PPUPal = $0483
result_PowOn_PPUReset = $0484



;TEST_Unofficial_Operand = $580+(TEST_UnOp_RAMFunctionTest-TEST_UnOp_RAMFunction)+1
;TEST_Unofficial_Operand2 = $580+(TEST_UnOp_RAMFunctionTest-TEST_UnOp_RAMFunction)+2



;$500 is dedicated to RAM needed for tests.

;$600 is dedicated to the IRQ routine
;$700 is dedicated to the NMI routine.


	;;;; ASSEMBLY CODE ;;;;
	.org $8000
	; The open bus test needs to make sure an inaccurate emulation of open bus will fall into test code, so this function here is a fail condition of the open bus test.
OpenBusTestFakedOpenBusBehavior:
	NOP
	NOP
	PLA ; remove the return address from the JSR to open bus.
	PLA
	JMP TEST_Fail ; and boo womp! The test has failed.
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
	LDX #$FF
	TXS
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
	

	
	.org $9000
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
	.word Suite_UnofficialOps_Immediates
	.word Suite_CPUInterrupts
	.word Suite_DMATests
	.word Suite_PowerOnState
	.word Suite_PPUBehavior
EndTableTable:




	;; CPU Behavior ;;
Suite_CPUBehavior:
	.byte "CPU Behavior", $FF
	table "CPU Instructions", $FF, result_CPUInstr, DebugTest
	table "Unofficial Instructions", $FF, result_UnofficialInstr, TEST_UnofficialInstructionsExist
	table "ROM is not writable", $FF, result_ROMnotWritable, TEST_ROMnotWritable
	table "RAM Mirroring", $FF, result_RAMMirror, TEST_RamMirroring
	table "PPU Register Mirroring", $FF, result_PPURegMirror, TEST_PPURegMirroring
	table "$FFFF + X Wraparound", $FF, $0100, DebugTest
	table "Dummy read cycles", $FF, result_DummyReads, TEST_DummyReads
	table "Dummy write cycles", $FF, result_DummyWrites, TEST_DummyWrites
	table "Open Bus", $FF, result_OpenBus, TEST_OpenBus
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
	table "Print magic constants", $FF, result_UnOp_Magic, TEST_MAGIC
	.byte $FF
	
	
	
	;; CPU Interrupts ;;
Suite_CPUInterrupts:
	.byte "CPU Interrupts by Blargg", $FF
	table "CLI Latency", $FF, $0100, DebugTest
	table "NMI AND BRK", $FF, $0100, DebugTest
	table "NMI AND IRQ", $FF, $0100, DebugTest
	table "IRQ AND DMA", $FF, $0100, DebugTest
	table "Branch delays IRQ", $FF, $0100, DebugTest
	.byte $FF
	
	;; DMA Tests ;;
Suite_DMATests:
	.byte "DMA tests", $FF
	table "DMA + $2007 Read", $FF, $0100, DebugTest
	table "DMA + $2007 Write", $FF, $0100, DebugTest
	table "DMA + $4016 Read", $FF, $0100, DebugTest
	table "DMC DMA + OAM DMA", $FF, $0100, DebugTest
	table "DMC DMA Implicit Stop", $FF, $0100, DebugTest
	table "DMC DMA Explicit Stop", $FF, $0100, DebugTest
	table "APU Register Activation", $FF, $0100, DebugTest
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
	table "$2002 Race condition", $FF, $0100, DebugTest
	table "Palette Corruption", $FF, $0100, DebugTest
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
	; Load OAM[0] with #0
	; Load OAM[1] with #1
	; Load OAM[2] with #2
	; Load OAM[3] with #3
	; keep Y unchanged.
	STY <$FE
	LDX #0
	STX $2003
	LDY #4
TEST_DummyWritesPrepLoop:
	STX $2004
	INX
	DEY
	BNE TEST_DummyWritesPrepLoop	
	LDX #0
	STX $2003
	LDY <$FE
	RTS
;;;;;;;
TEST_DummyWrites:
	; Pre-Test preparations.
	JSR TEST_DummyWrites_Prep
	;;; Test 1 [Dummy Write Cycles]: Confirm reading from $2004 works.
	LDA #03
	STA $2003
	LDA #0
	LDA $2004 ; A=3
	CMP #$03
	BNE TEST_Fail3
	INC <currentSubTest 
	
	;;; Test 2 [Dummy Write Cycles]: Read-Modify-Write instruction perform dummy reads. ;;;
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
	; And since writes to $2004 increment the PPU's OAM address, we can test for dummy writes by seeing how many times the OAM address is incremented.
	JSR TEST_DummyWrites_Prep ; OAM address is now 0	
	ASL $2004 ; This should move the OAM address twice, to 2.
	LDA $2004 ; A=2
	CMP #$02
	BNE TEST_Fail3
	INC <currentSubTest 
	
	;;; Test 2 [Dummy Write Cycles]: Check every official Read-Modify-Write opcode. ;;;
	; ASL, ROL, LSR, ROR, DEC, INC
	; Absolute, Absolute+X
	; 0E, 1E, 2E, 3E, 4E, 5E, 6E, 7E, CE, DE, EE, FE
	; Let's run this in RAM. It will save on bytes to be able to modify the opcode and keep jumping there in a loop.
	LDA #$04
	STA $501
	LDA #$20
	STA $502
	LDA #$60
	STA $503
	LDY #0
TEST_DummyWrites_Test2Loop:
	JSR TEST_DummyWrites_Prep
	TYA		; Get Y into the upper nybble of A
	ASL A
	ASL A
	ASL A
	ASL A
	ORA #$E	; and set the low nybble to E
	STA $500
	JSR $500 ; run the test.
	LDA $2004 	; A=2
	CMP #$02	; else, fail the test.
	BNE TEST_Fail3
	INY
	CPY #8
	BNE TEST_DummyWrites_Test2SkipLDY
	LDY #$0C
TEST_DummyWrites_Test2SkipLDY:
	CPY #$10
	BNE TEST_DummyWrites_Test2Loop	
	;; END OF TEST ;;
	LDA #01
	RTS
;;;;;;;

TEST_PowerOnState_CPU_RAM:
	;;; Test 1 [CPU RAM Power On State]: Print the values recorded at power on ;;;
	JSR ClearNametableFrom2240
	JSR ResetScroll
	JSR WaitForVBlank
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
	JSR ResetScroll
	JSR WaitForVBlank
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
	JSR ResetScroll
	JSR WaitForVBlank
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
	JSR ResetScroll
	JSR WaitForVBlank
	LDA PowerOnTest_PPUReset
	;; END OF TEST ;;
	RTS
;;;;;;;

TEST_PowerOnState_CPU_Registers:
	;;; Test 1 [CPU Registers Power On State]: Print the values recorded at power on ;;;
	JSR ClearNametableFrom2240
	JSR ResetScroll
	JSR WaitForVBlank
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

	JSR ResetScroll
	JSR WaitForVBlank

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
	
	;;; Test K [Unofficial Instructions Exist]: Does LAS exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	; This also destroys the stack pointer, so...
	TSX
	STX $501
	LDA #$33
	STA $500
	; The stack pointer *should* be $F6
	.byte $BB ; LAS $500
	.word $0500 
	; A = StackPointer & Immediate
	; And then transfer A to X and StackPointer.
	; So let's fix the stakc pointer first.
	TSX
	CPX $0501
	BNE TEST_UnofficialInst_2
	; The stack pointer was unchanged?!
	JMP TEST_Fail
TEST_UnofficialInst_2:
	STX <$FD
	LDX $501
	TXS	; Fix the stack pointer
	CMP #$32
	BNE TEST_Fail6
	LDX <$FD
	CPX #$32
	BNE TEST_Fail6
	; LAE TEST_Fail6!
	INC <currentSubTest
	
	;;; Test L [Unofficial Instructions Exist]: Does DCP exist? ;;;
	JSR TEST_UnofficialInstructions_Prep
	LDA #$41
	.byte $CF	; DCP $0500
	.word $0500
	BNE TEST_Fail6	
	; LAE exists!
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

TEST_UnOp_RamFunc: ; this gets copy/pasted into RAM at address $580
	STX <Copy_X
	TSX			; Some unofficial instructions modify the stack pointer
	STX <Copy_SP; make a copy of the stack pointer
	LDX <Copy_X ; restore X for the test.
	STA <Copy_A
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
	.word TEST_UnOp_SetupAddrMode_IndX  ; 3 - (Indirect, X)
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
	.word TEST_UnOp_SetupAddrMode_IndY  ; 13- (Indirect), Y
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
	PLA	; Pull of the Return Address
	PLA	;
	PLA
	PLA
	JMP TEST_Fail ; and fail the test.

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
	; The ANE and LXA instructions have "magic constants".
	; The constant is typically $EE or $FF.
	; This test just prints what the value is for both instructions.	
	LDA #0
	STA <dontSetPointer
	JSR PrintTextCentered
	.word $2330
	.byte "ANE constant = $", $FF
	LDA #0
	LDX #$FF
	.byte $8B, $FF ; ANE #$FF
	JSR PrintByte
	
	JSR PrintTextCentered
	.word $2350
	.byte "LXA constant = $", $FF
	LDA #0
	.byte $AB, $FF ; LXA #$FF
	JSR PrintByte
	
;; END OF TEST ;;
	JSR ResetScroll
	LDA #1
	RTS
















	
	
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
	LDX #$FF
WaitForVblLoop:
	LDA $2002
	BPL WaitForVblLoop
	INX
	BEQ WaitForVblLoop
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
	; Basically, this makes a bunch of preperations for tests, like clearing page 5 of RAM, halting the NMI, etc.
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
	JSR ResetScroll		          ; Reset the scroll before the test, since we just modified 'v' inside the previous subroutines.
	JSR ClearPage5		          ; clear RAM from $500 to $5FF. That RAM is dedicated for running tests, so we want it clean.
	JSR WaitForVBlank             ; this makes debugging your own emulator with this ROM much easier, since the test should always begin at the start of a frame.
	JSR JSRFromRAM                ; !! This is where the test occurs. "JSRFromRAM" is at address $001A. !!
	                              ; The A Register holds the results of the test.
	LDY #0
	STA [TestResultPointer],Y     ; store the test results in RAM.
	JSR WaitForVBlank		      ; and wait for VBlank before updating the "...." text with the results.
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


	.bank 3
	.org $FFFA	; Interrupt vectors go here:
	.word $0700 ; NMI
	.word RESET ; Reset
	.word $0600 ; IRQ

	;;;; MORE COMPILER STUFF, ADDING THE PATTERN DATA ;;;;

	.incchr "Sprites.pcx"
	.incchr "Tiles.pcx"
# AccuracyCoin
A large collection of NES accuracy tests on a single NROM cartridge.

When running a test, the word "TEST" will either be replaced with "PASS" or "FAIL X" where X refers to an error code. This ROM is a work is progress, so I don't really have a sheet of what the error codes mean yet, you would have to dig through the ASM code to read the documentation.

This is a work in progress. So far I have a working test for:
## CPU Behavior
* Unofficial instructions
* ROM is not writable
* RAM mirroring
* FFFF + X Wraparound
* PPU Register Mirroring
* PPU Register Open Bus
* Dummy Read Cycles
* Dummy Write Cycles
* Open Bus

## Thorough tests of all unofficial opcodes.
* SLO, RLA, SRE, RRA, SAX, LAX, DCP, and ISC
* SHA†, SHS†, SHX, and SHY (Including these instructions with a DMA occuring in the middle of them)
* ANC, ASR, ARR, ANE, LXA, AXS, and SBC

† Through research with this cartridge, 2 different behaviors for the SHA and SHS instruction have been identified. This cartridge will determine which one your console (or emulator) is using, and run an appropriate set of tests for the detected behavior. It also prints on screen which behavior was used.

## DMA specific tests
* DMA + $2007 Read
* DMA + $2007 Write

## Power On State
These tests are mostly just for printing the values that existed in RAM and registers form the moment the console powers on. They simply print values on screen and return "PASS". The "PPU Reset Flag" test just checks if the PPU Reset flag exists on this console.
* CPU RAM
* CPU Registers
* PPU RAM
* Palette RAM
* PPU Reset Flag

## Work In Progress Tests
* More PPU specific tests.
* Probably some more test with DMAs, since I got the timing on those down.

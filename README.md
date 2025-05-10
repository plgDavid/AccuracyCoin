# AccuracyCoin
A large collection of NES accuracy tests on a single NROM cartridge.

When running a test, the word "TEST" will either be replaced with "PASS" or "FAIL X" where X refers to an error code. This ROM is a work is progress, so I don't really have a sheet of what the error codes mean yet, you would have to dig through the ASM code to read the documentation.

This is a work in progress. So far I have a working test for:
### CPU Behavior
* Unofficial instructions
* ROM is not writable
* RAM mirroring
* PPU Register Mirroring
* Dummy Read Cycles
* Open Bus

### Power On State
These tests are mostly just for printing the values that existed in RAM and registers form the moment the console powers on. They simply print values on screen and return "PASS". The "PPU Reset Flag" test just checks if the PPU Reset flag exists on this console.
* CPU RAM
* CPU Registers
* PPU RAM
* Palette RAM
* PPU Reset Flag

### Work In Progress Tests
The "Dummy Write Cycles" test is currently CPU/PPU clock alignment specific, and I plan to fix this. Any other tests that have a name when running this ROM simply return a "FAIL 0", but I plan to implement tests for them.

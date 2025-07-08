; ATARI VIDEO CHESS ROM DUMP - ANNOTATED
; Part 1: System Initialization and Main Game Loop
; Original ROM starts at $F000

                            * = $F000

; ===== SYSTEM INITIALIZATION =====
F000   78                   SEI             ; Disable interrupts
F001   D8                   CLD             ; Clear decimal mode
F002   A2 FF                LDX #$FF        ; Load X with $FF
F004   9A                   TXS             ; Set stack pointer to $FF (top of stack)
F005   E8                   INX             ; X = 0 (increment from $FF wraps to 0)
F006   8A                   TXA             ; A = 0

; Zero page memory initialization loop
F007   95 00      LF007     STA $00,X       ; Clear zero page memory location
F009   E8                   INX             ; Next memory location
F00A   D0 FB                BNE LF007       ; Continue until all 256 bytes cleared

; Initialize chess board and game state
F00C   20 AD F2             JSR LF2AD       ; Jump to board setup routine

; ===== MAIN GAME LOOP =====
F00F   A9 FF      LF00F     LDA #$FF        ; Load $FF (all bits set)
F011   85 02                STA $02         ; Store in TIA WSYNC (wait for sync)
F013   85 00                STA $00         ; Store in TIA VSYNC 
F015   85 01                STA $01         ; Store in TIA VBLANK

; Game state counters and timers
F017   E6 D3                INC $D3         ; Increment game timer low byte
F019   D0 06                BNE LF021       ; If no overflow, skip high byte increment
F01B   E6 F1                INC $F1         ; Increment game timer low byte
F01D   D0 02                BNE LF021       ; If no overflow, continue
F01F   85 F0                STA $F0         ; Reset timer if overflow

; Random number generation and display setup
F021   45 F0      LF021     EOR $F0         ; XOR with timer for randomness
F023   09 F7                ORA #$F7        ; Set specific bits
F025   85 E9                STA $E9         ; Store random seed

; Read console switches (difficulty, game select, etc.)
F027   AD 82 02             LDA $0282       ; Read console switches
F02A   29 08                AND #$08        ; Isolate bit 3 (color/bw)
F02C   4A                   LSR A           ; Shift right to get 0 or 4
F02D   A8                   TAY             ; Use as index

; Background color generation during AI thinking
F02E   A2 04                LDX #$04        ; Loop counter for 4 iterations
F030   A5 F1      LF030     LDA $F1         ; Load timer high byte
F032   25 F0                AND $F0         ; AND with timer low byte  
F034   59 6E FF             EOR $FF6E,Y     ; XOR with pattern data from table
F037   25 E9                AND $E9         ; AND with random seed - CREATES RANDOM BACKGROUND
F039   95 DD                STA $DD,X       ; Store in game variables ($DD-$E0)
F03B   95 05                STA $05,X       ; Store in TIA background color registers ($05-$08)
F03D   C8                   INY             ; Next pattern index
F03E   CA                   DEX             ; Decrement loop counter
F03F   D0 EF                BNE LF030       ; Continue loop

; Initialize display variables
F041   86 06                STX $06         ; X=0, clear display offset
F043   AC 82 02             LDY $0282       ; Read console switches again
F046   84 ED                STY $ED         ; Store switch state
F048   10 06                BPL LF050       ; If positive, skip color swap

; Handle color/player swap
F04A   A4 DF                LDY $DF         ; Load player color
F04C   85 DF                STA $DF         ; Store new color
F04E   84 DE                STY $DE         ; Swap colors

; Set up display parameters
F050   A0 24      LF050     LDY #$24        ; Load display line count (36 lines)
F052   85 02                STA $02         ; Store in WSYNC
F054   86 00                STX $00         ; Clear VSYNC
F056   8C 96 02             STY $0296       ; Store line count in TIA

; Call display routine
F059   20 AA F2             JSR LF2AA       ; Jump to display generation routine

; Game logic and input processing
F05C   A5 D3                LDA $D3         ; Load game timer
F05E   29 0C                AND #$0C        ; Isolate bits 2-3
F060   C9 04                CMP #$04        ; Compare with 4
F062   20 3C F5             JSR LF53C       ; Call game state routine

; Player move processing
F065   A6 D9                LDX $D9         ; Load current player position
F067   90 0C                BCC LF075       ; If carry clear, handle computer move
F069   A4 F3                LDY $F3         ; Load move state
F06B   30 08                BMI LF075       ; If negative, handle computer move
F06D   A4 DB                LDY $DB         ; Load piece type
F06F   D0 08                BNE LF079       ; If not zero, process move
F071   A4 F3                LDY $F3         ; Load move state again
F073   D0 04                BNE LF079       ; If not zero, process move

; Default move handling
F075   A9 08      LF075     LDA #$08        ; Load default move value
F077   D0 02                BNE LF07B       ; Always branch to move processing

; Load piece for move
F079   A5 DB      LF079     LDA $DB         ; Load piece type

; Process the move
F07B   20 64 FE   LF07B     JSR LFE64       ; Call piece placement routine
; ATARI VIDEO CHESS ROM DUMP - ANNOTATED
; Part 2: Move Processing and Game State Management

; ===== MOVE VALIDATION AND PROCESSING =====
F07E   A6 DA                LDX $DA         ; Load destination square
F080   B5 80                LDA $80,X       ; Load piece at destination
F082   29 F0                AND #$F0        ; Mask to get piece type (upper nibble)
F084   A4 E7                LDY $E7         ; Load move flags
F086   30 0C                BMI LF094       ; If negative, handle special move

; Standard move processing
F088   A4 F3                LDY $F3         ; Load game state
F08A   F0 0E                BEQ LF09A       ; If zero, continue to piece placement
F08C   10 02                BPL LF090       ; If positive, check capture
F08E   B0 08                BCS LF098       ; If carry set, place piece

F090   90 04      LF090     BCC LF096       ; If carry clear, OR with piece
F092   05 DC                ORA $DC         ; OR with captured piece value
F094   B0 02      LF094     BCS LF098       ; If carry set, place piece
F096   05 DB      LF096     ORA $DB         ; OR with moving piece value

; Place piece on board
F098   95 80      LF098     STA $80,X       ; Store piece at destination square

; Handle move completion and game state updates
F09A   A5 E7      LF09A     LDA $E7         ; Load move flags
F09C   F0 0A                BEQ LF0A8       ; If zero, skip special handling
F09E   30 08                BMI LF0A8       ; If negative, skip special handling
F0A0   05 E6                ORA $E6         ; OR with game flags
F0A2   10 04                BPL LF0A8       ; If positive, continue
F0A4   A9 00                LDA #$00        ; Clear accumulator
F0A6   85 E7                STA $E7         ; Clear move flags

; Sound and display effects
F0A8   A8         LF0A8     TAY             ; Transfer A to Y for indexing
F0A9   F0 1D                BEQ LF0C8       ; If zero, skip sound
F0AB   A6 F7                LDX $F7         ; Load sound state
F0AD   30 0E                BMI LF0BD       ; If negative, skip sound setup
F0AF   A5 F6                LDA $F6         ; Load sound duration
F0B1   F0 0A                BEQ LF0BD       ; If zero, skip sound
F0B3   A9 0F                LDA #$0F        ; Load sound volume (max)
F0B5   B0 03                BCS LF0BA       ; If carry set, use max volume
F0B7   A9 09                LDA #$09        ; Load medium volume
F0B9   A8                   TAY             ; Transfer to Y
F0BA   20 64 FE   LF0BA     JSR LFE64       ; Call sound generation routine

; Update display and timing
F0BD   A5 EE      LF0BD     LDA $EE         ; Load display state
F0BF   2A                   ROL A           ; Rotate left (multiply by 2)
F0C0   C9 04                CMP #$04        ; Compare with 4
F0C2   B0 04                BCS LF0C8       ; If >= 4, skip lookup
F0C4   AA                   TAX             ; Use as index
F0C5   BC E9 FE             LDY $FEE9,X     ; Load display pattern from table

; Store display value and wait for vertical sync
F0C8   84 15      LF0C8     STY $15         ; Store display pattern
F0CA   AD 84 02   LF0CA     LDA $0284       ; Read INTIM (timer)
F0CD   D0 FB                BNE LF0CA       ; Wait until timer expires (VBLANK end)

; Reset display registers
F0CF   85 02                STA $02         ; Clear WSYNC
F0D1   C6 D0                DEC $D0         ; Decrement display counter
F0D3   10 04                BPL LF0D9       ; If positive, continue
F0D5   E6 D0                INC $D0         ; Reset counter if negative
F0D7   85 01                STA $01         ; Clear VBLANK

; ===== DISPLAY GENERATION SETUP =====
F0D9   A2 0F      LF0D9     LDX #$0F        ; Load 15 (for 16 iterations)
F0DB   86 19                STX $19         ; Store in display counter
F0DD   86 17                STX $17         ; Store in another counter
F0DF   A0 FF                LDY #$FF        ; Load $FF (all bits set)

; Clear display buffers
F0E1   94 C0      LF0E1     STY $C0,X       ; Clear display buffer (odd positions)
F0E3   CA                   DEX             ; Decrement index
F0E4   95 C0                STA $C0,X       ; Clear display buffer (even positions)
F0E6   CA                   DEX             ; Decrement index
F0E7   10 F8                BPL LF0E1       ; Continue until all cleared

; Set up board display parameters
F0E9   A0 3C                LDY #$3C        ; Load 60 (board height in pixels)
F0EB   20 45 F5             JSR LF545       ; Call board setup routine
F0EE   85 2B                STA $2B         ; Store result

; Read joystick and process input
F0F0   A5 EA                LDA $EA         ; Load joystick state
F0F2   AE 84 02   LF0F2     LDX $0284       ; Read timer
F0F5   D0 FB                BNE LF0F2       ; Wait for timer
F0F7   86 EB                STX $EB         ; Clear input buffer
F0F9   85 02                STA $02         ; Store in WSYNC
F0FB   85 12                STA $12         ; Store joystick state

; Calculate display positioning
F0FD   A0 66                LDY #$66        ; Load 102 (display offset)
F0FF   84 E8                STY $E8         ; Store display offset
F101   0A                   ASL A           ; Multiply joystick by 2
F102   0A                   ASL A           ; Multiply by 4 total
F103   65 EA                ADC $EA         ; Add original joystick value (x5)
F105   69 46                ADC #$46        ; Add base offset (70)
F107   85 CA                STA $CA         ; Store calculated position

; Initialize display pointers and counters
F109   A0 04                LDY #$04        ; Load 4
F10B   A2 20                LDX #$20        ; Load 32
F10D   86 22                STX $22         ; Store counter
F10F   A2 02                LDX #$02        ; Load 2
F111   86 05                STX $05         ; Store in zero page
F113   85 14                STA $14         ; Store position
F115   85 10                STA $10         ; Store in another location

; Set up memory pointers for display generation
F117   A9 D0                LDA #$D0        ; Load high byte of pointer
F119   85 11                STA $11         ; Store pointer high byte
F11B   85 24                STA $24         ; Store in another pointer
F11D   A9 F1                LDA #$F1        ; Load different high byte
F11F   85 21                STA $21         ; Store pointer high byte
F121   85 25                STA $25         ; Store in another pointer
F123   85 02                STA $02         ; Store in WSYNC
F125   85 2A                STA $2A         ; Store in temp variable
F127   85 1D                STA $1D         ; Store in display variable
F129   85 0A                STA $0A         ; Store in zero page
F12B   86 04                STX $04         ; Store X register value
F12D   A9 38                LDA #$38        ; Load 56 (chess board related)
F12F   85 C0                STA $C0         ; Store in display buffer

; Load current game state for display
F131   A6 EE                LDX $EE         ; Load current player
F133   B5 DE                LDA $DE,X       ; Load player's piece color
F135   85 F8                STA $F8         ; Store piece color
F137   A5 DF                LDA $DF         ; Load game state
F139   85 FD                STA $FD         ; Store game state
F13B   4C CF F1             JMP LF1CF       ; Jump to display generation routine
; ATARI VIDEO CHESS ROM DUMP - ANNOTATED
; Part 3: Chess Move Validation and Special Moves (Castling, En Passant)

; ===== SPECIAL MOVE HANDLING (CASTLING AND EN PASSANT) =====
F13E   A5 D6      LF13E     LDA $D6         ; Load piece type being moved
F140   A6 D5                LDX $D5         ; Load destination square
F142   29 07                AND #$07        ; Mask to get piece type (0-7)
F144   C9 06                CMP #$06        ; Compare with 6 (King)
F146   D0 1B                BNE LF163       ; If not king, check for pawn moves

; ===== CASTLING LOGIC =====
F148   A5 E5                LDA $E5         ; Load castling flags
F14A   49 10                EOR #$10        ; Toggle castling bit
F14C   A8                   TAY             ; Store in Y
F14D   49 08                EOR #$08        ; Toggle another castling bit
F14F   C5 D5                CMP $D5         ; Compare with destination
F151   F0 2C                BEQ LF17F       ; If equal, execute castling move

; Check if king is moving to valid castling squares
F153   E0 08                CPX #$08        ; Check if destination is square 8
F155   90 04                BCC LF15B       ; If less, check king side castle
F157   E0 38                CPX #$38        ; Check if destination is square 56
F159   90 27                BCC LF182       ; If in range, invalid castle

; Handle kingside vs queenside castling
F15B   A5 D6      LF15B     LDA $D6         ; Load piece type again
F15D   49 04                EOR #$04        ; Toggle bit 2
F15F   85 D6                STA $D6         ; Store modified piece type
F161   B0 1F                BCS LF182       ; If carry set, exit

; ===== PAWN SPECIAL MOVES (EN PASSANT) =====
F163   C9 01      LF163     CMP #$01        ; Compare with 1 (Pawn)
F165   D0 1B                BNE LF182       ; If not pawn, exit routine
F167   A5 D4                LDA $D4         ; Load source square
F169   29 38                AND #$38        ; Mask to get rank (row)
F16B   A8                   TAY             ; Store rank in Y
F16C   8A                   TXA             ; Transfer destination to A
F16D   E5 D4                SBC $D4         ; Subtract source from destination
F16F   C9 FE                CMP #$FE        ; Compare with -2 (two squares back)
F171   D0 03                BNE LF176       ; If not -2, check forward move
F173   E8                   INX             ; Increment destination
F174   B0 09                BCS LF17F       ; If carry set, execute move

; Check for two-square pawn advance
F176   C9 02      LF176     CMP #$02        ; Compare with +2 (two squares forward)
F178   D0 08                BNE LF182       ; If not +2, exit
F17A   CA                   DEX             ; Decrement destination
F17B   98                   TYA             ; Transfer rank back to A
F17C   09 07                ORA #$07        ; Set file bits (column 7)
F17E   A8                   TAY             ; Store back in Y

; Execute special move (castling or en passant)
F17F   20 37 FD   LF17F     JSR LFD37       ; Call piece movement routine
F182   60         LF182     RTS             ; Return from subroutine

; ===== DISPLAY GENERATION ROUTINES =====
F183   38         LF183     SEC             ; Set carry flag
F184   95 C0      LF184     STA $C0,X       ; Store in display buffer with carry
F186   A5 DE                LDA $DE         ; Load display state
F188   B0 1F                BCS LF1A9       ; If carry set, handle differently

F18A   95 C0      LF18A     STA $C0,X       ; Store in display buffer
F18C   A5 DE                LDA $DE         ; Load display state
F18E   90 31                BCC LF1C1       ; If carry clear, continue

; Display pattern generation loop - CHECKING COLOR AFTER SHIFTING
F190   48                   PHA             ; Push A to stack
F191   CA                   DEX             ; Decrement X
F192   30 31                BMI LF1C5       ; If negative, exit loop
F194   CA         LF194     DEX             ; Decrement X again
F195   B9 80 00             LDA $0080,Y     ; Load from board array
F198   C8                   INY             ; Increment Y
F199   0A                   ASL A           ; Shift left (multiply by 2)
F19A   0A                   ASL A           ; Shift left (multiply by 4) 
F19B   0A                   ASL A           ; Shift left (multiply by 8) - NOW BIT 3 BECOMES BIT 6
F19C   C9 40                CMP #$40        ; Compare with $40 - CHECKING IF WHITE (bit 3 shifted to bit 6)
F19E   90 E3                BCC LF183       ; If less than $40, it's black piece
F1A0   F0 E2                BEQ LF184       ; If equal to $40, it's white piece
F1A2   29 38                AND #$38        ; Mask bits for piece type
F1A4   EA                   NOP             ; No operation
F1A5   95 C0                STA $C0,X       ; Store in display buffer
F1A7   A5 DF                LDA $DF         ; Load game state

F1A9   48         LF1A9     PHA             ; Push A to stack
F1AA   CA                   DEX             ; Decrement X
F1AB   CA                   DEX             ; Decrement X
F1AC   B9 80 00             LDA $0080,Y     ; Load from board array
F1AF   C8                   INY             ; Increment Y
F1B0   85 2A                STA $2A         ; Store in temporary variable
F1B2   0A                   ASL A           ; Shift left
F1B3   0A                   ASL A           ; Shift left
F1B4   0A                   ASL A           ; Shift left
F1B5   C9 40                CMP #$40        ; Compare with 64
F1B7   90 D1                BCC LF18A       ; If less, branch
F1B9   F0 CF                BEQ LF18A       ; If equal, branch
F1BB   29 38                AND #$38        ; Mask bits
F1BD   95 C0                STA $C0,X       ; Store in display buffer
F1BF   A5 DF                LDA $DF         ; Load game state

F1C1   48         LF1C1     PHA             ; Push A to stack
F1C2   CA                   DEX             ; Decrement X
F1C3   10 CF                BPL LF194       ; If positive, continue loop

; Finalize display generation
F1C5   84 EB      LF1C5     STY $EB         ; Store Y in temp variable
F1C7   9A                   TXS             ; Transfer X to stack pointer
F1C8   A0 05                LDY #$05        ; Load 5
F1CA   B1 CC                LDA ($CC),Y     ; Load indirect with Y offset
F1CC   4A                   LSR A           ; Shift right
F1CD   85 1B                STA $1B         ; Store result

; Jump to main display routine
F1CF   A5 FE      LF1CF     LDA $FE         ; Load display parameter
F1D1   85 06                STA $06         ; Store in zero page
F1D3   85 2B                STA $2B         ; Store in temp variable
F1D5   85 02                STA $02         ; Store in WSYNC
F1D7   85 2A                STA $2A         ; Store in another temp
F1D9   4C 09 F2             JMP LF209       ; Jump to display routine

; ===== GAME STATE MANAGEMENT =====
F1DC   A2 04      LF1DC     LDX #$04        ; Load 4 (for 5 bytes)
F1DE   B5 D9      LF1DE     LDA $D9,X       ; Load game state byte
F1E0   95 D4                STA $D4,X       ; Copy to another location
F1E2   CA                   DEX             ; Decrement counter
F1E3   10 F9                BPL LF1DE       ; Continue until all copied
F1E5   60                   RTS             ; Return

; Move execution and validation
F1E6   85 15      LF1E6     STA $15         ; Store move parameter
F1E8   A5 E7                LDA $E7         ; Load move flags
F1EA   10 0F                BPL LF1FB       ; If positive, skip special handling
F1EC   84 F3                STY $F3         ; Store Y in game state
F1EE   A5 EE                LDA $EE         ; Load current player
F1F0   F0 09                BEQ LF1FB       ; If zero (white), skip
F1F2   A6 DA                LDX $DA         ; Load destination square
F1F4   A5 D6                LDA $D6         ; Load piece type
F1F6   20 64 FE             JSR LFE64       ; Call piece placement routine
F1F9   84 D6                STY $D6         ; Store piece type

F1FB   84 E7      LF1FB     STY $E7         ; Store move flags
F1FD   60                   RTS             ; Return
; ATARI VIDEO CHESS ROM DUMP - ANNOTATED
; Part 4: Display Generation and Board Rendering

; ===== DISPLAY SCANLINE GENERATION =====
F1FE   B1 CC      LF1FE     LDA ($CC),Y     ; Load from display pointer with Y offset
F200   4A                   LSR A           ; Shift right (divide by 2)
F201   85 1B                STA $1B         ; Store in display register 1
F203   A5 FE                LDA $FE         ; Load display parameter
F205   85 2A                STA $2A         ; Store in temp variable
F207   85 06                STA $06         ; Store in zero page

; Main display generation loop - generates each scanline
F209   B1 C8      LF209     LDA ($C8),Y     ; Load from pointer C8 with Y offset
F20B   4A                   LSR A           ; Shift right
F20C   85 1C                STA $1C         ; Store in display register 2
F20E   A5 FC                LDA $FC         ; Load display parameter
F210   8D 07 00             STA $0007       ; Store in zero page location 7

; Generate chess piece graphics
F213   B1 C4                LDA ($C4),Y     ; Load from pointer C4
F215   4A                   LSR A           ; Shift right
F216   85 1B                STA $1B         ; Store piece graphics data
F218   B1 C0                LDA ($C0),Y     ; Load from pointer C0
F21A   4A                   LSR A           ; Shift right
F21B   A6 FA                LDX $FA         ; Load X coordinate
F21D   86 06                STX $06         ; Store X coordinate
F21F   85 1C                STA $1C         ; Store in display register

; Set up piece positioning
F221   A6 F8                LDX $F8         ; Load piece color/type
F223   86 07                STX $07         ; Store in zero page
F225   A9 70                LDA #$70        ; Load display constant
F227   85 20                STA $20         ; Store in display register
F229   85 21                STA $21         ; Store in another register

; Continue display generation
F22B   A5 FF                LDA $FF         ; Load display parameter
F22D   85 06                STA $06         ; Store coordinate
F22F   A6 FB                LDX $FB         ; Load another coordinate
F231   85 02                STA $02         ; Store in WSYNC
F233   85 2A                STA $2A         ; Store in temp

; Generate board square graphics
F235   B1 CE                LDA ($CE),Y     ; Load from pointer CE
F237   85 1B                STA $1B         ; Store square graphics
F239   B1 CA                LDA ($CA),Y     ; Load from pointer CA
F23B   85 1C                STA $1C         ; Store square graphics
F23D   A5 FD                LDA $FD         ; Load board state
F23F   85 07                STA $07         ; Store in zero page

; More piece graphics generation
F241   B1 C6                LDA ($C6),Y     ; Load from pointer C6
F243   85 1B                STA $1B         ; Store graphics data
F245   B1 C2                LDA ($C2),Y     ; Load from pointer C2
F247   86 06                STX $06         ; Store X coordinate
F249   A6 F9                LDX $F9         ; Load piece parameter
F24B   85 1C                STA $1C         ; Store graphics data
F24D   86 07                STX $07         ; Store in zero page

; Set display mode
F24F   A9 90                LDA #$90        ; Load display mode constant
F251   85 20                STA $20         ; Store in display register
F253   85 21                STA $21         ; Store in another register
F255   88                   DEY             ; Decrement Y (next scanline)
F256   10 A6                BPL LF1FE       ; If positive, continue scanline loop

; End of display generation - clear registers
F258   C8                   INY             ; Increment Y (Y=0)
F259   84 1B                STY $1B         ; Clear display register 1
F25B   84 1C                STY $1C         ; Clear display register 2
F25D   84 0F                STY $0F         ; Clear zero page location
F25F   84 06                STY $06         ; Clear coordinate
F261   85 2A                STA $2A         ; Clear temp variable
F263   98                   TYA             ; Transfer Y to A (A=0)

; Check display buffer status
F264   A4 EB                LDY $EB         ; Load display buffer index
F266   C0 40                CPY #$40        ; Compare with 64
F268   B0 11                BCS LF27B       ; If >= 64, handle overflow

; Normal display buffer processing
F26A   A5 E8                LDA $E8         ; Load display offset
F26C   85 1F                STA $1F         ; Store in temp
F26E   49 FE                EOR #$FE        ; XOR with $FE (flip bits)
F270   85 E8                STA $E8         ; Store back
F272   85 0F                STA $0F         ; Store in zero page
F274   A2 0F                LDX #$0F        ; Load 15
F276   85 2B                STA $2B         ; Store in temp
F278   4C 94 F1             JMP LF194       ; Jump back to display loop

; Handle display buffer overflow
F27B   A0 3F      LF27B     LDY #$3F        ; Load 63 (max buffer index)
F27D   84 04                STY $04         ; Store in zero page
F27F   84 1D                STY $1D         ; Store in display variable
F281   A0 5D                LDY #$5D        ; Load 93
F283   20 45 F5             JSR LF545       ; Call display setup routine

; ===== GAME LOGIC AND AI PROCESSING =====
F286   20 E7 F3             JSR LF3E7       ; Call game evaluation routine
F289   A9 09                LDA #$09        ; Load 9 (piece value)
F28B   85 CC                STA $CC         ; Store piece value
F28D   20 7D FE             JSR LFE7D       ; Call piece search routine
F290   E4 D9                CPX $D9         ; Compare with current position
F292   D0 06                BNE LF29A       ; If different, continue
F294   A5 F3                LDA $F3         ; Load game state
F296   F0 02                BEQ LF29A       ; If zero, continue
F298   A6 DD                LDX $DD         ; Load alternate position

F29A   86 F7      LF29A     STX $F7         ; Store AI move choice
F29C   A5 E2                LDA $E2         ; Load game flags
F29E   08                   PHP             ; Push processor status
F29F   68                   PLA             ; Pull processor status
F2A0   85 E2                STA $E2         ; Store flags

; Wait for vertical blank and restart main loop
F2A2   AD 84 02   LF2A2     LDA $0284       ; Read INTIM timer
F2A5   D0 FB                BNE LF2A2       ; Wait until timer expires
F2A7   4C 0F F0             JMP LF00F       ; Jump back to main game loop

; ===== CONSOLE SWITCH READING AND BOARD SETUP =====
F2AA   AD 82 02   LF2AA     LDA $0282       ; Read console switches (SWCHB)
F2AD   A0 00      LF2AD     LDY #$00        ; Initialize Y to 0
F2AF   4A                   LSR A           ; Shift right (check SELECT switch - bit 0)
F2B0   B0 4D                BCS LF2FF       ; If SELECT pressed, handle game select

; Initialize chess board to starting position
F2B2   84 E4                STY $E4         ; Clear game difficulty
F2B4   A2 07                LDX #$07        ; Load 7 (for 8 pieces)

; Set up initial piece positions
F2B6   BD F2 FE   LF2B6     LDA $FEF2,X     ; Load piece type from table
F2B9   95 80                STA $80,X       ; Store in board position (white back rank)
F2BB   49 08                EOR #$08        ; Flip color bit
F2BD   95 B8                STA $B8,X       ; Store in board position (black back rank)

; Set up pawns - BIT $80 SET FOR PAWN STATE TRACKING
F2BF   A9 8E                LDA #$8E        ; Load $8E = $80|$08|$06 (bit7=pawn flag, bit3=white, type=6)
F2C1   95 B0                STA $B0,X       ; Store black pawns (rank 7)
F2C3   A9 46                LDA #$46        ; Load $46 = $40|$06 (OLD ENCODING - should be $86 for black pawns)
F2C5   95 88                STA $88,X       ; Store white pawns (rank 2)

; Clear middle squares of board
F2C7   94 90                STY $90,X       ; Clear rank 3
F2C9   94 98                STY $98,X       ; Clear rank 4
F2CB   94 A0                STY $A0,X       ; Clear rank 5
F2CD   94 A8                STY $A8,X       ; Clear rank 6
F2CF   CA                   DEX             ; Decrement counter
F2D0   10 E4                BPL LF2B6       ; Continue until all pieces set

; Initialize game state variables
F2D2   86 E2                STX $E2         ; Clear game flags (X = -1)
F2D4   86 F7                STX $F7         ; Clear AI state
F2D6   86 E5                STX $E5         ; Clear move flags
F2D8   24 ED                BIT $ED         ; Test console switches
F2DA   10 10                BPL LF2EC       ; If positive, skip color setup

; Handle player color selection and board editing
F2DC   24 D3                BIT $D3         ; Test game timer
F2DE   70 01                BVS LF2E1       ; If overflow set, increment
F2E0   E8                   INX             ; Increment X (X = 0)
F2E1   94 8C      LF2E1     STY $8C,X       ; Clear board position (board edit mode)
F2E3   95 9C                STA $9C,X       ; Store piece (board edit mode)
F2E5   06 B9                ASL $B9         ; Shift board state
F2E7   38                   SEC             ; Set carry
F2E8   66 B9                ROR $B9         ; Rotate right with carry
F2EA   E6 E4                INC $E4         ; Increment difficulty

; Finalize board setup
F2EC   84 F3      LF2EC     STY $F3         ; Clear move state
F2EE   84 E7                STY $E7         ; Clear move flags
F2F0   A2 03                LDX #$03        ; Load 3
F2F2   86 EE                STX $EE         ; Store current player
F2F4   4A                   LSR A           ; Shift console switches
F2F5   85 D5                STA $D5         ; Store game mode
F2F7   85 D4                STA $D4         ; Store in another location
F2F9   85 D8                STA $D8         ; Store in third location
F2FB   98                   TYA             ; Transfer Y to A (A = 0)
F2FC   4C 20 F5             JMP LF520       ; Jump to game initialization
; ATARI VIDEO CHESS ROM DUMP - ANNOTATED
; Part 5: AI Logic and Move Generation

; ===== GAME SELECT AND DIFFICULTY HANDLING =====
F2FF   4A         LF2FF     LSR A           ; Shift console switches right
F300   B0 13                BCS LF315       ; If game reset pressed, handle it

; Handle difficulty/speed adjustment
F302   A4 F2                LDY $F2         ; Load current difficulty level
F304   D0 08                BNE LF30E       ; If not zero, skip increment
F306   A6 EA                LDX $EA         ; Load speed counter
F308   E8                   INX             ; Increment speed
F309   8A                   TXA             ; Transfer to A
F30A   29 07                AND #$07        ; Mask to 0-7 range
F30C   85 EA                STA $EA         ; Store new speed

F30E   C0 1E      LF30E     CPY #$1E        ; Compare difficulty with 30
F310   90 02                BCC LF314       ; If less than 30, increment
F312   A0 FF                LDY #$FF        ; Reset to -1 (will become 0)
F314   C8         LF314     INY             ; Increment difficulty level
F315   84 F2      LF315     STY $F2         ; Store new difficulty

; ===== AI MOVE CALCULATION AND VALIDATION =====
F317   A4 F3                LDY $F3         ; Load current move state
F319   88                   DEY             ; Decrement move counter
F31A   30 40                BMI LF35C       ; If negative, exit (no moves)
F31C   A4 F4                LDY $F4         ; Load move timer
F31E   F0 3C                BEQ LF35C       ; If zero, exit
F320   C0 20                CPY #$20        ; Compare with 32
F322   90 39                BCC LF35D       ; If less than 32, continue processing

; Reset move timer if too high
F324   A9 20                LDA #$20        ; Load 32
F326   85 F4                STA $F4         ; Reset move timer
F328   A9 FF                LDA #$FF        ; Load -1
F32A   85 E3                STA $E3         ; Set move flag

; Check for castling move
F32C   A0 09                LDY #$09        ; Load 9 (king piece type)
F32E   C4 D6                CPY $D6         ; Compare with current piece
F330   D0 22                BNE LF354       ; If not king, skip castling check

F332   A6 D4                LDX $D4         ; Load source square
F334   24 83                BIT $83         ; Test board state
F336   70 1C                BVS LF354       ; If overflow set, skip castling

; Check rook positions for castling
F338   A5 86                LDA $86         ; Load kingside rook position
F33A   05 8A                ORA $8A         ; OR with another rook position
F33C   0A                   ASL A           ; Shift left
F33D   30 06                BMI LF345       ; If negative, check queenside

; Kingside castling check
F33F   CA                   DEX             ; Decrement source square
F340   CA                   DEX             ; Decrement again (two squares)
F341   E4 D5                CPX $D5         ; Compare with destination
F343   F0 74                BEQ LF3B9       ; If equal, execute castling

; Queenside castling check
F345   A5 87      LF345     LDA $87         ; Load queenside rook position
F347   05 8B                ORA $8B         ; OR with another rook position
F349   0A                   ASL A           ; Shift left
F34A   30 08                BMI LF354       ; If negative, skip
F34C   A6 D4                LDX $D4         ; Load source square
F34E   E8                   INX             ; Increment source square
F34F   E8                   INX             ; Increment again (two squares)
F350   E4 D5                CPX $D5         ; Compare with destination
F352   F0 65                BEQ LF3B9       ; If equal, execute castling

; Continue with normal move processing
F354   E6 D4      LF354     INC $D4         ; Increment source square
F356   A0 FE      LF356     LDY #$FE        ; Load -2
F358   84 D8                STY $D8         ; Store in move state
F35A   84 D6                STY $D6         ; Store in piece type
F35C   60         LF35C     RTS             ; Return from subroutine

; ===== MOVE EXECUTION AND VALIDATION =====
F35D   A5 D4      LF35D     LDA $D4         ; Load source square
F35F   30 FB                BMI LF35C       ; If negative, exit
F361   A6 DA                LDX $DA         ; Load destination square
F363   A4 D9                LDY $D9         ; Load current position
F365   A5 E3                LDA $E3         ; Load move flags
F367   30 10                BMI LF379       ; If negative, handle special move

; Normal move processing
F369   A6 F7                LDX $F7         ; Load AI move choice
F36B   8A                   TXA             ; Transfer to A
F36C   30 51                BMI LF3BF       ; If negative, handle differently
F36E   A4 DA                LDY $DA         ; Load destination
F370   20 62 FE             JSR LFE62       ; Call move validation routine
F373   A6 D9                LDX $D9         ; Load current position
F375   C4 F7                CPY $F7         ; Compare with AI choice
F377   F0 0A                BEQ LF383       ; If equal, execute move

; Execute piece movement
F379   B9 80 00   LF379     LDA $0080,Y     ; Load piece at destination
F37C   29 F0                AND #$F0        ; Mask upper nibble (piece type)
F37E   05 DB                ORA $DB         ; OR with moving piece
F380   99 80 00             STA $0080,Y     ; Store piece at destination

F383   20 62 FE   LF383     JSR LFE62       ; Call piece placement routine
F386   20 95 FA             JSR LFA95       ; Call board update routine
F389   A4 E3                LDY $E3         ; Load move flags
F38B   10 36                BPL LF3C3       ; If positive, continue

; Validate move legality
F38D   A5 D4                LDA $D4         ; Load source square
F38F   C5 D9                CMP $D9         ; Compare with current position
F391   D0 24                BNE LF3B7       ; If different, invalid move
F393   A5 D5                LDA $D5         ; Load destination square
F395   C5 DA                CMP $DA         ; Compare with target
F397   D0 4D                BNE LF3E6       ; If different, invalid move

; Special piece movement validation
F399   A6 D6                LDX $D6         ; Load piece type
F39B   E0 06                CPX #$06        ; Compare with 6 (king)
F39D   D0 12                BNE LF3B1       ; If not king, check other pieces
F39F   A6 D8                LDX $D8         ; Load move distance
F3A1   E0 08                CPX #$08        ; Compare with 8
F3A3   B0 14                BCS LF3B9       ; If >= 8, execute move
F3A5   E0 04                CPX #$04        ; Compare with 4
F3A7   A5 DC                LDA $DC         ; Load captured piece
F3A9   B0 04                BCS LF3AF       ; If >= 4, check capture
F3AB   D0 0A                BNE LF3B7       ; If not zero, invalid
F3AD   F0 0A                BEQ LF3B9       ; If zero, execute move

F3AF   F0 06      LF3AF     BEQ LF3B7       ; If zero, invalid move
F3B1   A5 DC      LF3B1     LDA $DC         ; Load captured piece
F3B3   C9 07                CMP #$07        ; Compare with 7
F3B5   90 02                BCC LF3B9       ; If less than 7, execute move
F3B7   84 F5      LF3B7     STY $F5         ; Store invalid move flag

; Execute valid move
F3B9   A0 01      LF3B9     LDY #$01        ; Load 1
F3BB   84 E3                STY $E3         ; Set move executed flag
F3BD   A9 40                LDA #$40        ; Load 64
F3BF   85 D4      LF3BF     STA $D4         ; Store in source square
F3C1   D0 93                BNE LF356       ; Branch to continue processing

; Handle AI move selection
F3C3   A6 F7      LF3C3     LDX $F7         ; Load AI move choice
F3C5   30 05                BMI LF3CC       ; If negative, skip
F3C7   A9 09                LDA #$09        ; Load 9 (piece value)
F3C9   20 64 FE             JSR LFE64       ; Call piece evaluation routine

F3CC   E4 D5      LF3CC     CPX $D5         ; Compare with destination
F3CE   D0 16                BNE LF3E6       ; If different, exit
F3D0   A4 D8                LDY $D8         ; Load move distance
F3D2   30 12                BMI LF3E6       ; If negative, exit
F3D4   A9 06                LDA #$06        ; Load 6 (king piece type)
F3D6   C5 D6                CMP $D6         ; Compare with current piece
F3D8   D0 04                BNE LF3DE       ; If not king, continue
F3DA   C0 04                CPY #$04        ; Compare distance with 4
F3DC   90 08                BCC LF3E6       ; If less than 4, exit

; Finalize move
F3DE   A0 FE      LF3DE     LDY #$FE        ; Load -2
F3E0   84 F5                STY $F5         ; Store move completion flag
F3E2   84 F6                STY $F6         ; Store in another flag
F3E4   84 D4                STY $D4         ; Store in source square
F3E6   60         LF3E6     RTS             ; Return from subroutine
; ATARI VIDEO CHESS ROM DUMP - ANNOTATED
; Part 6: Board Evaluation and Piece Movement Logic

; ===== BOARD EVALUATION AND GAME STATE ANALYSIS =====
F3E7   20 3C F5             JSR LF53C       ; Call game state check routine
F3EA   A5 F3                LDA $F3         ; Load current move state
F3EC   F0 07                BEQ LF3F5       ; If zero, skip piece evaluation
F3EE   A6 DA                LDX $DA         ; Load destination square
F3F0   A5 DC                LDA $DC         ; Load captured piece value
F3F2   20 64 FE             JSR LFE64       ; Call piece value routine

F3F5   A6 D9      LF3F5     LDX $D9         ; Load current position
F3F7   A5 DB                LDA $DB         ; Load moving piece value
F3F9   20 64 FE             JSR LFE64       ; Call piece value routine
F3FC   A6 F7                LDX $F7         ; Load AI evaluation
F3FE   30 05                BMI LF405       ; If negative, skip
F400   A9 09                LDA #$09        ; Load 9 (high piece value)
F402   20 64 FE             JSR LFE64       ; Call piece value routine

; Handle move timing and animation
F405   A4 F4      LF405     LDY $F4         ; Load move timer
F407   F0 13                BEQ LF41C       ; If zero, process move
F409   C6 F4                DEC $F4         ; Decrement move timer
F40B   D0 0E                BNE LF41B       ; If not zero, continue timing
F40D   A6 F3                LDX $F3         ; Load move state
F40F   CA                   DEX             ; Decrement move counter
F410   30 D4                BMI LF3E6       ; If negative, exit
F412   A5 D4                LDA $D4         ; Load source square
F414   10 03                BPL LF419       ; If positive, continue
F416   4C DC F1             JMP LF1DC       ; Jump to move execution
F419   84 F4      LF419     STY $F4         ; Reset move timer
F41B   60         LF41B     RTS             ; Return

; ===== COMPUTER MOVE GENERATION =====
F41C   24 F3      LF41C     BIT $F3         ; Test move state
F41E   10 4C                BPL LF46C       ; If positive, handle human move
F420   50 46                BVC LF468       ; If overflow clear, handle differently

; Generate computer move
F422   20 DC F1             JSR LF1DC       ; Call move generation routine
F425   AA                   TAX             ; Transfer result to X
F426   A5 D6                LDA $D6         ; Load piece type
F428   20 64 FE             JSR LFE64       ; Call piece evaluation
F42B   20 91 FD             JSR LFD91       ; Call board analysis routine

; AI move selection based on difficulty
F42E   A4 EA                LDY $EA         ; Load difficulty level
F430   A5 CC                LDA $CC         ; Load evaluation score
F432   24 E2                BIT $E2         ; Test game flags
F434   C9 55                CMP #$55        ; Compare with 85
F436   B0 01                BCS LF439       ; If >= 85, continue
F438   B8                   CLV             ; Clear overflow flag

F439   25 E2      LF439     AND $E2         ; AND with game flags
F43B   25 CA                AND $CA         ; AND with another flag
F43D   08                   PHP             ; Push processor status
F43E   68                   PLA             ; Pull processor status
F43F   85 E2                STA $E2         ; Store flags

; Generate move based on difficulty and position
F441   B9 F5 FF             LDA $FFF5,Y     ; Load from difficulty table
F444   B0 02                BCS LF448       ; If carry set, add bonus
F446   69 12                ADC #$12        ; Add 18 to move value
F448   24 E2      LF448     BIT $E2         ; Test game flags
F44A   50 02                BVC LF44E       ; If overflow clear, continue
F44C   A9 12                LDA #$12        ; Load 18 (default move value)
F44E   30 02      LF44E     BMI LF452       ; If negative, continue
F450   69 10                ADC #$10        ; Add 16 to move value

; Calculate final move coordinates
F452   A8         LF452     TAY             ; Transfer to Y
F453   29 0F                AND #$0F        ; Mask lower nibble (file)
F455   85 D2                STA $D2         ; Store file coordinate
F457   98                   TYA             ; Transfer back to A
F458   4A                   LSR A           ; Shift right
F459   4A                   LSR A           ; Shift right
F45A   4A                   LSR A           ; Shift right
F45B   4A                   LSR A           ; Shift right (get rank)
F45C   85 D9                STA $D9         ; Store rank coordinate

; Clean up and execute move
F45E   68                   PLA             ; Pull from stack
F45F   68                   PLA             ; Pull from stack
F460   26 B7                ROL $B7         ; Rotate board state
F462   18                   CLC             ; Clear carry
F463   66 B7                ROR $B7         ; Rotate back with carry clear
F465   4C 74 F5             JMP LF574       ; Jump to move execution

; Handle different move types
F468   A6 D4      LF468     LDX $D4         ; Load source square
F46A   86 D8                STX $D8         ; Store in move distance

; ===== HUMAN INPUT PROCESSING =====
F46C   A5 3C      LF46C     LDA $3C         ; Read joystick input
F46E   AA                   TAX             ; Transfer to X
F46F   45 E6                EOR $E6         ; XOR with previous input
F471   25 E6                AND $E6         ; AND with previous input
F473   86 E6                STX $E6         ; Store new input state
F475   10 5F                BPL LF4D6       ; If positive, process input

; Handle button press
F477   A9 04                LDA #$04        ; Load 4 (button press value)
F479   20 E6 F1             JSR LF1E6       ; Call input processing routine
F47C   2C 82 02             BIT $0282       ; Test console switches
F47F   A5 D6                LDA $D6         ; Load piece type
F481   70 14                BVS LF497       ; If overflow set, handle special

; Process piece selection
F483   AA                   TAX             ; Transfer piece type to X
F484   A5 F3                LDA $F3         ; Load move state
F486   D0 36                BNE LF4BE       ; If not zero, handle move
F488   E0 09                CPX #$09        ; Compare with 9
F48A   90 4A                BCC LF4D6       ; If less than 9, continue input
F48C   85 D7                STA $D7         ; Clear destination
F48E   A5 D8                LDA $D8         ; Load move distance
F490   85 D5                STA $D5         ; Store as destination
F492   E6 F3                INC $F3         ; Increment move state
F494   60                   RTS             ; Return

; Handle piece type cycling
F495   E6 E4      LF495     INC $E4         ; Increment piece counter
F497   18         LF497     CLC             ; Clear carry
F498   69 01                ADC #$01        ; Add 1 to piece type
F49A   C9 08                CMP #$08        ; Compare with 8
F49C   F0 F9                BEQ LF497       ; If equal, try again
F49E   C9 07                CMP #$07        ; Compare with 7
F4A0   F0 F5                BEQ LF497       ; If equal, try again
F4A2   C9 0F                CMP #$0F        ; Compare with 15
F4A4   F0 EF                BEQ LF495       ; If equal, increment counter
F4A6   29 0F                AND #$0F        ; Mask to piece type
F4A8   85 D6                STA $D6         ; Store piece type

; Set up piece placement
F4AA   A2 C0                LDX #$C0        ; Load 192
F4AC   86 E2                STX $E2         ; Store in game flags
F4AE   86 E5                STX $E5         ; Store in move flags
F4B0   A6 D4                LDX $D4         ; Load source square
F4B2   86 D5                STX $D5         ; Store as destination
F4B4   86 D8                STX $D8         ; Store as move distance
F4B6   20 4B FE             JSR LFE4B       ; Call piece setup routine
F4B9   A9 00      LF4B9     LDA #$00        ; Load 0
F4BB   85 F3                STA $F3         ; Clear move state
F4BD   60                   RTS             ; Return

; Handle move completion
F4BE   A5 D4      LF4BE     LDA $D4         ; Load source square
F4C0   C5 D5                CMP $D5         ; Compare with destination
F4C2   F0 F5                BEQ LF4B9       ; If equal, clear move
F4C4   A5 F5                LDA $F5         ; Load move validation flag
F4C6   F0 05                BEQ LF4CD       ; If zero, execute move
F4C8   A9 0F                LDA #$0F        ; Load 15 (error indicator)
F4CA   85 E7                STA $E7         ; Store error flag
F4CC   60                   RTS             ; Return

; Execute the move
F4CD   A9 C0      LF4CD     LDA #$C0        ; Load 192
F4CF   85 F3                STA $F3         ; Set move state
F4D1   85 F4                STA $F4         ; Set move timer
F4D3   4C 3E F1             JMP LF13E       ; Jump to move execution routine
; ATARI VIDEO CHESS ROM DUMP - ANNOTATED
; Part 7: Lookup Tables, Data, and Utility Routines

; ===== JOYSTICK INPUT PROCESSING =====
F4D6   AD 80 02             LDA $0280       ; Read joystick input (SWCHA)
F4D9   C9 F0                CMP #$F0        ; Compare with no input
F4DB   B0 5E                BCS LF53B       ; If no input, exit
F4DD   24 ED                BIT $ED         ; Test console switches
F4DF   10 02                BPL LF4E3       ; If positive, continue
F4E1   49 C0                EOR #$C0        ; Flip direction bits

F4E3   85 E9      LF4E3     STA $E9         ; Store processed input
F4E5   20 E6 F1             JSR LF1E6       ; Call input handler
F4E8   A5 D8                LDA $D8         ; Load current position
F4EA   A2 03                LDX #$03        ; Load 3 (for 4 directions)

; Process directional input
F4EC   06 E9      LF4EC     ASL $E9         ; Shift input left
F4EE   B0 03                BCS LF4F3       ; If carry set, skip addition
F4F0   7D 7E FF             ADC $FF7E,X     ; Add direction offset from table
F4F3   CA         LF4F3     DEX             ; Decrement direction counter
F4F4   10 F6                BPL LF4EC       ; Continue for all directions
F4F6   29 3F                AND #$3F        ; Mask to valid board range
F4F8   A6 D8                LDX $D8         ; Load previous position
F4FA   85 D8                STA $D8         ; Store new position
F4FC   A8                   TAY             ; Transfer to Y
F4FD   A5 F3                LDA $F3         ; Load move state
F4FF   4A                   LSR A           ; Shift right
F500   B5 80                LDA $80,X       ; Load piece at old position
F502   29 F0                AND #$F0        ; Mask upper nibble
F504   B0 08                BCS LF50E       ; If carry set, handle differently

; Update piece position
F506   84 D4                STY $D4         ; Store new position as source
F508   05 D6                ORA $D6         ; OR with piece type
F50A   95 80                STA $80,X       ; Store piece at old position
F50C   90 0B                BCC LF519       ; If carry clear, continue

F50E   05 D7      LF50E     ORA $D7         ; OR with destination info
F510   84 D5                STY $D5         ; Store new position as destination
F512   95 80                STA $80,X       ; Store piece
F514   98                   TYA             ; Transfer Y to A
F515   45 D4                EOR $D4         ; XOR with source
F517   F0 09                BEQ LF522       ; If equal, continue

; Update board with piece movement
F519   B9 80 00   LF519     LDA $0080,Y     ; Load piece at new position
F51C   29 0F                AND #$0F        ; Mask lower nibble
F51E   B0 02                BCS LF522       ; If carry set, continue
F520   85 D6      LF520     STA $D6         ; Store piece type
F522   85 D7      LF522     STA $D7         ; Store in destination

; ===== GAME INITIALIZATION AND RESET =====
F524   A2 00      LF524     LDX #$00        ; Load 0
F526   86 F1                STX $F1         ; Clear timer high byte
F528   86 F0                STX $F0         ; Clear timer low byte
F52A   A9 20                LDA #$20        ; Load 32
F52C   85 F4                STA $F4         ; Set move timer
F52E   86 F5                STX $F5         ; Clear move flags
F530   86 F6                STX $F6         ; Clear another flag

; Copy game state
F532   A2 05      LF532     LDX #$05        ; Load 5 (for 6 bytes)
F534   B5 D3      LF534     LDA $D3,X       ; Load from source
F536   95 D8                STA $D8,X       ; Store in destination
F538   CA                   DEX             ; Decrement counter
F539   D0 F9                BNE LF534       ; Continue until all copied
F53B   60         LF53B     RTS             ; Return

; Game state validation
F53C   A6 F4      LF53C     LDX $F4         ; Load move timer
F53E   D0 04                BNE LF544       ; If not zero, exit
F540   A6 D4                LDX $D4         ; Load source square
F542   10 EE                BPL LF532       ; If positive, copy state
F544   60         LF544     RTS             ; Return

; ===== BOARD FLIP AND DISPLAY SETUP =====
F545   24 ED      LF545     BIT $ED         ; Test console switches (stored copy of SWCHB)
F547   8C 96 02             STY $0296       ; Store in TIA register
F54A   10 27                BPL LF573       ; If bit 7 clear (RIGHT DIFF = B), skip board flip

; Flip board for player perspective
F54C   A2 3F                LDX #$3F        ; Load 63 (for 64 squares)
F54E   8A         LF54E     TXA             ; Transfer X to A
F54F   49 07                EOR #$07        ; XOR with 7 (flip file)
F551   A8                   TAY             ; Transfer to Y
F552   B9 80 00             LDA $0080,Y     ; Load piece from flipped position
F555   29 0F                AND #$0F        ; Mask lower nibble
F557   85 F8                STA $F8         ; Store piece type
F559   B5 80                LDA $80,X       ; Load piece from current position
F55B   29 0F                AND #$0F        ; Mask lower nibble
F55D   85 F9                STA $F9         ; Store piece type
F55F   55 80                EOR $80,X       ; XOR with current piece
F561   05 F8                ORA $F8         ; OR with flipped piece
F563   95 80                STA $80,X       ; Store result
F565   B9 80 00             LDA $0080,Y     ; Load from flipped position
F568   29 F0                AND #$F0        ; Mask upper nibble
F56A   05 F9                ORA $F9         ; OR with piece type
F56C   99 80 00             STA $0080,Y     ; Store at flipped position
F56F   CA                   DEX             ; Decrement counter
F570   CA                   DEX             ; Decrement again
F571   10 DB                BPL LF54E       ; Continue until all flipped
F573   60         LF573     RTS             ; Return

; ===== GAME RESET AND INITIALIZATION =====
F574   A9 00      LF574     LDA #$00        ; Load 0
F576   85 1D                STA $1D         ; Clear display variable
F578   85 DC                STA $DC         ; Clear captured piece
F57A   85 E1                STA $E1         ; Clear game state
F57C   85 E0                STA $E0         ; Clear another state
F57E   85 D1                STA $D1         ; Clear move counter
F580   85 D0                STA $D0         ; Clear another counter

; Initialize game variables
F582   A2 01      LF582     LDX #$01        ; Load 1
F584   86 DE                STX $DE         ; Set current player
F586   86 C0                STX $C0         ; Set display flag
F588   A9 FF                LDA #$FF        ; Load -1
F58A   86 E3                STX $E3         ; Set move flag
F58C   CA                   DEX             ; Decrement (X = 0)
F58D   86 DA                STX $DA         ; Clear destination
F58F   85 DD                STA $DD         ; Set to -1
F591   85 DF                STA $DF         ; Set to -1
F593   85 CE                STA $CE         ; Set to -1
F595   85 CF                STA $CF         ; Set to -1

; Clear specific board positions
F597   A9 BF                LDA #$BF        ; Load 191
F599   25 80                AND $80         ; AND with board position
F59B   85 80                STA $80         ; Store result
F59D   A9 3F                LDA #$3F        ; Load 63
F59F   25 B8                AND $B8         ; AND with board position
F5A1   85 B8                STA $B8         ; Store result
F5A3   86 D0                STX $D0         ; Clear counter

; Continue game processing...
[Content continues with more game logic and data tables]

; ===== DATA TABLES AND CONSTANTS =====

; Piece movement direction offsets
FF7E   F8                   ; -8 (up one rank)
FF7F   08                   ; +8 (down one rank)  
FF80   FF                   ; -1 (left one file)
FF81   01                   ; +1 (right one file)

; Piece values for evaluation
FED5   00                   ; Empty square
FED6   BE E5 F7             ; Pawn, Knight, Bishop values
FED9   F7 F1 FD             ; Rook, Queen, King values
FEDC   00                   ; Padding

; Piece type lookup table
FEF2   05 04 03 02 01 03 04 05  ; Initial piece setup (back rank)

; Display pattern data
FF6E   08 0A 0E 00          ; Display patterns for different modes

; Sound frequency table
FEE9   00 FF 02             ; Sound frequencies for different events

; Chess piece graphics data (simplified representation)
; Each piece has multiple bytes defining its visual appearance
FEC6   00 5E 85 00 00 75 E4 00  ; Piece graphics data
FECE   44 33 65 FD FF 02 07 00  ; More graphics data

; Board evaluation constants
FEDD   00 42 1B 09 09 0F 03 F8  ; Piece position values

; Movement validation tables
FFF5   02 12 13 23 24 34 56 00  ; Valid move patterns

; Vector table (6507 processor vectors)
FFFA   F0 00                ; NMI vector (not used)
FFFC   F0 00                ; RESET vector -> $F000
FFFE   F0 00                ; IRQ vector (not used)

                            .END

; ===== SUMMARY OF MAJOR ROUTINES =====
; $F000-F00E: System initialization, clear RAM, set stack
; $F00F-F0D8: Main game loop, display sync, input processing  
; $F0D9-F13D: Display buffer setup and graphics generation
; $F13E-F182: Special move handling (castling, en passant)
; $F183-F2A9: Display scanline generation and board rendering
; $F2AA-F2FC: Console switch reading and board initialization
; $F2FF-F3E6: Game select, difficulty, AI move processing
; $F3E7-F4D5: Board evaluation, move validation, timing
; $F4D6-F573: Joystick input processing and board flipping
; $F574-End:  Game reset, data tables, piece graphics

; The ROM implements a complete chess game with:
; - Full chess rules including castling and en passant
; - Multiple difficulty levels
; - Computer AI opponent
; - Joystick control for piece movement
; - Visual board display with piece graphics
; - Sound effects for moves
; - Game state persistence

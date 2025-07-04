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
F2AA   AD 82 02   LF2AA     LDA $0282       ; Read console switches
F2AD   A0 00      LF2AD     LDY #$00        ; Initialize Y to 0
F2AF   4A                   LSR A           ; Shift right (check bit 0)
F2B0   B0 4D                BCS LF2FF       ; If bit set, handle game select

; Initialize chess board to starting position
F2B2   84 E4                STY $E4         ; Clear game difficulty
F2B4   A2 07                LDX #$07        ; Load 7 (for 8 pieces)

; Set up initial piece positions
F2B6   BD F2 FE   LF2B6     LDA $FEF2,X     ; Load piece type from table
F2B9   95 80                STA $80,X       ; Store in board position (white back rank)
F2BB   49 08                EOR #$08        ; Flip color bit
F2BD   95 B8                STA $B8,X       ; Store in board position (black back rank)

; Set up pawns
F2BF   A9 8E                LDA #$8E        ; Load pawn + color bits
F2C1   95 B0                STA $B0,X       ; Store black pawns
F2C3   A9 46                LDA #$46        ; Load pawn + different color
F2C5   95 88                STA $88,X       ; Store white pawns

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

; Handle player color selection
F2DC   24 D3                BIT $D3         ; Test game timer
F2DE   70 01                BVS LF2E1       ; If overflow set, increment
F2E0   E8                   INX             ; Increment X (X = 0)
F2E1   94 8C      LF2E1     STY $8C,X       ; Clear board position
F2E3   95 9C                STA $9C,X       ; Store piece
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

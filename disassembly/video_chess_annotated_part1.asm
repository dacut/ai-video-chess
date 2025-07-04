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
F01B   E6 F1                INC $F1         ; Increment game timer high byte
F01D   D0 02                BNE LF021       ; If no overflow, continue
F01F   85 F0                STA $F0         ; Reset timer if overflow

; Random number generation and display setup
F021   45 F0      LF021     EOR $F0         ; XOR with timer for randomness
F023   09 F7                ORA #$F7        ; Set specific bits
F025   85 E9                STA $E9         ; Store random seed

; Read console switches (difficulty, game select, etc.)
F027   AD 82 02             LDA $0282       ; Read console switches
F02A   29 08                AND #$08        ; Isolate bit 3 (difficulty switch)
F02C   4A                   LSR A           ; Shift right to get 0 or 4
F02D   A8                   TAY             ; Use as index

; Display pattern generation loop
F02E   A2 04                LDX #$04        ; Loop counter for 4 iterations
F030   A5 F1      LF030     LDA $F1         ; Load timer high byte
F032   25 F0                AND $F0         ; AND with timer low byte
F034   59 6E FF             EOR $FF6E,Y     ; XOR with pattern data
F037   25 E9                AND $E9         ; AND with random seed
F039   95 DD                STA $DD,X       ; Store display pattern
F03B   95 05                STA $05,X       ; Also store in zero page
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

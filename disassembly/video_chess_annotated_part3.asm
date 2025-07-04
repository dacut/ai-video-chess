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

; Display pattern generation loop
F190   48                   PHA             ; Push A to stack
F191   CA                   DEX             ; Decrement X
F192   30 31                BMI LF1C5       ; If negative, exit loop
F194   CA         LF194     DEX             ; Decrement X again
F195   B9 80 00             LDA $0080,Y     ; Load from board array
F198   C8                   INY             ; Increment Y
F199   0A                   ASL A           ; Shift left (multiply by 2)
F19A   0A                   ASL A           ; Shift left (multiply by 4)
F19B   0A                   ASL A           ; Shift left (multiply by 8)
F19C   C9 40                CMP #$40        ; Compare with 64
F19E   90 E3                BCC LF183       ; If less, branch with carry clear
F1A0   F0 E2                BEQ LF184       ; If equal, branch with carry set
F1A2   29 38                AND #$38        ; Mask bits
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

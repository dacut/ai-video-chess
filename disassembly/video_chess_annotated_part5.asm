; ATARI VIDEO CHESS ROM DUMP - ANNOTATED
; Part 5: AI Logic and Move Generation

; ===== GAME SELECT AND DIFFICULTY HANDLING =====
F2FF   4A         LF2FF     LSR A           ; Shift console switches right
F300   B0 13                BCS LF315       ; If game select pressed, handle it

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

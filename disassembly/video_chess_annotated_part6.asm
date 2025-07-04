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

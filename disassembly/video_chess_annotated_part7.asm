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
F545   24 ED      LF545     BIT $ED         ; Test console switches
F547   8C 96 02             STY $0296       ; Store in TIA register
F54A   10 27                BPL LF573       ; If positive, skip board flip

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

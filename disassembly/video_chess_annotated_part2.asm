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

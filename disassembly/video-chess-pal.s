                            * = $F000
F000   78                   SEI
F001   D8                   CLD
F002   A2 FF                LDX #$FF
F004   9A                   TXS
F005   E8                   INX
F006   8A                   TXA
F007   95 00      LF007     STA $00,X
F009   E8                   INX
F00A   D0 FB                BNE LF007
F00C   20 AD F2             JSR LF2AD
F00F   A9 FF      LF00F     LDA #$FF
F011   85 02                STA $02
F013   85 00                STA $00
F015   85 01                STA $01
F017   E6 D3                INC $D3
F019   D0 06                BNE LF021
F01B   E6 F1                INC $F1
F01D   D0 02                BNE LF021
F01F   85 F0                STA $F0
F021   45 F0      LF021     EOR $F0
F023   09 F7                ORA #$F7
F025   85 E9                STA $E9
F027   AD 82 02             LDA $0282
F02A   29 08                AND #$08
F02C   4A                   LSR A
F02D   A8                   TAY
F02E   A2 04                LDX #$04
F030   A5 F1      LF030     LDA $F1
F032   25 F0                AND $F0
F034   59 6E FF             EOR $FF6E,Y
F037   25 E9                AND $E9
F039   95 DD                STA $DD,X
F03B   95 05                STA $05,X
F03D   C8                   INY
F03E   CA                   DEX
F03F   D0 EF                BNE LF030
F041   86 06                STX $06
F043   AC 82 02             LDY $0282
F046   84 ED                STY $ED
F048   10 06                BPL LF050
F04A   A4 DF                LDY $DF
F04C   85 DF                STA $DF
F04E   84 DE                STY $DE
F050   A0 24      LF050     LDY #$24
F052   85 02                STA $02
F054   86 00                STX $00
F056   8C 96 02             STY $0296
F059   20 AA F2             JSR LF2AA
F05C   A5 D3                LDA $D3
F05E   29 0C                AND #$0C
F060   C9 04                CMP #$04
F062   20 3C F5             JSR LF53C
F065   A6 D9                LDX $D9
F067   90 0C                BCC LF075
F069   A4 F3                LDY $F3
F06B   30 08                BMI LF075
F06D   A4 DB                LDY $DB
F06F   D0 08                BNE LF079
F071   A4 F3                LDY $F3
F073   D0 04                BNE LF079
F075   A9 08      LF075     LDA #$08
F077   D0 02                BNE LF07B
F079   A5 DB      LF079     LDA $DB
F07B   20 64 FE   LF07B     JSR LFE64
F07E   A6 DA                LDX $DA
F080   B5 80                LDA $80,X
F082   29 F0                AND #$F0
F084   A4 E7                LDY $E7
F086   30 0C                BMI LF094
F088   A4 F3                LDY $F3
F08A   F0 0E                BEQ LF09A
F08C   10 02                BPL LF090
F08E   B0 08                BCS LF098
F090   90 04      LF090     BCC LF096
F092   05 DC                ORA $DC
F094   B0 02      LF094     BCS LF098
F096   05 DB      LF096     ORA $DB
F098   95 80      LF098     STA $80,X
F09A   A5 E7      LF09A     LDA $E7
F09C   F0 0A                BEQ LF0A8
F09E   30 08                BMI LF0A8
F0A0   05 E6                ORA $E6
F0A2   10 04                BPL LF0A8
F0A4   A9 00                LDA #$00
F0A6   85 E7                STA $E7
F0A8   A8         LF0A8     TAY
F0A9   F0 1D                BEQ LF0C8
F0AB   A6 F7                LDX $F7
F0AD   30 0E                BMI LF0BD
F0AF   A5 F6                LDA $F6
F0B1   F0 0A                BEQ LF0BD
F0B3   A9 0F                LDA #$0F
F0B5   B0 03                BCS LF0BA
F0B7   A9 09                LDA #$09
F0B9   A8                   TAY
F0BA   20 64 FE   LF0BA     JSR LFE64
F0BD   A5 EE      LF0BD     LDA $EE
F0BF   2A                   ROL A
F0C0   C9 04                CMP #$04
F0C2   B0 04                BCS LF0C8
F0C4   AA                   TAX
F0C5   BC E9 FE             LDY $FEE9,X
F0C8   84 15      LF0C8     STY $15
F0CA   AD 84 02   LF0CA     LDA $0284
F0CD   D0 FB                BNE LF0CA
F0CF   85 02                STA $02
F0D1   C6 D0                DEC $D0
F0D3   10 04                BPL LF0D9
F0D5   E6 D0                INC $D0
F0D7   85 01                STA $01
F0D9   A2 0F      LF0D9     LDX #$0F
F0DB   86 19                STX $19
F0DD   86 17                STX $17
F0DF   A0 FF                LDY #$FF
F0E1   94 C0      LF0E1     STY $C0,X
F0E3   CA                   DEX
F0E4   95 C0                STA $C0,X
F0E6   CA                   DEX
F0E7   10 F8                BPL LF0E1
F0E9   A0 3C                LDY #$3C
F0EB   20 45 F5             JSR LF545
F0EE   85 2B                STA $2B
F0F0   A5 EA                LDA $EA
F0F2   AE 84 02   LF0F2     LDX $0284
F0F5   D0 FB                BNE LF0F2
F0F7   86 EB                STX $EB
F0F9   85 02                STA $02
F0FB   85 12                STA $12
F0FD   A0 66                LDY #$66
F0FF   84 E8                STY $E8
F101   0A                   ASL A
F102   0A                   ASL A
F103   65 EA                ADC $EA
F105   69 46                ADC #$46
F107   85 CA                STA $CA
F109   A0 04                LDY #$04
F10B   A2 20                LDX #$20
F10D   86 22                STX $22
F10F   A2 02                LDX #$02
F111   86 05                STX $05
F113   85 14                STA $14
F115   85 10                STA $10
F117   A9 D0                LDA #$D0
F119   85 11                STA $11
F11B   85 24                STA $24
F11D   A9 F1                LDA #$F1
F11F   85 21                STA $21
F121   85 25                STA $25
F123   85 02                STA $02
F125   85 2A                STA $2A
F127   85 1D                STA $1D
F129   85 0A                STA $0A
F12B   86 04                STX $04
F12D   A9 38                LDA #$38
F12F   85 C0                STA $C0
F131   A6 EE                LDX $EE
F133   B5 DE                LDA $DE,X
F135   85 F8                STA $F8
F137   A5 DF                LDA $DF
F139   85 FD                STA $FD
F13B   4C CF F1             JMP LF1CF
F13E   A5 D6      LF13E     LDA $D6
F140   A6 D5                LDX $D5
F142   29 07                AND #$07
F144   C9 06                CMP #$06
F146   D0 1B                BNE LF163
F148   A5 E5                LDA $E5
F14A   49 10                EOR #$10
F14C   A8                   TAY
F14D   49 08                EOR #$08
F14F   C5 D5                CMP $D5
F151   F0 2C                BEQ LF17F
F153   E0 08                CPX #$08
F155   90 04                BCC LF15B
F157   E0 38                CPX #$38
F159   90 27                BCC LF182
F15B   A5 D6      LF15B     LDA $D6
F15D   49 04                EOR #$04
F15F   85 D6                STA $D6
F161   B0 1F                BCS LF182
F163   C9 01      LF163     CMP #$01
F165   D0 1B                BNE LF182
F167   A5 D4                LDA $D4
F169   29 38                AND #$38
F16B   A8                   TAY
F16C   8A                   TXA
F16D   E5 D4                SBC $D4
F16F   C9 FE                CMP #$FE
F171   D0 03                BNE LF176
F173   E8                   INX
F174   B0 09                BCS LF17F
F176   C9 02      LF176     CMP #$02
F178   D0 08                BNE LF182
F17A   CA                   DEX
F17B   98                   TYA
F17C   09 07                ORA #$07
F17E   A8                   TAY
F17F   20 37 FD   LF17F     JSR LFD37
F182   60         LF182     RTS
F183   38         LF183     SEC
F184   95 C0      LF184     STA $C0,X
F186   A5 DE                LDA $DE
F188   B0 1F                BCS LF1A9
F18A   95 C0      LF18A     STA $C0,X
F18C   A5 DE                LDA $DE
F18E   90 31                BCC LF1C1
F190   48                   PHA
F191   CA                   DEX
F192   30 31                BMI LF1C5
F194   CA         LF194     DEX
F195   B9 80 00             LDA $0080,Y
F198   C8                   INY
F199   0A                   ASL A
F19A   0A                   ASL A
F19B   0A                   ASL A
F19C   C9 40                CMP #$40
F19E   90 E3                BCC LF183
F1A0   F0 E2                BEQ LF184
F1A2   29 38                AND #$38
F1A4   EA                   NOP
F1A5   95 C0                STA $C0,X
F1A7   A5 DF                LDA $DF
F1A9   48         LF1A9     PHA
F1AA   CA                   DEX
F1AB   CA                   DEX
F1AC   B9 80 00             LDA $0080,Y
F1AF   C8                   INY
F1B0   85 2A                STA $2A
F1B2   0A                   ASL A
F1B3   0A                   ASL A
F1B4   0A                   ASL A
F1B5   C9 40                CMP #$40
F1B7   90 D1                BCC LF18A
F1B9   F0 CF                BEQ LF18A
F1BB   29 38                AND #$38
F1BD   95 C0                STA $C0,X
F1BF   A5 DF                LDA $DF
F1C1   48         LF1C1     PHA
F1C2   CA                   DEX
F1C3   10 CF                BPL LF194
F1C5   84 EB      LF1C5     STY $EB
F1C7   9A                   TXS
F1C8   A0 05                LDY #$05
F1CA   B1 CC                LDA ($CC),Y
F1CC   4A                   LSR A
F1CD   85 1B                STA $1B
F1CF   A5 FE      LF1CF     LDA $FE
F1D1   85 06                STA $06
F1D3   85 2B                STA $2B
F1D5   85 02                STA $02
F1D7   85 2A                STA $2A
F1D9   4C 09 F2             JMP LF209
F1DC   A2 04      LF1DC     LDX #$04
F1DE   B5 D9      LF1DE     LDA $D9,X
F1E0   95 D4                STA $D4,X
F1E2   CA                   DEX
F1E3   10 F9                BPL LF1DE
F1E5   60                   RTS
F1E6   85 15      LF1E6     STA $15
F1E8   A5 E7                LDA $E7
F1EA   10 0F                BPL LF1FB
F1EC   84 F3                STY $F3
F1EE   A5 EE                LDA $EE
F1F0   F0 09                BEQ LF1FB
F1F2   A6 DA                LDX $DA
F1F4   A5 D6                LDA $D6
F1F6   20 64 FE             JSR LFE64
F1F9   84 D6                STY $D6
F1FB   84 E7      LF1FB     STY $E7
F1FD   60                   RTS
F1FE   B1 CC      LF1FE     LDA ($CC),Y
F200   4A                   LSR A
F201   85 1B                STA $1B
F203   A5 FE                LDA $FE
F205   85 2A                STA $2A
F207   85 06                STA $06
F209   B1 C8      LF209     LDA ($C8),Y
F20B   4A                   LSR A
F20C   85 1C                STA $1C
F20E   A5 FC                LDA $FC
F210   8D 07 00             STA $0007
F213   B1 C4                LDA ($C4),Y
F215   4A                   LSR A
F216   85 1B                STA $1B
F218   B1 C0                LDA ($C0),Y
F21A   4A                   LSR A
F21B   A6 FA                LDX $FA
F21D   86 06                STX $06
F21F   85 1C                STA $1C
F221   A6 F8                LDX $F8
F223   86 07                STX $07
F225   A9 70                LDA #$70
F227   85 20                STA $20
F229   85 21                STA $21
F22B   A5 FF                LDA $FF
F22D   85 06                STA $06
F22F   A6 FB                LDX $FB
F231   85 02                STA $02
F233   85 2A                STA $2A
F235   B1 CE                LDA ($CE),Y
F237   85 1B                STA $1B
F239   B1 CA                LDA ($CA),Y
F23B   85 1C                STA $1C
F23D   A5 FD                LDA $FD
F23F   85 07                STA $07
F241   B1 C6                LDA ($C6),Y
F243   85 1B                STA $1B
F245   B1 C2                LDA ($C2),Y
F247   86 06                STX $06
F249   A6 F9                LDX $F9
F24B   85 1C                STA $1C
F24D   86 07                STX $07
F24F   A9 90                LDA #$90
F251   85 20                STA $20
F253   85 21                STA $21
F255   88                   DEY
F256   10 A6                BPL LF1FE
F258   C8                   INY
F259   84 1B                STY $1B
F25B   84 1C                STY $1C
F25D   84 0F                STY $0F
F25F   84 06                STY $06
F261   85 2A                STA $2A
F263   98                   TYA
F264   A4 EB                LDY $EB
F266   C0 40                CPY #$40
F268   B0 11                BCS LF27B
F26A   A5 E8                LDA $E8
F26C   85 1F                STA $1F
F26E   49 FE                EOR #$FE
F270   85 E8                STA $E8
F272   85 0F                STA $0F
F274   A2 0F                LDX #$0F
F276   85 2B                STA $2B
F278   4C 94 F1             JMP LF194
F27B   A0 3F      LF27B     LDY #$3F
F27D   84 04                STY $04
F27F   84 1D                STY $1D
F281   A0 5D                LDY #$5D
F283   20 45 F5             JSR LF545
F286   20 E7 F3             JSR LF3E7
F289   A9 09                LDA #$09
F28B   85 CC                STA $CC
F28D   20 7D FE             JSR LFE7D
F290   E4 D9                CPX $D9
F292   D0 06                BNE LF29A
F294   A5 F3                LDA $F3
F296   F0 02                BEQ LF29A
F298   A6 DD                LDX $DD
F29A   86 F7      LF29A     STX $F7
F29C   A5 E2                LDA $E2
F29E   08                   PHP
F29F   68                   PLA
F2A0   85 E2                STA $E2
F2A2   AD 84 02   LF2A2     LDA $0284
F2A5   D0 FB                BNE LF2A2
F2A7   4C 0F F0             JMP LF00F
F2AA   AD 82 02   LF2AA     LDA $0282
F2AD   A0 00      LF2AD     LDY #$00
F2AF   4A                   LSR A
F2B0   B0 4D                BCS LF2FF
F2B2   84 E4                STY $E4
F2B4   A2 07                LDX #$07
F2B6   BD F2 FE   LF2B6     LDA $FEF2,X
F2B9   95 80                STA $80,X
F2BB   49 08                EOR #$08
F2BD   95 B8                STA $B8,X
F2BF   A9 8E                LDA #$8E
F2C1   95 B0                STA $B0,X
F2C3   A9 46                LDA #$46
F2C5   95 88                STA $88,X
F2C7   94 90                STY $90,X
F2C9   94 98                STY $98,X
F2CB   94 A0                STY $A0,X
F2CD   94 A8                STY $A8,X
F2CF   CA                   DEX
F2D0   10 E4                BPL LF2B6
F2D2   86 E2                STX $E2
F2D4   86 F7                STX $F7
F2D6   86 E5                STX $E5
F2D8   24 ED                BIT $ED
F2DA   10 10                BPL LF2EC
F2DC   24 D3                BIT $D3
F2DE   70 01                BVS LF2E1
F2E0   E8                   INX
F2E1   94 8C      LF2E1     STY $8C,X
F2E3   95 9C                STA $9C,X
F2E5   06 B9                ASL $B9
F2E7   38                   SEC
F2E8   66 B9                ROR $B9
F2EA   E6 E4                INC $E4
F2EC   84 F3      LF2EC     STY $F3
F2EE   84 E7                STY $E7
F2F0   A2 03                LDX #$03
F2F2   86 EE                STX $EE
F2F4   4A                   LSR A
F2F5   85 D5                STA $D5
F2F7   85 D4                STA $D4
F2F9   85 D8                STA $D8
F2FB   98                   TYA
F2FC   4C 20 F5             JMP LF520
F2FF   4A         LF2FF     LSR A
F300   B0 13                BCS LF315
F302   A4 F2                LDY $F2
F304   D0 08                BNE LF30E
F306   A6 EA                LDX $EA
F308   E8                   INX
F309   8A                   TXA
F30A   29 07                AND #$07
F30C   85 EA                STA $EA
F30E   C0 1E      LF30E     CPY #$1E
F310   90 02                BCC LF314
F312   A0 FF                LDY #$FF
F314   C8         LF314     INY
F315   84 F2      LF315     STY $F2
F317   A4 F3                LDY $F3
F319   88                   DEY
F31A   30 40                BMI LF35C
F31C   A4 F4                LDY $F4
F31E   F0 3C                BEQ LF35C
F320   C0 20                CPY #$20
F322   90 39                BCC LF35D
F324   A9 20                LDA #$20
F326   85 F4                STA $F4
F328   A9 FF                LDA #$FF
F32A   85 E3                STA $E3
F32C   A0 09                LDY #$09
F32E   C4 D6                CPY $D6
F330   D0 22                BNE LF354
F332   A6 D4                LDX $D4
F334   24 83                BIT $83
F336   70 1C                BVS LF354
F338   A5 86                LDA $86
F33A   05 8A                ORA $8A
F33C   0A                   ASL A
F33D   30 06                BMI LF345
F33F   CA                   DEX
F340   CA                   DEX
F341   E4 D5                CPX $D5
F343   F0 74                BEQ LF3B9
F345   A5 87      LF345     LDA $87
F347   05 8B                ORA $8B
F349   0A                   ASL A
F34A   30 08                BMI LF354
F34C   A6 D4                LDX $D4
F34E   E8                   INX
F34F   E8                   INX
F350   E4 D5                CPX $D5
F352   F0 65                BEQ LF3B9
F354   E6 D4      LF354     INC $D4
F356   A0 FE      LF356     LDY #$FE
F358   84 D8                STY $D8
F35A   84 D6                STY $D6
F35C   60         LF35C     RTS
F35D   A5 D4      LF35D     LDA $D4
F35F   30 FB                BMI LF35C
F361   A6 DA                LDX $DA
F363   A4 D9                LDY $D9
F365   A5 E3                LDA $E3
F367   30 10                BMI LF379
F369   A6 F7                LDX $F7
F36B   8A                   TXA
F36C   30 51                BMI LF3BF
F36E   A4 DA                LDY $DA
F370   20 62 FE             JSR LFE62
F373   A6 D9                LDX $D9
F375   C4 F7                CPY $F7
F377   F0 0A                BEQ LF383
F379   B9 80 00   LF379     LDA $0080,Y
F37C   29 F0                AND #$F0
F37E   05 DB                ORA $DB
F380   99 80 00             STA $0080,Y
F383   20 62 FE   LF383     JSR LFE62
F386   20 95 FA             JSR LFA95
F389   A4 E3                LDY $E3
F38B   10 36                BPL LF3C3
F38D   A5 D4                LDA $D4
F38F   C5 D9                CMP $D9
F391   D0 24                BNE LF3B7
F393   A5 D5                LDA $D5
F395   C5 DA                CMP $DA
F397   D0 4D                BNE LF3E6
F399   A6 D6                LDX $D6
F39B   E0 06                CPX #$06
F39D   D0 12                BNE LF3B1
F39F   A6 D8                LDX $D8
F3A1   E0 08                CPX #$08
F3A3   B0 14                BCS LF3B9
F3A5   E0 04                CPX #$04
F3A7   A5 DC                LDA $DC
F3A9   B0 04                BCS LF3AF
F3AB   D0 0A                BNE LF3B7
F3AD   F0 0A                BEQ LF3B9
F3AF   F0 06      LF3AF     BEQ LF3B7
F3B1   A5 DC      LF3B1     LDA $DC
F3B3   C9 07                CMP #$07
F3B5   90 02                BCC LF3B9
F3B7   84 F5      LF3B7     STY $F5
F3B9   A0 01      LF3B9     LDY #$01
F3BB   84 E3                STY $E3
F3BD   A9 40                LDA #$40
F3BF   85 D4      LF3BF     STA $D4
F3C1   D0 93                BNE LF356
F3C3   A6 F7      LF3C3     LDX $F7
F3C5   30 05                BMI LF3CC
F3C7   A9 09                LDA #$09
F3C9   20 64 FE             JSR LFE64
F3CC   E4 D5      LF3CC     CPX $D5
F3CE   D0 16                BNE LF3E6
F3D0   A4 D8                LDY $D8
F3D2   30 12                BMI LF3E6
F3D4   A9 06                LDA #$06
F3D6   C5 D6                CMP $D6
F3D8   D0 04                BNE LF3DE
F3DA   C0 04                CPY #$04
F3DC   90 08                BCC LF3E6
F3DE   A0 FE      LF3DE     LDY #$FE
F3E0   84 F5                STY $F5
F3E2   84 F6                STY $F6
F3E4   84 D4                STY $D4
F3E6   60         LF3E6     RTS
F3E7   20 3C F5   LF3E7     JSR LF53C
F3EA   A5 F3                LDA $F3
F3EC   F0 07                BEQ LF3F5
F3EE   A6 DA                LDX $DA
F3F0   A5 DC                LDA $DC
F3F2   20 64 FE             JSR LFE64
F3F5   A6 D9      LF3F5     LDX $D9
F3F7   A5 DB                LDA $DB
F3F9   20 64 FE             JSR LFE64
F3FC   A6 F7                LDX $F7
F3FE   30 05                BMI LF405
F400   A9 09                LDA #$09
F402   20 64 FE             JSR LFE64
F405   A4 F4      LF405     LDY $F4
F407   F0 13                BEQ LF41C
F409   C6 F4                DEC $F4
F40B   D0 0E                BNE LF41B
F40D   A6 F3                LDX $F3
F40F   CA                   DEX
F410   30 D4                BMI LF3E6
F412   A5 D4                LDA $D4
F414   10 03                BPL LF419
F416   4C DC F1             JMP LF1DC
F419   84 F4      LF419     STY $F4
F41B   60         LF41B     RTS
F41C   24 F3      LF41C     BIT $F3
F41E   10 4C                BPL LF46C
F420   50 46                BVC LF468
F422   20 DC F1             JSR LF1DC
F425   AA                   TAX
F426   A5 D6                LDA $D6
F428   20 64 FE             JSR LFE64
F42B   20 91 FD             JSR LFD91
F42E   A4 EA                LDY $EA
F430   A5 CC                LDA $CC
F432   24 E2                BIT $E2
F434   C9 55                CMP #$55
F436   B0 01                BCS LF439
F438   B8                   CLV
F439   25 E2      LF439     AND $E2
F43B   25 CA                AND $CA
F43D   08                   PHP
F43E   68                   PLA
F43F   85 E2                STA $E2
F441   B9 F5 FF             LDA $FFF5,Y
F444   B0 02                BCS LF448
F446   69 12                ADC #$12
F448   24 E2      LF448     BIT $E2
F44A   50 02                BVC LF44E
F44C   A9 12                LDA #$12
F44E   30 02      LF44E     BMI LF452
F450   69 10                ADC #$10
F452   A8         LF452     TAY
F453   29 0F                AND #$0F
F455   85 D2                STA $D2
F457   98                   TYA
F458   4A                   LSR A
F459   4A                   LSR A
F45A   4A                   LSR A
F45B   4A                   LSR A
F45C   85 D9                STA $D9
F45E   68                   PLA
F45F   68                   PLA
F460   26 B7                ROL $B7
F462   18                   CLC
F463   66 B7                ROR $B7
F465   4C 74 F5             JMP LF574
F468   A6 D4      LF468     LDX $D4
F46A   86 D8                STX $D8
F46C   A5 3C      LF46C     LDA $3C
F46E   AA                   TAX
F46F   45 E6                EOR $E6
F471   25 E6                AND $E6
F473   86 E6                STX $E6
F475   10 5F                BPL LF4D6
F477   A9 04                LDA #$04
F479   20 E6 F1             JSR LF1E6
F47C   2C 82 02             BIT $0282
F47F   A5 D6                LDA $D6
F481   70 14                BVS LF497
F483   AA                   TAX
F484   A5 F3                LDA $F3
F486   D0 36                BNE LF4BE
F488   E0 09                CPX #$09
F48A   90 4A                BCC LF4D6
F48C   85 D7                STA $D7
F48E   A5 D8                LDA $D8
F490   85 D5                STA $D5
F492   E6 F3                INC $F3
F494   60                   RTS
F495   E6 E4      LF495     INC $E4
F497   18         LF497     CLC
F498   69 01                ADC #$01
F49A   C9 08                CMP #$08
F49C   F0 F9                BEQ LF497
F49E   C9 07                CMP #$07
F4A0   F0 F5                BEQ LF497
F4A2   C9 0F                CMP #$0F
F4A4   F0 EF                BEQ LF495
F4A6   29 0F                AND #$0F
F4A8   85 D6                STA $D6
F4AA   A2 C0                LDX #$C0
F4AC   86 E2                STX $E2
F4AE   86 E5                STX $E5
F4B0   A6 D4                LDX $D4
F4B2   86 D5                STX $D5
F4B4   86 D8                STX $D8
F4B6   20 4B FE             JSR LFE4B
F4B9   A9 00      LF4B9     LDA #$00
F4BB   85 F3                STA $F3
F4BD   60                   RTS
F4BE   A5 D4      LF4BE     LDA $D4
F4C0   C5 D5                CMP $D5
F4C2   F0 F5                BEQ LF4B9
F4C4   A5 F5                LDA $F5
F4C6   F0 05                BEQ LF4CD
F4C8   A9 0F                LDA #$0F
F4CA   85 E7                STA $E7
F4CC   60                   RTS
F4CD   A9 C0      LF4CD     LDA #$C0
F4CF   85 F3                STA $F3
F4D1   85 F4                STA $F4
F4D3   4C 3E F1             JMP LF13E
F4D6   AD 80 02   LF4D6     LDA $0280
F4D9   C9 F0                CMP #$F0
F4DB   B0 5E                BCS LF53B
F4DD   24 ED                BIT $ED
F4DF   10 02                BPL LF4E3
F4E1   49 C0                EOR #$C0
F4E3   85 E9      LF4E3     STA $E9
F4E5   20 E6 F1             JSR LF1E6
F4E8   A5 D8                LDA $D8
F4EA   A2 03                LDX #$03
F4EC   06 E9      LF4EC     ASL $E9
F4EE   B0 03                BCS LF4F3
F4F0   7D 7E FF             ADC $FF7E,X
F4F3   CA         LF4F3     DEX
F4F4   10 F6                BPL LF4EC
F4F6   29 3F                AND #$3F
F4F8   A6 D8                LDX $D8
F4FA   85 D8                STA $D8
F4FC   A8                   TAY
F4FD   A5 F3                LDA $F3
F4FF   4A                   LSR A
F500   B5 80                LDA $80,X
F502   29 F0                AND #$F0
F504   B0 08                BCS LF50E
F506   84 D4                STY $D4
F508   05 D6                ORA $D6
F50A   95 80                STA $80,X
F50C   90 0B                BCC LF519
F50E   05 D7      LF50E     ORA $D7
F510   84 D5                STY $D5
F512   95 80                STA $80,X
F514   98                   TYA
F515   45 D4                EOR $D4
F517   F0 09                BEQ LF522
F519   B9 80 00   LF519     LDA $0080,Y
F51C   29 0F                AND #$0F
F51E   B0 02                BCS LF522
F520   85 D6      LF520     STA $D6
F522   85 D7      LF522     STA $D7
F524   A2 00      LF524     LDX #$00
F526   86 F1                STX $F1
F528   86 F0                STX $F0
F52A   A9 20                LDA #$20
F52C   85 F4                STA $F4
F52E   86 F5                STX $F5
F530   86 F6                STX $F6
F532   A2 05      LF532     LDX #$05
F534   B5 D3      LF534     LDA $D3,X
F536   95 D8                STA $D8,X
F538   CA                   DEX
F539   D0 F9                BNE LF534
F53B   60         LF53B     RTS
F53C   A6 F4      LF53C     LDX $F4
F53E   D0 04                BNE LF544
F540   A6 D4                LDX $D4
F542   10 EE                BPL LF532
F544   60         LF544     RTS
F545   24 ED      LF545     BIT $ED
F547   8C 96 02             STY $0296
F54A   10 27                BPL LF573
F54C   A2 3F                LDX #$3F
F54E   8A         LF54E     TXA
F54F   49 07                EOR #$07
F551   A8                   TAY
F552   B9 80 00             LDA $0080,Y
F555   29 0F                AND #$0F
F557   85 F8                STA $F8
F559   B5 80                LDA $80,X
F55B   29 0F                AND #$0F
F55D   85 F9                STA $F9
F55F   55 80                EOR $80,X
F561   05 F8                ORA $F8
F563   95 80                STA $80,X
F565   B9 80 00             LDA $0080,Y
F568   29 F0                AND #$F0
F56A   05 F9                ORA $F9
F56C   99 80 00             STA $0080,Y
F56F   CA                   DEX
F570   CA                   DEX
F571   10 DB                BPL LF54E
F573   60         LF573     RTS
F574   A9 00      LF574     LDA #$00
F576   85 1D                STA $1D
F578   85 DC                STA $DC
F57A   85 E1                STA $E1
F57C   85 E0                STA $E0
F57E   85 D1                STA $D1
F580   85 D0                STA $D0
F582   A2 01      LF582     LDX #$01
F584   86 DE                STX $DE
F586   86 C0                STX $C0
F588   A9 FF                LDA #$FF
F58A   86 E3                STX $E3
F58C   CA                   DEX
F58D   86 DA                STX $DA
F58F   85 DD                STA $DD
F591   85 DF                STA $DF
F593   85 CE                STA $CE
F595   85 CF                STA $CF
F597   A9 BF                LDA #$BF
F599   25 80                AND $80
F59B   85 80                STA $80
F59D   A9 3F                LDA #$3F
F59F   25 B8                AND $B8
F5A1   85 B8                STA $B8
F5A3   86 D0                STX $D0
F5A5   A5 D1                LDA $D1
F5A7   F0 2C                BEQ LF5D5
F5A9   4C 4E F6             JMP LF64E
F5AC   E6 D0      LF5AC     INC $D0
F5AE   24 B8                BIT $B8
F5B0   70 1D                BVS LF5CF
F5B2   A6 D0                LDX $D0
F5B4   CA                   DEX
F5B5   F0 04                BEQ LF5BB
F5B7   E4 D1                CPX $D1
F5B9   D0 14                BNE LF5CF
F5BB   A5 B8      LF5BB     LDA $B8
F5BD   29 3F                AND #$3F
F5BF   09 80                ORA #$80
F5C1   85 B8      LF5C1     STA $B8
F5C3   A5 E3                LDA $E3
F5C5   49 7C                EOR #$7C
F5C7   85 E7                STA $E7
F5C9   A9 00                LDA #$00
F5CB   85 E6                STA $E6
F5CD   F0 06                BEQ LF5D5
F5CF   A5 E3      LF5CF     LDA $E3
F5D1   49 FE                EOR #$FE
F5D3   85 E3                STA $E3
F5D5   A5 B4      LF5D5     LDA $B4
F5D7   29 7F                AND #$7F
F5D9   85 B4                STA $B4
F5DB   A9 40      LF5DB     LDA #$40
F5DD   85 D4                STA $D4
F5DF   20 66 FA             JSR LFA66
F5E2   A5 D4      LF5E2     LDA $D4
F5E4   30 03                BMI LF5E9
F5E6   4C 91 F6             JMP LF691
F5E9   A9 40      LF5E9     LDA #$40
F5EB   85 D4                STA $D4
F5ED   24 B8                BIT $B8
F5EF   70 73                BVS LF664
F5F1   30 64                BMI LF657
F5F3   A5 D0                LDA $D0
F5F5   F0 0F                BEQ LF606
F5F7   C5 D1                CMP $D1
F5F9   F0 05                BEQ LF600
F5FB   90 03                BCC LF600
F5FD   4C C6 F8   LF5FD     JMP LF8C6
F600   24 B4      LF600     BIT $B4
F602   10 69                BPL LF66D
F604   30 F7                BMI LF5FD
F606   24 B4      LF606     BIT $B4
F608   10 63                BPL LF66D
F60A   24 80                BIT $80
F60C   70 03                BVS LF611
F60E   4C F5 F9             JMP LF9F5
F611   A5 ED      LF611     LDA $ED
F613   85 CE                STA $CE
F615   29 3F                AND #$3F
F617   85 D4                STA $D4
F619   AA                   TAX
F61A   A5 EE                LDA $EE
F61C   85 CF                STA $CF
F61E   85 D8                STA $D8
F620   A5 DE                LDA $DE
F622   85 DF                STA $DF
F624   B5 80                LDA $80,X
F626   29 0F                AND #$0F
F628   85 D6                STA $D6
F62A   20 91 FB             JSR LFB91
F62D   8A                   TXA
F62E   18                   CLC
F62F   29 3C                AND #$3C
F631   65 D5                ADC $D5
F633   0A                   ASL A
F634   85 09                STA $09
F636   B5 80                LDA $80,X
F638   29 0F                AND #$0F
F63A   A6 D6                LDX $D6
F63C   E0 06                CPX #$06
F63E   D0 0C                BNE LF64C
F640   A6 D8                LDX $D8
F642   E0 08                CPX #$08
F644   90 06                BCC LF64C
F646   E0 0C                CPX #$0C
F648   B0 02                BCS LF64C
F64A   A9 0E                LDA #$0E
F64C   85 D7      LF64C     STA $D7
F64E   A9 BF      LF64E     LDA #$BF
F650   25 81                AND $81
F652   85 81                STA $81
F654   4C EA F6             JMP LF6EA
F657   A5 E3      LF657     LDA $E3
F659   49 FE                EOR #$FE
F65B   85 E3                STA $E3
F65D   A5 B8                LDA $B8
F65F   09 C0                ORA #$C0
F661   4C C1 F5             JMP LF5C1
F664   A5 B8      LF664     LDA $B8
F666   29 3F                AND #$3F
F668   85 B8                STA $B8
F66A   4C D5 F5             JMP LF5D5
F66D   06 B4      LF66D     ASL $B4
F66F   38                   SEC
F670   66 B4                ROR $B4
F672   A5 D0                LDA $D0
F674   D0 09                BNE LF67F
F676   A5 82                LDA $82
F678   05 85                ORA $85
F67A   05 89                ORA $89
F67C   0A                   ASL A
F67D   10 08                BPL LF687
F67F   4C DB F5   LF67F     JMP LF5DB
F682   04                   ???                ;%00000100
F683   06 01                ASL $01
F685   00                   BRK
F686   08                   PHP
F687   A2 04      LF687     LDX #$04
F689   BD 82 F6   LF689     LDA $F682,X
F68C   95 D4                STA $D4,X
F68E   CA                   DEX
F68F   10 F8                BPL LF689
F691   A5 D0      LF691     LDA $D0
F693   D0 55                BNE LF6EA
F695   A5 E0                LDA $E0
F697   C5 D4                CMP $D4
F699   D0 06                BNE LF6A1
F69B   A5 E1                LDA $E1
F69D   C5 D8                CMP $D8
F69F   F0 30                BEQ LF6D1
F6A1   20 B6 FB   LF6A1     JSR LFBB6
F6A4   A6 DE                LDX $DE
F6A6   E4 F0                CPX $F0
F6A8   B0 27                BCS LF6D1
F6AA   AA                   TAX
F6AB   A5 B4                LDA $B4
F6AD   49 80                EOR #$80
F6AF   29 80                AND #$80
F6B1   05 D4                ORA $D4
F6B3   A4 D8                LDY $D8
F6B5   E4 DF                CPX $DF
F6B7   90 0C                BCC LF6C5
F6B9   D0 16                BNE LF6D1
F6BB   C5 CE                CMP $CE
F6BD   90 06                BCC LF6C5
F6BF   D0 10                BNE LF6D1
F6C1   C4 CF                CPY $CF
F6C3   B0 0C                BCS LF6D1
F6C5   86 DE      LF6C5     STX $DE
F6C7   85 ED                STA $ED
F6C9   84 EE                STY $EE
F6CB   A5 80                LDA $80
F6CD   09 40                ORA #$40
F6CF   85 80                STA $80
F6D1   A5 D6      LF6D1     LDA $D6
F6D3   C9 01                CMP #$01
F6D5   D0 06                BNE LF6DD
F6D7   A5 D8                LDA $D8
F6D9   C9 08                CMP #$08
F6DB   B0 A2                BCS LF67F
F6DD   24 B4      LF6DD     BIT $B4
F6DF   30 03                BMI LF6E4
F6E1   20 4D FD   LF6E1     JSR LFD4D
F6E4   20 95 FA   LF6E4     JSR LFA95
F6E7   4C E2 F5             JMP LF5E2
F6EA   A5 8C      LF6EA     LDA $8C
F6EC   29 BF                AND #$BF
F6EE   A4 D6                LDY $D6
F6F0   C0 06                CPY #$06
F6F2   D0 08                BNE LF6FC
F6F4   A4 D8                LDY $D8
F6F6   C0 0C                CPY #$0C
F6F8   90 02                BCC LF6FC
F6FA   09 40                ORA #$40
F6FC   85 8C      LF6FC     STA $8C
F6FE   A6 D4                LDX $D4
F700   B5 80                LDA $80,X
F702   29 0F                AND #$0F
F704   85 EB                STA $EB
F706   24 B8                BIT $B8
F708   10 78                BPL LF782
F70A   A4 D7                LDY $D7
F70C   A6 D0                LDX $D0
F70E   C0 09                CPY #$09
F710   D0 0A                BNE LF71C
F712   E0 01                CPX #$01
F714   D0 06                BNE LF71C
F716   A9 40                LDA #$40
F718   05 81                ORA $81
F71A   85 81                STA $81
F71C   CA         LF71C     DEX
F71D   E4 D1                CPX $D1
F71F   D0 54                BNE LF775
F721   E8                   INX
F722   C0 01                CPY #$01
F724   D0 08                BNE LF72E
F726   A5 DA                LDA $DA
F728   E9 01                SBC #$01
F72A   49 80                EOR #$80
F72C   95 C0                STA $C0,X
F72E   A6 D7      LF72E     LDX $D7
F730   A4 EB                LDY $EB
F732   B9 D5 FE             LDA $FED5,Y
F735   18                   CLC
F736   7D D5 FE             ADC $FED5,X
F739   F0 2D                BEQ LF768
F73B   A8                   TAY
F73C   AA                   TAX
F73D   20 81 FD             JSR LFD81
F740   2A                   ROL A
F741   30 25                BMI LF768
F743   B0 02                BCS LF747
F745   E6 E6                INC $E6
F747   85 EC      LF747     STA $EC
F749   A4 E7                LDY $E7
F74B   20 81 FD             JSR LFD81
F74E   2A                   ROL A
F74F   C5 EC                CMP $EC
F751   B0 02                BCS LF755
F753   86 E7                STX $E7
F755   A9 01      LF755     LDA #$01
F757   C5 E6                CMP $E6
F759   90 10                BCC LF76B
F75B   A5 D6                LDA $D6
F75D   C9 03                CMP #$03
F75F   D0 03                BNE LF764
F761   4C E4 F6   LF761     JMP LF6E4
F764   C9 05      LF764     CMP #$05
F766   F0 F9                BEQ LF761
F768   4C E1 F6   LF768     JMP LF6E1
F76B   A6 D0      LF76B     LDX $D0
F76D   A5 DA                LDA $DA
F76F   65 E7                ADC $E7
F771   49 80                EOR #$80
F773   95 C0                STA $C0,X
F775   24 B8      LF775     BIT $B8
F777   70 06                BVS LF77F
F779   A5 E3                LDA $E3
F77B   49 FE                EOR #$FE
F77D   85 E3                STA $E3
F77F   4C 64 F6   LF77F     JMP LF664
F782   A4 D7      LF782     LDY $D7
F784   A5 DA                LDA $DA
F786   18                   CLC
F787   79 D5 FE             ADC $FED5,Y
F78A   85 DB                STA $DB
F78C   24 8C                BIT $8C
F78E   50 19                BVC LF7A9
F790   A5 E3                LDA $E3
F792   0A                   ASL A
F793   29 08                AND #$08
F795   49 0A                EOR #$0A
F797   A8                   TAY
F798   A9 05                LDA #$05
F79A   B0 02                BCS LF79E
F79C   A9 FA                LDA #$FA
F79E   65 DB      LF79E     ADC $DB
F7A0   18                   CLC
F7A1   E5 D0                SBC $D0
F7A3   18                   CLC
F7A4   79 D5 FE             ADC $FED5,Y
F7A7   85 DB                STA $DB
F7A9   A5 D7      LF7A9     LDA $D7
F7AB   29 07                AND #$07
F7AD   C9 01                CMP #$01
F7AF   D0 10                BNE LF7C1
F7B1   A5 E3                LDA $E3
F7B3   0A                   ASL A
F7B4   A5 D0                LDA $D0
F7B6   B0 02                BCS LF7BA
F7B8   49 FF                EOR #$FF
F7BA   69 00      LF7BA     ADC #$00
F7BC   85 E9                STA $E9
F7BE   4C EC F9             JMP LF9EC
F7C1   24 E2      LF7C1     BIT $E2
F7C3   50 1A                BVC LF7DF
F7C5   A9 01                LDA #$01
F7C7   20 71 FE             JSR LFE71
F7CA   8A                   TXA
F7CB   A8                   TAY
F7CC   20 6F FE             JSR LFE6F
F7CF   98                   TYA
F7D0   20 9C FE             JSR LFE9C
F7D3   85 DC                STA $DC
F7D5   A9 1B                LDA #$1B
F7D7   20 9C FE             JSR LFE9C
F7DA   0A                   ASL A
F7DB   E5 DC                SBC $DC
F7DD   85 DC                STA $DC
F7DF   A5 E3      LF7DF     LDA $E3
F7E1   49 FE                EOR #$FE
F7E3   A6 D0                LDX $D0
F7E5   95 C1                STA $C1,X
F7E7   E4 D1                CPX $D1
F7E9   90 09                BCC LF7F4
F7EB   A5 DB                LDA $DB
F7ED   18                   CLC
F7EE   65 DC                ADC $DC
F7F0   49 80                EOR #$80
F7F2   95 C1                STA $C1,X
F7F4   A6 D1      LF7F4     LDX $D1
F7F6   E4 D0                CPX $D0
F7F8   B0 27                BCS LF821
F7FA   A6 D2                LDX $D2
F7FC   E4 D0                CPX $D0
F7FE   B0 17                BCS LF817
F800   A5 D5                LDA $D5
F802   C5 DD                CMP $DD
F804   F0 11                BEQ LF817
F806   A4 EB                LDY $EB
F808   20 65 FD             JSR LFD65
F80B   10 0A                BPL LF817
F80D   A5 D7                LDA $D7
F80F   F0 06                BEQ LF817
F811   4C E1 F6             JMP LF6E1
F814   4C 7A F9   LF814     JMP LF97A
F817   A5 D0      LF817     LDA $D0
F819   C9 0C                CMP #$0C
F81B   F0 F7                BEQ LF814
F81D   A5 D5                LDA $D5
F81F   85 DD                STA $DD
F821   A5 D0      LF821     LDA $D0
F823   18                   CLC
F824   69 1A                ADC #$1A
F826   AA                   TAX
F827   A5 D4                LDA $D4
F829   A8                   TAY
F82A   10 0A                BPL LF836
F82C   AA         LF82C     TAX
F82D   A5 D7                LDA $D7
F82F   E4 D0                CPX $D0
F831   D0 03                BNE LF836
F833   B9 80 00             LDA $0080,Y
F836   0A         LF836     ASL A
F837   0A                   ASL A
F838   0A                   ASL A
F839   0A                   ASL A
F83A   85 FB                STA $FB
F83C   B5 8D                LDA $8D,X
F83E   29 0F                AND #$0F
F840   05 FB                ORA $FB
F842   95 8D                STA $8D,X
F844   8A                   TXA
F845   38                   SEC
F846   E9 0D                SBC #$0D
F848   10 E2                BPL LF82C
F84A   A5 D8                LDA $D8
F84C   95 EF                STA $EF,X
F84E   B5 80                LDA $80,X
F850   29 4F                AND #$4F
F852   95 80                STA $80,X
F854   A5 B4                LDA $B4
F856   29 80                AND #$80
F858   05 D4                ORA $D4
F85A   29 B0                AND #$B0
F85C   15 80                ORA $80,X
F85E   95 80                STA $80,X
F860   8A                   TXA
F861   D0 14                BNE LF877
F863   B9 80 00             LDA $0080,Y
F866   29 0F                AND #$0F
F868   85 D6                STA $D6
F86A   4A                   LSR A
F86B   D0 0A                BNE LF877
F86D   A5 D8                LDA $D8
F86F   A0 07                LDY #$07
F871   A2 05                LDX #$05
F873   C9 08                CMP #$08
F875   F0 14                BEQ LF88B
F877   A5 D6      LF877     LDA $D6
F879   C9 06                CMP #$06
F87B   D0 11                BNE LF88E
F87D   A5 D8                LDA $D8
F87F   C9 08                CMP #$08
F881   90 0B                BCC LF88E
F883   C9 0C                CMP #$0C
F885   B0 07                BCS LF88E
F887   A6 D5                LDX $D5
F889   A4 E5                LDY $E5
F88B   20 37 FD   LF88B     JSR LFD37
F88E   20 33 FD   LF88E     JSR LFD33
F891   A4 D7                LDY $D7
F893   A5 DA                LDA $DA
F895   18                   CLC
F896   79 D5 FE             ADC $FED5,Y
F899   85 DA                STA $DA
F89B   24 8C                BIT $8C
F89D   50 24                BVC LF8C3
F89F   A5 E3                LDA $E3
F8A1   29 08                AND #$08
F8A3   09 02                ORA #$02
F8A5   85 E9                STA $E9
F8A7   49 08                EOR #$08
F8A9   A8                   TAY
F8AA   A6 D5                LDX $D5
F8AC   20 44 FD             JSR LFD44
F8AF   A9 06                LDA #$06
F8B1   24 E3                BIT $E3
F8B3   30 02                BMI LF8B7
F8B5   A9 FA                LDA #$FA
F8B7   18         LF8B7     CLC
F8B8   65 DA                ADC $DA
F8BA   18                   CLC
F8BB   E5 D0                SBC $D0
F8BD   18                   CLC
F8BE   79 D5 FE             ADC $FED5,Y
F8C1   85 DA                STA $DA
F8C3   4C AC F5   LF8C3     JMP LF5AC
F8C6   C6 D0      LF8C6     DEC $D0
F8C8   A5 E3                LDA $E3
F8CA   49 FE                EOR #$FE
F8CC   85 E3                STA $E3
F8CE   A9 FF                LDA #$FF
F8D0   85 DD                STA $DD
F8D2   A6 D0                LDX $D0
F8D4   B5 A7                LDA $A7,X
F8D6   4A                   LSR A
F8D7   4A                   LSR A
F8D8   4A                   LSR A
F8D9   4A                   LSR A
F8DA   85 E9                STA $E9
F8DC   B5 80                LDA $80,X
F8DE   29 B0                AND #$B0
F8E0   05 E9                ORA $E9
F8E2   06 B4                ASL $B4
F8E4   0A                   ASL A
F8E5   66 B4                ROR $B4
F8E7   4A                   LSR A
F8E8   85 D4                STA $D4
F8EA   B5 9A                LDA $9A,X
F8EC   4A                   LSR A
F8ED   4A                   LSR A
F8EE   4A                   LSR A
F8EF   4A                   LSR A
F8F0   85 D7                STA $D7
F8F2   B5 8D                LDA $8D,X
F8F4   4A                   LSR A
F8F5   4A                   LSR A
F8F6   4A                   LSR A
F8F7   4A                   LSR A
F8F8   85 E9                STA $E9
F8FA   29 07                AND #$07
F8FC   85 D6                STA $D6
F8FE   B4 EF                LDY $EF,X
F900   84 D8                STY $D8
F902   20 91 FB             JSR LFB91
F905   B5 80                LDA $80,X
F907   29 F0                AND #$F0
F909   05 D7                ORA $D7
F90B   95 80                STA $80,X
F90D   A6 D4                LDX $D4
F90F   20 44 FD             JSR LFD44
F912   A6 D8                LDX $D8
F914   A5 D6                LDA $D6
F916   E0 08                CPX #$08
F918   90 26                BCC LF940
F91A   D0 0C                BNE LF928
F91C   A4 D0                LDY $D0
F91E   D0 08                BNE LF928
F920   A0 05                LDY #$05
F922   CA                   DEX
F923   C9 01                CMP #$01
F925   F0 16                BEQ LF93D
F927   E8                   INX
F928   C9 06      LF928     CMP #$06
F92A   D0 14                BNE LF940
F92C   E0 0C                CPX #$0C
F92E   B0 10                BCS LF940
F930   A5 E3                LDA $E3
F932   0A                   ASL A
F933   0A                   ASL A
F934   0A                   ASL A
F935   49 FF                EOR #$FF
F937   38                   SEC
F938   65 D5                ADC $D5
F93A   AA                   TAX
F93B   A4 D5                LDY $D5
F93D   20 37 FD   LF93D     JSR LFD37
F940   A6 D0      LF940     LDX $D0
F942   B5 C1                LDA $C1,X
F944   85 E9                STA $E9
F946   A4 D7                LDY $D7
F948   A5 DA                LDA $DA
F94A   38                   SEC
F94B   F9 D5 FE             SBC $FED5,Y
F94E   85 DA                STA $DA
F950   A5 D6                LDA $D6
F952   C9 06                CMP #$06
F954   D0 2D                BNE LF983
F956   A5 D8                LDA $D8
F958   C9 0C                CMP #$0C
F95A   90 27                BCC LF983
F95C   A5 E3                LDA $E3
F95E   29 08                AND #$08
F960   49 0A                EOR #$0A
F962   A8                   TAY
F963   A9 06                LDA #$06
F965   24 E3                BIT $E3
F967   10 02                BPL LF96B
F969   A9 FA                LDA #$FA
F96B   18         LF96B     CLC
F96C   65 DA                ADC $DA
F96E   38                   SEC
F96F   65 D0                ADC $D0
F971   38                   SEC
F972   F9 D5 FE             SBC $FED5,Y
F975   85 DA                STA $DA
F977   4C 83 F9             JMP LF983
F97A   A5 DB      LF97A     LDA $DB
F97C   18                   CLC
F97D   65 DC                ADC $DC
F97F   49 80                EOR #$80
F981   85 E9                STA $E9
F983   A6 D0      LF983     LDX $D0
F985   A5 E3                LDA $E3
F987   30 30                BMI LF9B9
F989   8A                   TXA
F98A   D0 15                BNE LF9A1
F98C   A5 E9                LDA $E9
F98E   C9 FD                CMP #$FD
F990   90 0C                BCC LF99E
F992   24 E2                BIT $E2
F994   50 08                BVC LF99E
F996   24 81                BIT $81
F998   70 04                BVS LF99E
F99A   A9 03                LDA #$03
F99C   85 E9                STA $E9
F99E   4C B1 F9   LF99E     JMP LF9B1
F9A1   B5 BF      LF9A1     LDA $BF,X
F9A3   C5 C1                CMP $C1
F9A5   F0 04                BEQ LF9AB
F9A7   90 02                BCC LF9AB
F9A9   A5 C1                LDA $C1
F9AB   C5 E9      LF9AB     CMP $E9
F9AD   F0 3D                BEQ LF9EC
F9AF   90 3B                BCC LF9EC
F9B1   B5 C0      LF9B1     LDA $C0,X
F9B3   C5 E9                CMP $E9
F9B5   90 14                BCC LF9CB
F9B7   B0 21                BCS LF9DA
F9B9   B5 BF      LF9B9     LDA $BF,X
F9BB   C5 C0                CMP $C0
F9BD   B0 02                BCS LF9C1
F9BF   A5 C0                LDA $C0
F9C1   C5 E9      LF9C1     CMP $E9
F9C3   B0 27                BCS LF9EC
F9C5   A5 E9                LDA $E9
F9C7   D5 C0                CMP $C0,X
F9C9   B0 0F                BCS LF9DA
F9CB   A5 E9      LF9CB     LDA $E9
F9CD   95 C0                STA $C0,X
F9CF   8A                   TXA
F9D0   D0 08                BNE LF9DA
F9D2   A5 D4                LDA $D4
F9D4   85 E0                STA $E0
F9D6   A5 D8                LDA $D8
F9D8   85 E1                STA $E1
F9DA   8A         LF9DA     TXA
F9DB   F0 03                BEQ LF9E0
F9DD   4C DD F6             JMP LF6DD
F9E0   A5 80      LF9E0     LDA $80
F9E2   29 BF                AND #$BF
F9E4   85 80                STA $80
F9E6   E8                   INX
F9E7   86 DE                STX $DE
F9E9   4C D5 F5             JMP LF5D5
F9EC   A6 D0      LF9EC     LDX $D0
F9EE   A5 E9                LDA $E9
F9F0   95 C0                STA $C0,X
F9F2   4C C6 F8             JMP LF8C6
F9F5   A6 E0      LF9F5     LDX $E0
F9F7   86 D4                STX $D4
F9F9   A5 E1                LDA $E1
F9FB   85 D8                STA $D8
F9FD   B5 80                LDA $80,X
F9FF   29 07                AND #$07
FA01   85 D6                STA $D6
FA03   20 91 FB             JSR LFB91
FA06   06 B4                ASL $B4
FA08   38                   SEC
FA09   66 B4                ROR $B4
FA0B   B5 80                LDA $80,X
FA0D   29 0F                AND #$0F
FA0F   A6 D6                LDX $D6
FA11   E0 06                CPX #$06
FA13   D0 0C                BNE LFA21
FA15   A6 D8                LDX $D8
FA17   E0 08                CPX #$08
FA19   90 06                BCC LFA21
FA1B   E0 0C                CPX #$0C
FA1D   B0 02                BCS LFA21
FA1F   A9 0E                LDA #$0E
FA21   85 D7      LFA21     STA $D7
FA23   A4 D9                LDY $D9
FA25   F0 09                BEQ LFA30
FA27   A5 D1                LDA $D1
FA29   D0 05                BNE LFA30
FA2B   84 D1                STY $D1
FA2D   4C 82 F5             JMP LF582
FA30   E6 E4      LFA30     INC $E4
FA32   A2 1F                LDX #$1F
FA34   86 D0                STX $D0
FA36   86 15                STX $15
FA38   A4 D4                LDY $D4
FA3A   A2 00                LDX #$00
FA3C   A5 C0                LDA $C0
FA3E   C9 03                CMP #$03
FA40   90 09                BCC LFA4B
FA42   E8                   INX
FA43   C9 FD                CMP #$FD
FA45   B0 06                BCS LFA4D
FA47   E8                   INX
FA48   E8                   INX
FA49   D0 02                BNE LFA4D
FA4B   84 D5      LFA4B     STY $D5
FA4D   86 EE      LFA4D     STX $EE
FA4F   84 D8                STY $D8
FA51   20 3E F1             JSR LF13E
FA54   20 24 F5             JSR LF524
FA57   A9 80                LDA #$80
FA59   85 F3                STA $F3
FA5B   85 E7                STA $E7
FA5D   20 91 FD             JSR LFD91
FA60   20 B9 F3             JSR LF3B9
FA63   4C 0F F0             JMP LF00F
FA66   A6 D4      LFA66     LDX $D4
FA68   CA         LFA68     DEX
FA69   30 5D                BMI LFAC8
FA6B   B5 80                LDA $80,X
FA6D   29 0F                AND #$0F
FA6F   F0 F7                BEQ LFA68
FA71   A4 E3                LDY $E3
FA73   10 02                BPL LFA77
FA75   49 08                EOR #$08
FA77   C9 07      LFA77     CMP #$07
FA79   B0 ED                BCS LFA68
FA7B   86 D4                STX $D4
FA7D   85 D6                STA $D6
FA7F   A8                   TAY
FA80   B9 EE FF             LDA $FFEE,Y
FA83   C0 06                CPY #$06
FA85   D0 06                BNE LFA8D
FA87   24 E3                BIT $E3
FA89   10 02                BPL LFA8D
FA8B   69 00                ADC #$00
FA8D   85 D8      LFA8D     STA $D8
FA8F   A5 B7                LDA $B7
FA91   85 D5                STA $D5
FA93   30 35                BMI LFACA
FA95   A5 D6      LFA95     LDA $D6
FA97   C9 06                CMP #$06
FA99   F0 37                BEQ LFAD2
FA9B   C6 D8      LFA9B     DEC $D8
FA9D   30 C7      LFA9D     BMI LFA66
FA9F   20 91 FB   LFA9F     JSR LFB91
FAA2   30 27                BMI LFACB
FAA4   A5 B4                LDA $B4
FAA6   0A                   ASL A
FAA7   A4 D6                LDY $D6
FAA9   B5 80                LDA $80,X
FAAB   29 0F                AND #$0F
FAAD   85 D7                STA $D7
FAAF   D0 08                BNE LFAB9
FAB1   B0 17                BCS LFACA
FAB3   C0 06                CPY #$06
FAB5   D0 E4                BNE LFA9B
FAB7   F0 60                BEQ LFB19
FAB9   45 E3      LFAB9     EOR $E3
FABB   29 08                AND #$08
FABD   F0 0C                BEQ LFACB
FABF   B0 0A                BCS LFACB
FAC1   C0 06                CPY #$06
FAC3   D0 05                BNE LFACA
FAC5   4C 75 FB             JMP LFB75
FAC8   86 D4      LFAC8     STX $D4
FACA   60         LFACA     RTS
FACB   20 4D FD   LFACB     JSR LFD4D
FACE   90 CB                BCC LFA9B
FAD0   B0 47                BCS LFB19
FAD2   A5 D4      LFAD2     LDA $D4
FAD4   4A                   LSR A
FAD5   4A                   LSR A
FAD6   4A                   LSR A
FAD7   A6 E3                LDX $E3
FAD9   10 02                BPL LFADD
FADB   49 07                EOR #$07
FADD   85 EC      LFADD     STA $EC
FADF   A5 D8                LDA $D8
FAE1   C9 0E                CMP #$0E
FAE3   90 04                BCC LFAE9
FAE5   E9 0C                SBC #$0C
FAE7   85 D8                STA $D8
FAE9   A9 80      LFAE9     LDA #$80
FAEB   85 EB                STA $EB
FAED   45 B7                EOR $B7
FAEF   25 E3                AND $E3
FAF1   30 02                BMI LFAF5
FAF3   A5 E5                LDA $E5
FAF5   A6 D0      LFAF5     LDX $D0
FAF7   F0 1C                BEQ LFB15
FAF9   B5 EE                LDA $EE,X
FAFB   C9 02                CMP #$02
FAFD   B0 1A                BCS LFB19
FAFF   B5 8C                LDA $8C,X
FB01   29 70                AND #$70
FB03   C9 60                CMP #$60
FB05   D0 12                BNE LFB19
FB07   B5 A6                LDA $A6,X
FB09   4A                   LSR A
FB0A   4A                   LSR A
FB0B   4A                   LSR A
FB0C   4A                   LSR A
FB0D   85 EB                STA $EB
FB0F   B5 7F                LDA $7F,X
FB11   29 30                AND #$30
FB13   05 EB                ORA $EB
FB15   49 18      LFB15     EOR #$18
FB17   85 EB                STA $EB
FB19   C6 D8      LFB19     DEC $D8
FB1B   C6 D8                DEC $D8
FB1D   10 03                BPL LFB22
FB1F   4C 9D FA             JMP LFA9D
FB22   A5 D8      LFB22     LDA $D8
FB24   4A                   LSR A
FB25   AA                   TAX
FB26   CA                   DEX
FB27   30 5C                BMI LFB85
FB29   F0 32                BEQ LFB5D
FB2B   CA                   DEX
FB2C   CA                   DEX
FB2D   CA                   DEX
FB2E   30 24                BMI LFB54
FB30   A5 B7                LDA $B7
FB32   45 B4                EOR $B4
FB34   30 E3                BMI LFB19
FB36   A5 EB                LDA $EB
FB38   30 DF                BMI LFB19
FB3A   24 B8                BIT $B8
FB3C   30 DB                BMI LFB19
FB3E   A5 EC                LDA $EC
FB40   C9 04                CMP #$04
FB42   D0 D5                BNE LFB19
FB44   20 91 FB             JSR LFB91
FB47   E4 EB                CPX $EB
FB49   D0 CE                BNE LFB19
FB4B   A5 E3                LDA $E3
FB4D   29 08                AND #$08
FB4F   49 0E                EOR #$0E
FB51   85 D7                STA $D7
FB53   60                   RTS
FB54   A5 B7      LFB54     LDA $B7
FB56   45 B4                EOR $B4
FB58   30 BF                BMI LFB19
FB5A   4C 9F FA             JMP LFA9F
FB5D   A5 EC      LFB5D     LDA $EC
FB5F   C9 05                CMP #$05
FB61   6A                   ROR A
FB62   45 B4                EOR $B4
FB64   05 B7                ORA $B7
FB66   10 B1                BPL LFB19
FB68   20 91 FB   LFB68     JSR LFB91
FB6B   30 AC                BMI LFB19
FB6D   B5 80                LDA $80,X
FB6F   29 0F                AND #$0F
FB71   85 D7                STA $D7
FB73   D0 19                BNE LFB8E
FB75   A5 B7      LFB75     LDA $B7
FB77   30 0B                BMI LFB84
FB79   A9 06                LDA #$06
FB7B   C5 EC                CMP $EC
FB7D   D0 05                BNE LFB84
FB7F   0A                   ASL A
FB80   65 D8                ADC $D8
FB82   85 D8                STA $D8
FB84   60         LFB84     RTS
FB85   A6 EC      LFB85     LDX $EC
FB87   CA                   DEX
FB88   D0 04                BNE LFB8E
FB8A   24 B4                BIT $B4
FB8C   30 DA                BMI LFB68
FB8E   4C 66 FA   LFB8E     JMP LFA66
FB91   A6 D6      LFB91     LDX $D6
FB93   BD E8 FF             LDA $FFE8,X
FB96   18                   CLC
FB97   65 D8                ADC $D8
FB99   A8                   TAY
FB9A   A5 D4                LDA $D4
FB9C   29 38                AND #$38
FB9E   65 D4                ADC $D4
FBA0   F8                   SED
FBA1   79 82 FF             ADC $FF82,Y
FBA4   D8                   CLD
FBA5   AA                   TAX
FBA6   30 0B                BMI LFBB3
FBA8   85 D5                STA $D5
FBAA   29 0F                AND #$0F
FBAC   AA                   TAX
FBAD   65 D5                ADC $D5
FBAF   E0 08                CPX #$08
FBB1   6A                   ROR A
FBB2   AA                   TAX
FBB3   86 D5      LFBB3     STX $D5
FBB5   60                   RTS
FBB6   A6 E4      LFBB6     LDX $E4
FBB8   E0 08                CPX #$08
FBBA   A5 D6                LDA $D6
FBBC   08                   PHP
FBBD   90 02                BCC LFBC1
FBBF   69 07                ADC #$07
FBC1   A8         LFBC1     TAY
FBC2   A5 D3                LDA $D3
FBC4   29 1B                AND #$1B
FBC6   24 E2                BIT $E2
FBC8   10 04                BPL LFBCE
FBCA   29 09                AND #$09
FBCC   69 09                ADC #$09
FBCE   69 12      LFBCE     ADC #$12
FBD0   AA                   TAX
FBD1   A5 D5                LDA $D5
FBD3   20 9C FE             JSR LFE9C
FBD6   85 F4                STA $F4
FBD8   A5 D4                LDA $D4
FBDA   20 9C FE             JSR LFE9C
FBDD   38                   SEC
FBDE   E5 F4                SBC $F4
FBE0   85 F7                STA $F7
FBE2   BE E3 FE             LDX $FEE3,Y
FBE5   D0 04                BNE LFBEB
FBE7   8A         LFBE7     TXA
FBE8   4C F9 FB             JMP LFBF9
FBEB   10 09      LFBEB     BPL LFBF6
FBED   24 E2                BIT $E2
FBEF   30 F6                BMI LFBE7
FBF1   A2 05                LDX #$05
FBF3   18         LFBF3     CLC
FBF4   65 F7                ADC $F7
FBF6   CA         LFBF6     DEX
FBF7   D0 FA                BNE LFBF3
FBF9   28         LFBF9     PLP
FBFA   90 16                BCC LFC12
FBFC   A6 D3                LDX $D3
FBFE   E0 40                CPX #$40
FC00   90 06                BCC LFC08
FC02   A6 D7                LDX $D7
FC04   F0 02                BEQ LFC08
FC06   E9 32                SBC #$32
FC08   C0 0E      LFC08     CPY #$0E
FC0A   D0 05                BNE LFC11
FC0C   A4 CB                LDY $CB
FC0E   F9 F2 FE             SBC $FEF2,Y
FC11   38         LFC11     SEC
FC12   85 F8      LFC12     STA $F8
FC14   A6 D4                LDX $D4
FC16   B0 27                BCS LFC3F
FC18   E0 0D                CPX #$0D
FC1A   B0 23                BCS LFC3F
FC1C   BD C6 FE             LDA $FEC6,X
FC1F   24 B9                BIT $B9
FC21   10 04                BPL LFC27
FC23   4A                   LSR A
FC24   4A                   LSR A
FC25   4A                   LSR A
FC26   4A                   LSR A
FC27   29 0F      LFC27     AND #$0F
FC29   24 D3                BIT $D3
FC2B   A4 D5                LDY $D5
FC2D   C0 1A                CPY #$1A
FC2F   90 0C                BCC LFC3D
FC31   F0 01                BEQ LFC34
FC33   B8                   CLV
FC34   A4 E4      LFC34     LDY $E4
FC36   D0 05                BNE LFC3D
FC38   50 02                BVC LFC3C
FC3A   69 10                ADC #$10
FC3C   0A         LFC3C     ASL A
FC3D   65 F8      LFC3D     ADC $F8
FC3F   A4 D6      LFC3F     LDY $D6
FC41   C0 06                CPY #$06
FC43   D0 20                BNE LFC65
FC45   E0 10                CPX #$10
FC47   B0 1C                BCS LFC65
FC49   E0 0D                CPX #$0D
FC4B   90 18                BCC LFC65
FC4D   48                   PHA
FC4E   A2 03                LDX #$03
FC50   B5 84      LFC50     LDA $84,X
FC52   29 0F                AND #$0F
FC54   D0 04                BNE LFC5A
FC56   CA                   DEX
FC57   8A                   TXA
FC58   10 F6                BPL LFC50
FC5A   C9 02      LFC5A     CMP #$02
FC5C   68                   PLA
FC5D   24 82                BIT $82
FC5F   50 02                BVC LFC63
FC61   B0 02                BCS LFC65
FC63   E9 0B      LFC63     SBC #$0B
FC65   A6 D5      LFC65     LDX $D5
FC67   86 F2      LFC67     STX $F2
FC69   85 F8                STA $F8
FC6B   A9 0F                LDA #$0F
FC6D   85 F6                STA $F6
FC6F   A5 D6                LDA $D6
FC71   C9 05                CMP #$05
FC73   D0 2A                BNE LFC9F
FC75   8A                   TXA
FC76   29 07                AND #$07
FC78   AA                   TAX
FC79   45 F2                EOR $F2
FC7B   C9 30                CMP #$30
FC7D   D0 03                BNE LFC82
FC7F   4A                   LSR A
FC80   85 F6                STA $F6
FC82   8A         LFC82     TXA
FC83   18                   CLC
FC84   69 08                ADC #$08
FC86   AA                   TAX
FC87   E0 38                CPX #$38
FC89   B0 4D                BCS LFCD8
FC8B   B5 80                LDA $80,X
FC8D   29 0F                AND #$0F
FC8F   E4 F2                CPX $F2
FC91   49 0E                EOR #$0E
FC93   D0 04                BNE LFC99
FC95   C6 F6                DEC $F6
FC97   C6 F6                DEC $F6
FC99   49 08      LFC99     EOR #$08
FC9B   D0 E5                BNE LFC82
FC9D   90 28                BCC LFCC7
FC9F   90 7C      LFC9F     BCC LFD1D
FCA1   A0 03      LFCA1     LDY #$03
FCA3   88         LFCA3     DEY
FCA4   30 FB                BMI LFCA1
FCA6   8A                   TXA
FCA7   18                   CLC
FCA8   79 D2 FE             ADC $FED2,Y
FCAB   AA                   TAX
FCAC   29 07                AND #$07
FCAE   59 FB FE             EOR $FEFB,Y
FCB1   F0 F0                BEQ LFCA3
FCB3   8A                   TXA
FCB4   05 F2                ORA $F2
FCB6   E0 40                CPX #$40
FCB8   B0 08                BCS LFCC2
FCBA   B5 80                LDA $80,X
FCBC   29 0F                AND #$0F
FCBE   49 0E                EOR #$0E
FCC0   D0 E1                BNE LFCA3
FCC2   C6 F6      LFCC2     DEC $F6
FCC4   A8                   TAY
FCC5   D0 02                BNE LFCC9
FCC7   85 F6      LFCC7     STA $F6
FCC9   A6 E4      LFCC9     LDX $E4
FCCB   E0 04                CPX #$04
FCCD   B0 03                BCS LFCD2
FCCF   A5 D7                LDA $D7
FCD1   0A                   ASL A
FCD2   A4 D6      LFCD2     LDY $D6
FCD4   C0 06                CPY #$06
FCD6   F0 53                BEQ LFD2B
FCD8   A0 03      LFCD8     LDY #$03
FCDA   A6 F2      LFCDA     LDX $F2
FCDC   E4 D4                CPX $D4
FCDE   D0 06                BNE LFCE6
FCE0   C0 02                CPY #$02
FCE2   90 02                BCC LFCE6
FCE4   A6 D5                LDX $D5
FCE6   8A         LFCE6     TXA
FCE7   18                   CLC
FCE8   79 7E FF             ADC $FF7E,Y
FCEB   AA                   TAX
FCEC   45 F2                EOR $F2
FCEE   C9 08                CMP #$08
FCF0   90 04                BCC LFCF6
FCF2   29 C7                AND #$C7
FCF4   D0 13                BNE LFD09
FCF6   E4 D4      LFCF6     CPX $D4
FCF8   F0 EC                BEQ LFCE6
FCFA   B5 80                LDA $80,X
FCFC   29 0F                AND #$0F
FCFE   F0 E6                BEQ LFCE6
FD00   AA                   TAX
FD01   98                   TYA
FD02   4A                   LSR A
FD03   49 05                EOR #$05
FD05   E0 05                CPX #$05
FD07   F0 04                BEQ LFD0D
FD09   88         LFD09     DEY
FD0A   98                   TYA
FD0B   10 CD                BPL LFCDA
FD0D   38         LFD0D     SEC
FD0E   65 F6                ADC $F6
FD10   A6 D4                LDX $D4
FD12   49 FF                EOR #$FF
FD14   E4 F2                CPX $F2
FD16   F0 14                BEQ LFD2C
FD18   49 FF                EOR #$FF
FD1A   4C 67 FC             JMP LFC67
FD1D   4A         LFD1D     LSR A
FD1E   D0 08                BNE LFD28
FD20   CA                   DEX
FD21   CA                   DEX
FD22   A0 14                LDY #$14
FD24   E4 D4                CPX $D4
FD26   F0 02                BEQ LFD2A
FD28   A0 00      LFD28     LDY #$00
FD2A   98         LFD2A     TYA
FD2B   18         LFD2B     CLC
FD2C   65 F8      LFD2C     ADC $F8
FD2E   49 80                EOR #$80
FD30   85 F0                STA $F0
FD32   60                   RTS
FD33   A4 D4      LFD33     LDY $D4
FD35   A6 D5                LDX $D5
FD37   B9 80 00   LFD37     LDA $0080,Y
FD3A   29 0F                AND #$0F
FD3C   85 E9                STA $E9
FD3E   59 80 00             EOR $0080,Y
FD41   99 80 00             STA $0080,Y
FD44   B5 80      LFD44     LDA $80,X
FD46   29 F0                AND #$F0
FD48   05 E9                ORA $E9
FD4A   95 80                STA $80,X
FD4C   60                   RTS
FD4D   A6 D6      LFD4D     LDX $D6
FD4F   38                   SEC
FD50   CA                   DEX
FD51   F0 10                BEQ LFD63
FD53   CA                   DEX
FD54   CA                   DEX
FD55   CA                   DEX
FD56   30 05                BMI LFD5D
FD58   CA                   DEX
FD59   30 08                BMI LFD63
FD5B   D0 07                BNE LFD64
FD5D   A5 D8      LFD5D     LDA $D8
FD5F   29 F8                AND #$F8
FD61   85 D8                STA $D8
FD63   18         LFD63     CLC
FD64   60         LFD64     RTS
FD65   B9 D5 FE   LFD65     LDA $FED5,Y
FD68   18                   CLC
FD69   A4 D7                LDY $D7
FD6B   79 D5 FE             ADC $FED5,Y
FD6E   A8                   TAY
FD6F   A5 DA                LDA $DA
FD71   F0 0E                BEQ LFD81
FD73   45 E3                EOR $E3
FD75   10 0A                BPL LFD81
FD77   98                   TYA
FD78   18                   CLC
FD79   65 DA                ADC $DA
FD7B   F0 13                BEQ LFD90
FD7D   45 E3                EOR $E3
FD7F   10 0F                BPL LFD90
FD81   A5 E3      LFD81     LDA $E3
FD83   0A                   ASL A
FD84   98                   TYA
FD85   B0 04                BCS LFD8B
FD87   49 FF                EOR #$FF
FD89   69 01                ADC #$01
FD8B   49 80      LFD8B     EOR #$80
FD8D   C9 7B                CMP #$7B
FD8F   6A                   ROR A
FD90   60         LFD90     RTS
FD91   20 33 FD   LFD91     JSR LFD33
FD94   A2 3F                LDX #$3F
FD96   A9 04                LDA #$04
FD98   85 CA                STA $CA
FD9A   85 CC                STA $CC
FD9C   B5 80      LFD9C     LDA $80,X
FD9E   29 CF                AND #$CF
FDA0   95 80                STA $80,X
FDA2   29 0F                AND #$0F
FDA4   C9 08                CMP #$08
FDA6   29 07                AND #$07
FDA8   A8                   TAY
FDA9   B9 DD FE             LDA $FEDD,Y
FDAC   90 08                BCC LFDB6
FDAE   18                   CLC
FDAF   65 CA                ADC $CA
FDB1   85 CA                STA $CA
FDB3   4C BC FD             JMP LFDBC
FDB6   65 CC      LFDB6     ADC $CC
FDB8   B0 02                BCS LFDBC
FDBA   85 CC                STA $CC
FDBC   CA         LFDBC     DEX
FDBD   10 DD                BPL LFD9C
FDBF   86 F7                STX $F7
FDC1   A5 D6                LDA $D6
FDC3   29 07                AND #$07
FDC5   C9 06                CMP #$06
FDC7   D0 0D                BNE LFDD6
FDC9   A6 D4                LDX $D4
FDCB   8A                   TXA
FDCC   E5 D5                SBC $D5
FDCE   C9 F0                CMP #$F0
FDD0   F0 06                BEQ LFDD8
FDD2   C9 10                CMP #$10
FDD4   F0 02                BEQ LFDD8
FDD6   A2 80      LFDD6     LDX #$80
FDD8   86 E5      LFDD8     STX $E5
FDDA   A0 03                LDY #$03
FDDC   26 B4                ROL $B4
FDDE   38                   SEC
FDDF   66 B4                ROR $B4
FDE1   26 B7                ROL $B7
FDE3   38                   SEC
FDE4   66 B7                ROR $B7
FDE6   84 C1      LFDE6     STY $C1
FDE8   A9 BF                LDA #$BF
FDEA   39 88 00             AND $0088,Y
FDED   99 88 00             STA $0088,Y
FDF0   BE 76 FF             LDX $FF76,Y
FDF3   B5 80                LDA $80,X
FDF5   29 0F                AND #$0F
FDF7   85 CD                STA $CD
FDF9   55 80                EOR $80,X
FDFB   95 80                STA $80,X
FDFD   BE 7A FF             LDX LFF7A,Y
FE00   86 C0                STX $C0
FE02   98                   TYA
FE03   4A                   LSR A
FE04   B0 01                BCS LFE07
FE06   CA                   DEX
FE07   0A         LFE07     ASL A
FE08   69 FF                ADC #$FF
FE0A   85 E3                STA $E3
FE0C   B5 80                LDA $80,X
FE0E   15 81                ORA $81,X
FE10   15 82                ORA $82,X
FE12   29 0F                AND #$0F
FE14   D0 1F                BNE LFE35
FE16   A2 FE                LDX #$FE
FE18   86 D8                STX $D8
FE1A   86 D6                STX $D6
FE1C   A9 40                LDA #$40
FE1E   85 D4                STA $D4
FE20   20 95 FA   LFE20     JSR LFA95
FE23   A6 D4                LDX $D4
FE25   30 16                BMI LFE3D
FE27   A6 C0                LDX $C0
FE29   A0 02                LDY #$02
FE2B   E4 D5      LFE2B     CPX $D5
FE2D   F0 06                BEQ LFE35
FE2F   E8                   INX
FE30   88                   DEY
FE31   10 F8                BPL LFE2B
FE33   30 EB                BMI LFE20
FE35   A6 C1      LFE35     LDX $C1
FE37   B5 88                LDA $88,X
FE39   09 40                ORA #$40
FE3B   95 88                STA $88,X
FE3D   A4 C1      LFE3D     LDY $C1
FE3F   BE 76 FF             LDX $FF76,Y
FE42   20 66 FE             JSR LFE66
FE45   88                   DEY
FE46   10 9E                BPL LFDE6
FE48   20 DC F1             JSR LF1DC
FE4B   A2 05      LFE4B     LDX #$05
FE4D   BD FA FE   LFE4D     LDA $FEFA,X
FE50   C5 D4                CMP $D4
FE52   F0 04                BEQ LFE58
FE54   C5 D5                CMP $D5
FE56   D0 06                BNE LFE5E
FE58   A9 40      LFE58     LDA #$40
FE5A   15 82                ORA $82,X
FE5C   95 82                STA $82,X
FE5E   CA         LFE5E     DEX
FE5F   10 EC                BPL LFE4D
FE61   60                   RTS
FE62   A9 00      LFE62     LDA #$00
FE64   85 CD      LFE64     STA $CD
FE66   B5 80      LFE66     LDA $80,X
FE68   29 F0                AND #$F0
FE6A   05 CD                ORA $CD
FE6C   95 80                STA $80,X
FE6E   60                   RTS
FE6F   A9 09      LFE6F     LDA #$09
FE71   85 CC      LFE71     STA $CC
FE73   A6 D4                LDX $D4
FE75   55 80                EOR $80,X
FE77   A6 D5                LDX $D5
FE79   29 0F                AND #$0F
FE7B   F0 1E                BEQ LFE9B
FE7D   A9 FF      LFE7D     LDA #$FF
FE7F   85 CD                STA $CD
FE81   24 CD                BIT $CD
FE83   A2 3F                LDX #$3F
FE85   B5 80      LFE85     LDA $80,X
FE87   29 0F                AND #$0F
FE89   F0 0B                BEQ LFE96
FE8B   C5 CC                CMP $CC
FE8D   D0 04                BNE LFE93
FE8F   86 CD                STX $CD
FE91   F0 03                BEQ LFE96
FE93   90 01      LFE93     BCC LFE96
FE95   B8                   CLV
FE96   CA         LFE96     DEX
FE97   10 EC                BPL LFE85
FE99   A6 CD                LDX $CD
FE9B   60         LFE9B     RTS
FE9C   85 CC      LFE9C     STA $CC
FE9E   29 07                AND #$07
FEA0   85 CB                STA $CB
FEA2   45 CC                EOR $CC
FEA4   85 CC                STA $CC
FEA6   8A                   TXA
FEA7   29 07                AND #$07
FEA9   38                   SEC
FEAA   E5 CB                SBC $CB
FEAC   10 04                BPL LFEB2
FEAE   49 FF                EOR #$FF
FEB0   69 01                ADC #$01
FEB2   85 CD      LFEB2     STA $CD
FEB4   8A                   TXA
FEB5   29 38                AND #$38
FEB7   38                   SEC
FEB8   E5 CC                SBC $CC
FEBA   10 04                BPL LFEC0
FEBC   49 FF                EOR #$FF
FEBE   69 01                ADC #$01
FEC0   4A         LFEC0     LSR A
FEC1   4A                   LSR A
FEC2   4A                   LSR A
FEC3   65 CD                ADC $CD
FEC5   60                   RTS
FEC6   00                   BRK
FEC7   5E 85 00             LSR $0085,X
FECA   00                   BRK
FECB   75 E4                ADC $E4,X
FECD   00                   BRK
FECE   44                   ???                ;%01000100 'D'
FECF   33                   ???                ;%00110011 '3'
FED0   65 FD                ADC $FD
FED2   FF                   ???                ;%11111111
FED3   02                   ???                ;%00000010
FED4   07                   ???                ;%00000111
FED5   00                   BRK
FED6   BE E5 F7             LDX $F7E5,Y
FED9   F7                   ???                ;%11110111
FEDA   F1 FD                SBC ($FD),Y
FEDC   00                   BRK
FEDD   00                   BRK
FEDE   42                   ???                ;%01000010 'B'
FEDF   1B                   ???                ;%00011011
FEE0   09 09                ORA #$09
FEE2   0F                   ???                ;%00001111
FEE3   03                   ???                ;%00000011
FEE4   F8                   SED
FEE5   00                   BRK
FEE6   02                   ???                ;%00000010
FEE7   04                   ???                ;%00000100
FEE8   F0 01                BEQ LFEEB
FEEA   00                   BRK
FEEB   00         LFEEB     BRK
FEEC   FF                   ???                ;%11111111
FEED   02                   ???                ;%00000010
FEEE   03                   ???                ;%00000011
FEEF   04                   ???                ;%00000100
FEF0   00                   BRK
FEF1   03                   ???                ;%00000011
FEF2   05 04                ORA $04
FEF4   03                   ???                ;%00000011
FEF5   02                   ???                ;%00000010
FEF6   01 03                ORA ($03,X)
FEF8   04                   ???                ;%00000100
FEF9   05 04                ORA $04
FEFB   3C                   ???                ;%00111100 '<'
FEFC   00                   BRK
FEFD   07                   ???                ;%00000111
FEFE   38                   SEC
FEFF   3F                   ???                ;%00111111 '?'
FF00   00                   BRK
FF01   00                   BRK
FF02   00                   BRK
FF03   00                   BRK
FF04   00                   BRK
FF05   00                   BRK
FF06   00                   BRK
FF07   00                   BRK
FF08   FE FE D6             INC $D6FE,X
FF0B   92                   ???                ;%10010010
FF0C   38                   SEC
FF0D   10 00                BPL LFF0F
FF0F   00         LFF0F     BRK
FF10   FE 38 38             INC $3838,X
FF13   FE 6C AA             INC $AA6C,X
FF16   00                   BRK
FF17   00                   BRK
FF18   7C                   ???                ;%01111100 '|'
FF19   38                   SEC
FF1A   38                   SEC
FF1B   7C                   ???                ;%01111100 '|'
FF1C   38                   SEC
FF1D   10 00                BPL LFF1F
FF1F   00         LFF1F     BRK
FF20   F8                   SED
FF21   70 6C                BVS LFF8F
FF23   7E 74 38             ROR $3874,X
FF26   00                   BRK
FF27   00                   BRK
FF28   7C                   ???                ;%01111100 '|'
FF29   7C                   ???                ;%01111100 '|'
FF2A   7C                   ???                ;%01111100 '|'
FF2B   7C         LFF2B     ???                ;%01111100 '|'
FF2C   54                   ???                ;%01010100 'T'
FF2D   54                   ???                ;%01010100 'T'
FF2E   00                   BRK
FF2F   00                   BRK
FF30   38                   SEC
FF31   10 38                BPL LFF6B
FF33   10 00                BPL LFF35
FF35   00         LFF35     BRK
FF36   00                   BRK
FF37   00                   BRK
FF38   10 38                BPL LFF72
FF3A   92                   ???                ;%10010010
FF3B   D6 FE                DEC $FE,X
FF3D   FE 00 00             INC $0000,X
FF40   C6 6C                DEC $6C
FF42   38                   SEC
FF43   6C C6 00             JMP ($00C6)
FF46   30 30                BMI LFF78
FF48   30 30      LFF48     BMI LFF7A
FF4A   30 FC                BMI LFF48
FF4C   C0 FC                CPY #$FC
FF4E   0C                   ???                ;%00001100
FF4F   FC                   ???                ;%11111100
FF50   FC                   ???                ;%11111100
FF51   0C                   ???                ;%00001100
FF52   3C                   ???                ;%00111100 '<'
FF53   0C                   ???                ;%00001100
FF54   FC                   ???                ;%11111100
FF55   0C                   ???                ;%00001100
FF56   0C                   ???                ;%00001100
FF57   FC                   ???                ;%11111100
FF58   CC CC FC             CPY $FCCC
FF5B   0C                   ???                ;%00001100
FF5C   FC                   ???                ;%11111100
FF5D   C0 FC                CPY #$FC
FF5F   FC                   ???                ;%11111100
FF60   CC FC C0             CPY $C0FC
FF63   FC                   ???                ;%11111100
FF64   30 30                BMI LFF96
FF66   18                   CLC
FF67   0C                   ???                ;%00001100
FF68   FC                   ???                ;%11111100
FF69   FC                   ???                ;%11111100
FF6A   CC FC CC             CPY $CCFC
FF6D   FC                   ???                ;%11111100
FF6E   08                   PHP
FF6F   0A                   ASL A
FF70   0E 00 B0             ASL $B000
FF73   B4 BF                LDY $BF,X
FF75   5A                   ???                ;%01011010 'Z'
FF76   04                   ???                ;%00000100
FF77   04                   ???                ;%00000100
FF78   3C         LFF78     ???                ;%00111100 '<'
FF79   3C                   ???                ;%00111100 '<'
FF7A   02         LFF7A     ???                ;%00000010
FF7B   04                   ???                ;%00000100
FF7C   3A                   ???                ;%00111010 ':'
FF7D   3C                   ???                ;%00111100 '<'
FF7E   F8                   SED
FF7F   08                   PHP
FF80   FF                   ???                ;%11111111
FF81   01 09                ORA ($09,X)
FF83   10 99                BPL LFF1E
FF85   11 91                ORA ($91),Y
FF87   01 90                ORA ($90,X)
FF89   89                   ???                ;%10001001
FF8A   02                   ???                ;%00000010
FF8B   98                   TYA
FF8C   92                   ???                ;%10010010
FF8D   93                   ???                ;%10010011
FF8E   94 95                STY $95,X
FF90   96 97                STX $97,Y
FF92   98                   TYA
FF93   99 08 07             STA $0708,Y
FF96   06 05      LFF96     ASL $05
FF98   04                   ???                ;%00000100
FF99   03                   ???                ;%00000011
FF9A   02                   ???                ;%00000010
FF9B   01 80                ORA ($80,X)
FF9D   70 60                BVS LFFFF
FF9F   50 40                BVC LFFE1
FFA1   30 20                BMI LFFC3
FFA3   10 20                BPL LFFC5
FFA5   30 40                BMI LFFE7
FFA7   50 60                BVC $0009
FFA9   70 80                BVS LFF2B
FFAB   90 28                BCC LFFD5
FFAD   37                   ???                ;%00110111 '7'
FFAE   46 55                LSR $55
FFB0   64                   ???                ;%01100100 'd'
FFB1   73                   ???                ;%01110011 's'
FFB2   82                   ???                ;%10000010
FFB3   91 12                STA ($12),Y
FFB5   23                   ???                ;%00100011 '#'
FFB6   34                   ???                ;%00110100 '4'
FFB7   45 56                EOR $56
FFB9   67                   ???                ;%01100111 'g'
FFBA   78                   SEI
FFBB   89                   ???                ;%10001001
FFBC   88                   DEY
FFBD   77                   ???                ;%01110111 'w'
FFBE   66 55                ROR $55
FFC0   44                   ???                ;%01000100 'D'
FFC1   33                   ???                ;%00110011 '3'
FFC2   22                   ???                ;%00100010 '"'
FFC3   11 72      LFFC3     ORA ($72),Y
FFC5   63         LFFC5     ???                ;%01100011 'c'
FFC6   54                   ???                ;%01010100 'T'
FFC7   45 36                EOR $36
FFC9   27                   ???                ;%00100111 '''
FFCA   18                   CLC
FFCB   09 12                ORA #$12
FFCD   21 08                AND ($08,X)
FFCF   19 88 79             ORA $7988,Y
FFD2   81 92                STA ($92,X)
FFD4   20 80 10             JSR $1080
FFD7   90 09                BCC LFFE2
FFD9   91 11                STA ($11),Y
FFDB   89                   ???                ;%10001001
FFDC   09 91                ORA #$91
FFDE   11 89                ORA ($89),Y
FFE0   00                   BRK
FFE1   00         LFFE1     BRK
FFE2   10 90      LFFE2     BPL LFF74
FFE4   09 91                ORA #$91
FFE6   11 89                ORA ($89),Y
FFE8   FF                   ???                ;%11111111
FFE9   00                   BRK
FFEA   0A                   ASL A
FFEB   2A                   ROL A
FFEC   4A                   LSR A
FFED   0A                   ASL A
FFEE   52                   ???                ;%01010010 'R'
FFEF   08                   PHP
FFF0   40                   RTI
FFF1   20 08 20             JSR $2008
FFF4   0C                   ???                ;%00001100
FFF5   02                   ???                ;%00000010
FFF6   12                   ???                ;%00010010
FFF7   13                   ???                ;%00010011
FFF8   23                   ???                ;%00100011 '#'
FFF9   24 34                BIT $34
FFFB   56 00                LSR $00,X
FFFD   F0 00                BEQ LFFFF
FFFF   F0 00      LFFFF     BEQ $0001
                            .END

;auto-generated symbols and labels
 LF007      $F007
 LF2AD      $F2AD
 LF021      $F021
 LF030      $F030
 LF050      $F050
 LF2AA      $F2AA
 LF53C      $F53C
 LF075      $F075
 LF079      $F079
 LF07B      $F07B
 LFE64      $FE64
 LF094      $F094
 LF09A      $F09A
 LF090      $F090
 LF098      $F098
 LF096      $F096
 LF0A8      $F0A8
 LF0C8      $F0C8
 LF0BD      $F0BD
 LF0BA      $F0BA
 LF0CA      $F0CA
 LF0D9      $F0D9
 LF0E1      $F0E1
 LF545      $F545
 LF0F2      $F0F2
 LF1CF      $F1CF
 LF163      $F163
 LF17F      $F17F
 LF15B      $F15B
 LF182      $F182
 LF176      $F176
 LFD37      $FD37
 LF1A9      $F1A9
 LF1C1      $F1C1
 LF1C5      $F1C5
 LF183      $F183
 LF184      $F184
 LF18A      $F18A
 LF194      $F194
 LF209      $F209
 LF1DE      $F1DE
 LF1FB      $F1FB
 LF1FE      $F1FE
 LF27B      $F27B
 LF3E7      $F3E7
 LFE7D      $FE7D
 LF29A      $F29A
 LF2A2      $F2A2
 LF00F      $F00F
 LF2FF      $F2FF
 LF2B6      $F2B6
 LF2EC      $F2EC
 LF2E1      $F2E1
 LF520      $F520
 LF315      $F315
 LF30E      $F30E
 LF314      $F314
 LF35C      $F35C
 LF35D      $F35D
 LF354      $F354
 LF345      $F345
 LF3B9      $F3B9
 LF379      $F379
 LF3BF      $F3BF
 LFE62      $FE62
 LF383      $F383
 LFA95      $FA95
 LF3C3      $F3C3
 LF3B7      $F3B7
 LF3E6      $F3E6
 LF3B1      $F3B1
 LF3AF      $F3AF
 LF356      $F356
 LF3CC      $F3CC
 LF3DE      $F3DE
 LF3F5      $F3F5
 LF405      $F405
 LF41C      $F41C
 LF41B      $F41B
 LF419      $F419
 LF1DC      $F1DC
 LF46C      $F46C
 LF468      $F468
 LFD91      $FD91
 LF439      $F439
 LF448      $F448
 LF44E      $F44E
 LF452      $F452
 LF574      $F574
 LF4D6      $F4D6
 LF1E6      $F1E6
 LF497      $F497
 LF4BE      $F4BE
 LF495      $F495
 LFE4B      $FE4B
 LF4B9      $F4B9
 LF4CD      $F4CD
 LF13E      $F13E
 LF53B      $F53B
 LF4E3      $F4E3
 LF4F3      $F4F3
 LF4EC      $F4EC
 LF50E      $F50E
 LF519      $F519
 LF522      $F522
 LF534      $F534
 LF544      $F544
 LF532      $F532
 LF573      $F573
 LF54E      $F54E
 LF5D5      $F5D5
 LF64E      $F64E
 LF5CF      $F5CF
 LF5BB      $F5BB
 LFA66      $FA66
 LF5E9      $F5E9
 LF691      $F691
 LF664      $F664
 LF657      $F657
 LF606      $F606
 LF600      $F600
 LF8C6      $F8C6
 LF66D      $F66D
 LF5FD      $F5FD
 LF611      $F611
 LF9F5      $F9F5
 LFB91      $FB91
 LF64C      $F64C
 LF6EA      $F6EA
 LF5C1      $F5C1
 LF67F      $F67F
 LF687      $F687
 LF5DB      $F5DB
 LF689      $F689
 LF6A1      $F6A1
 LF6D1      $F6D1
 LFBB6      $FBB6
 LF6C5      $F6C5
 LF6DD      $F6DD
 LF6E4      $F6E4
 LFD4D      $FD4D
 LF5E2      $F5E2
 LF6FC      $F6FC
 LF782      $F782
 LF71C      $F71C
 LF775      $F775
 LF72E      $F72E
 LF768      $F768
 LFD81      $FD81
 LF747      $F747
 LF755      $F755
 LF76B      $F76B
 LF764      $F764
 LF761      $F761
 LF6E1      $F6E1
 LF77F      $F77F
 LF7A9      $F7A9
 LF79E      $F79E
 LF7C1      $F7C1
 LF7BA      $F7BA
 LF9EC      $F9EC
 LF7DF      $F7DF
 LFE71      $FE71
 LFE6F      $FE6F
 LFE9C      $FE9C
 LF7F4      $F7F4
 LF821      $F821
 LF817      $F817
 LFD65      $FD65
 LF97A      $F97A
 LF814      $F814
 LF836      $F836
 LF82C      $F82C
 LF877      $F877
 LF88B      $F88B
 LF88E      $F88E
 LFD33      $FD33
 LF8C3      $F8C3
 LFD44      $FD44
 LF8B7      $F8B7
 LF5AC      $F5AC
 LF940      $F940
 LF928      $F928
 LF93D      $F93D
 LF983      $F983
 LF96B      $F96B
 LF9B9      $F9B9
 LF9A1      $F9A1
 LF99E      $F99E
 LF9B1      $F9B1
 LF9AB      $F9AB
 LF9CB      $F9CB
 LF9DA      $F9DA
 LF9C1      $F9C1
 LF9E0      $F9E0
 LFA21      $FA21
 LFA30      $FA30
 LF582      $F582
 LFA4B      $FA4B
 LFA4D      $FA4D
 LF524      $F524
 LFAC8      $FAC8
 LFA68      $FA68
 LFA77      $FA77
 LFA8D      $FA8D
 LFACA      $FACA
 LFAD2      $FAD2
 LFACB      $FACB
 LFAB9      $FAB9
 LFA9B      $FA9B
 LFB19      $FB19
 LFB75      $FB75
 LFADD      $FADD
 LFAE9      $FAE9
 LFAF5      $FAF5
 LFB15      $FB15
 LFB22      $FB22
 LFA9D      $FA9D
 LFB85      $FB85
 LFB5D      $FB5D
 LFB54      $FB54
 LFA9F      $FA9F
 LFB8E      $FB8E
 LFB84      $FB84
 LFB68      $FB68
 LFBB3      $FBB3
 LFBC1      $FBC1
 LFBCE      $FBCE
 LFBEB      $FBEB
 LFBF9      $FBF9
 LFBF6      $FBF6
 LFBE7      $FBE7
 LFBF3      $FBF3
 LFC12      $FC12
 LFC08      $FC08
 LFC11      $FC11
 LFC3F      $FC3F
 LFC27      $FC27
 LFC3D      $FC3D
 LFC34      $FC34
 LFC3C      $FC3C
 LFC65      $FC65
 LFC5A      $FC5A
 LFC50      $FC50
 LFC63      $FC63
 LFC9F      $FC9F
 LFC82      $FC82
 LFCD8      $FCD8
 LFC99      $FC99
 LFCC7      $FCC7
 LFD1D      $FD1D
 LFCA1      $FCA1
 LFCA3      $FCA3
 LFCC2      $FCC2
 LFCC9      $FCC9
 LFCD2      $FCD2
 LFD2B      $FD2B
 LFCE6      $FCE6
 LFCF6      $FCF6
 LFD09      $FD09
 LFD0D      $FD0D
 LFCDA      $FCDA
 LFD2C      $FD2C
 LFC67      $FC67
 LFD28      $FD28
 LFD2A      $FD2A
 LFD63      $FD63
 LFD5D      $FD5D
 LFD64      $FD64
 LFD90      $FD90
 LFD8B      $FD8B
 LFDB6      $FDB6
 LFDBC      $FDBC
 LFD9C      $FD9C
 LFDD6      $FDD6
 LFDD8      $FDD8
 LFE07      $FE07
 LFE35      $FE35
 LFE3D      $FE3D
 LFE2B      $FE2B
 LFE20      $FE20
 LFE66      $FE66
 LFDE6      $FDE6
 LFE58      $FE58
 LFE5E      $FE5E
 LFE4D      $FE4D
 LFE9B      $FE9B
 LFE96      $FE96
 LFE93      $FE93
 LFE85      $FE85
 LFEB2      $FEB2
 LFEC0      $FEC0
 LFEEB      $FEEB
 LFF0F      $FF0F
 LFF1F      $FF1F
 LFF8F      $FF8F
 LFF6B      $FF6B
 LFF35      $FF35
 LFF72      $FF72
 LFF78      $FF78
 LFF7A      $FF7A
 LFF48      $FF48
 LFF96      $FF96
 LFF1E      $FF1E
 LFFFF      $FFFF
 LFFE1      $FFE1
 LFFC3      $FFC3
 LFFC5      $FFC5
 LFFE7      $FFE7
 LFF2B      $FF2B
 LFFD5      $FFD5
 LFFE2      $FFE2
 LFF74      $FF74

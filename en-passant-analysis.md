# Atari 2600 Video Chess - En Passant Implementation Analysis

Based on Stella memory dump observations, the Atari 2600 Video Chess uses a clever bit $80 system for en passant tracking:

## **Observed Behavior**

### Human Move: White Pawn A2-A4 (two squares)
- **New location ($A0)**: `0x0E` = white pawn without flags
- **Original square ($88)**: `0x80` = **flag bit remains set**

### Computer Response: Black Pawn E7-E5 (two squares)  
- **New location**: Black pawn without flags
- **Original square**: **Flag bit cleared** (no longer `0x86`)

## **En Passant Logic**

The bit $80 system works as follows:

1. **Initial State**: All pawns start with bit $80 set
   - White pawns: `0x8E` (0x80 | 0x08 | 0x06)
   - Black pawns: `0x86` (0x80 | 0x06)

2. **Two-Square Move**: When a pawn moves two squares:
   - **Destination**: Gets piece without bit $80 (normal moved pawn)
   - **Source**: **Retains bit $80** as en passant target marker

3. **En Passant Capture**: Enemy pawns can capture the square with bit $80
   - The bit $80 indicates "this square can be captured en passant"
   - After any other move, the bit $80 is cleared

4. **One-Square Move**: Normal pawn moves clear bit $80 entirely

## **Why This System Works**

- **Memory Efficient**: Uses existing board squares, no extra variables needed
- **Automatic Cleanup**: Bit $80 is cleared when the pawn moves again
- **Clear Target**: The bit $80 square is exactly where en passant capture occurs
- **Turn-Based**: Only one en passant opportunity can exist at a time

## **Implementation Implications**

The original square retaining bit $80 serves as:
1. **En passant target marker** - where the capture will occur
2. **Automatic expiration** - cleared on next pawn move
3. **Validation check** - only squares with bit $80 allow en passant

This is more elegant than tracking en passant with separate variables - the board itself remembers the capture opportunity!
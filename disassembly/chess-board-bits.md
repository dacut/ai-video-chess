# Atari 2600 Video Chess - Board Square Bit Encoding

Each square on the chess board ($80-$BF) uses an 8-bit value to encode piece information:

## Bit Layout (8-bit value)
```
Bit:  7   6   5   4   3   2   1   0
     [C] [C] [?] [?] [T] [T] [T] [T]
```

## Bit Meanings

### Color Encoding
- **Black pieces**: No color bit (0x00-0x0F range)
- **White pieces**: Bit 3 set (0x08 added to piece type)
- **Pawns**: Bit 7 set (0x80 added) for state tracking

### Bits 5-4: Additional Flags (0x30 mask)
- Used for special piece states or display information
- Exact usage varies by context in original code

### Bits 3-0: Piece Type (0x0F mask)
- `0000` (0) = Empty square
- `0001` (1) = King (based on FEF2 table)
- `0010` (2) = Queen  
- `0011` (3) = Bishop
- `0100` (4) = Knight
- `0101` (5) = Rook
- `0110` (6) = Pawn (based on F2BF-F2C5 pawn setup)
- `0111` (7) = Unused
- `1000-1111` (8-15) = Unused/special states

## Examples

### Black Pieces (no color bit)
- Black King: `0x01`
- Black Queen: `0x02`
- Black Bishop: `0x03`
- Black Knight: `0x04`
- Black Rook: `0x05`
- Black Pawn: `0x86` (0x80 | 0x06)

### White Pieces (bit 3 set)
- White King: `0x09` (0x08 | 0x01)
- White Queen: `0x0A` (0x08 | 0x02)
- White Bishop: `0x0B` (0x08 | 0x03)
- White Knight: `0x0C` (0x08 | 0x04)
- White Rook: `0x0D` (0x08 | 0x05)
- White Pawn: `0x8E` (0x80 | 0x08 | 0x06)

### Empty Square
- Empty: `0x00` = `00000000` = no color, no piece

## Code Usage

### Extracting Information
```python
piece_value = board[square]
piece_type = piece_value & 0x0F      # Get piece type (bits 0-3)
piece_color = piece_value & 0xC0     # Get color (bits 6-7)
is_white = piece_value & 0x40        # Check if white
is_black = piece_value & 0x80        # Check if black
is_empty = piece_value == 0          # Check if empty
```

### Creating Pieces
```python
white_king = 0x40 | 1    # 0x41
white_pawn = 0x40 | 6    # 0x46
black_king = 0x80 | 6    # 0x86
```

## Assembly Code References
- F2B6-F2D0: Board initialization using this encoding
- F195-F1BB: Display generation reads these bits
- Throughout: Piece type extracted with `AND #$07` or `AND #$0F`
- Throughout: Color checked with bit tests on 0x40/0x80
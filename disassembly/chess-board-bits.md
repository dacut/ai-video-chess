# Atari 2600 Video Chess - Board Square Bit Encoding

Each square on the chess board ($80-$BF) uses an 8-bit value to encode piece information:

## Bit Layout (8-bit value)
```
Bit:  7   6   5   4   3   2   1   0
     [C] [C] [?] [?] [T] [T] [T] [T]
```

## Bit Meanings

### Bits 7-6: Color Bits (0xC0 mask)
- `00` (0x00) = Empty square
- `01` (0x40) = White piece  
- `10` (0x80) = Black piece
- `11` (0xC0) = Invalid/unused

### Bits 5-4: Additional Flags (0x30 mask)
- Used for special piece states or display information
- Exact usage varies by context in original code

### Bits 3-0: Piece Type (0x0F mask)
- `0000` (0) = Empty square
- `0001` (1) = Pawn
- `0010` (2) = Queen  
- `0011` (3) = Bishop
- `0100` (4) = Knight
- `0101` (5) = Rook
- `0110` (6) = King
- `0111` (7) = Unused
- `1000-1111` (8-15) = Unused/special states

## Examples

### White Pieces
- White Pawn: `0x41` = `01000001` = 0x40 (white) | 0x01 (pawn)
- White Rook: `0x45` = `01000101` = 0x40 (white) | 0x05 (rook)  
- White King: `0x46` = `01000110` = 0x40 (white) | 0x06 (king)

### Black Pieces  
- Black Pawn: `0x81` = `10000001` = 0x80 (black) | 0x01 (pawn)
- Black Rook: `0x85` = `10000101` = 0x80 (black) | 0x05 (rook)
- Black King: `0x86` = `10000110` = 0x80 (black) | 0x06 (king)

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
white_pawn = 0x40 | 1    # 0x41
black_king = 0x80 | 6    # 0x86
```

## Assembly Code References
- F2B6-F2D0: Board initialization using this encoding
- F195-F1BB: Display generation reads these bits
- Throughout: Piece type extracted with `AND #$07` or `AND #$0F`
- Throughout: Color checked with bit tests on 0x40/0x80
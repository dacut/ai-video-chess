# Atari 2600 Video Chess - Difficulty Switch Functions

The Atari 2600 console switches ($0282 - SWCHB register) control special game modes:

## **Console Switch Layout ($0282)**
```
Bit:  7   6   5   4   3   2   1   0
     [R] [L] [?] [?] [?] [?] [R] [S]
     
R = RIGHT difficulty switch (bit 7)
L = LEFT difficulty switch (bit 6)  
R = RESET switch (bit 1)
S = SELECT switch (bit 0)
```

## **Switch Functions**

### **LEFT Difficulty Switch (Bit 6)**
- **Position A (bit 6 = 0)**: **Board Edit Mode**
  - Allows player to arbitrarily edit board positions
  - Can set up custom game states and positions
  - Used for puzzle solving or specific position analysis
- **Position B (bit 6 = 1)**: **Normal Play Mode**
  - Standard chess game with normal rules
  - Board editing disabled

### **RIGHT Difficulty Switch (Bit 7)**  
- **Position A (bit 7 = 0)**: **Computer Plays White**
  - Human player controls black pieces
  - Computer makes first move
  - Board display may be flipped for human perspective
- **Position B (bit 7 = 1)**: **Computer Plays Black**
  - Human player controls white pieces (default)
  - Human makes first move
  - Standard board orientation

## **Assembly Code References**

### **F2AA-F2AD**: Console switch reading
- Reads SWCHB ($0282) to get current switch positions
- Stores in $ED for later reference

### **F545-F54A**: Board flip logic
- Tests bit 7 of stored switches ($ED)
- If RIGHT DIFF = A, flips board for human playing black
- Implements perspective change for player convenience

### **Board Edit Mode Implementation**
- When LEFT DIFF = A, special input handling allows:
  - Cursor movement to any square
  - Piece placement/removal
  - Custom position setup
- Reset to Position B when setup complete

## **Usage Examples**

1. **Standard Game**: Both switches to B
2. **Play as Black**: RIGHT switch to A, LEFT to B  
3. **Setup Position**: LEFT switch to A, edit board, then to B
4. **Puzzle Mode**: LEFT to A, setup puzzle, RIGHT to A/B as needed

This gives players full control over game setup and piece colors, making the cartridge much more versatile than a simple chess opponent.
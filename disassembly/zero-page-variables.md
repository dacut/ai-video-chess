# Atari 2600 Video Chess - Zero Page Variable Mapping

Based on analysis of video-chess-annotated.s, here are the key zero page variables:

## Board and Game State
- `$80-$BF` - Chess board array (64 squares, 8x8 board)
- `$D3` - Game timer low byte
- `$D4` - Source square for moves
- `$D5` - Destination square for moves  
- `$D6` - Moving piece type
- `$D8` - Move distance/state
- `$D9` - Current position/cursor
- `$DA` - AI destination square
- `$DB` - Moving piece value
- `$DC` - Captured piece value
- `$DD` - Alternate position storage

## Game Control Variables
- `$E2` - Game flags
- `$E3` - Move execution flag
- `$E4` - Game difficulty level
- `$E5` - Castling flags
- `$E6` - Input state
- `$E7` - Move flags
- `$E8` - Display offset
- `$E9` - Random seed/processed input
- `$EA` - Speed counter/joystick state
- `$EB` - Input buffer/display buffer index
- `$ED` - Console switch state
- `$EE` - Current player

## AI and Evaluation
- `$F0` - Timer low byte
- `$F1` - Timer high byte  
- `$F2` - Difficulty level
- `$F3` - Move state
- `$F4` - Move timer
- `$F5` - Move validation flag
- `$F6` - Sound/move flag
- `$F7` - AI move choice
- `$F8` - Piece color
- `$F9` - Piece parameter
- `$FA` - X coordinate
- `$FB` - Another coordinate
- `$FC` - Display parameter
- `$FD` - Game state
- `$FE` - Display parameter

## Display Variables
- `$00` - VSYNC
- `$01` - VBLANK  
- `$02` - WSYNC
- `$04-$25` - Various display pointers and counters
- `$2A-$2B` - Temporary variables

## Python Implementation Mapping
Our VideoChess class variables correspond to:
- `self.board` → `$80-$BF` (board array)
- `self.source_square` → `$D4` (source square)
- `self.dest_square` → `$D5` (destination square)
- `self.moving_piece` → `$D6` (moving piece)
- `self.captured_piece` → `$DC` (captured piece)
- `self.current_player` → `$EE` (current player)
- `self.game_flags` → `$E2` (game flags)
- `self.castling_flags` → `$E5` (castling flags)
- `self.difficulty` → `$E4/$F2` (difficulty level)
- `self.move_state` → `$F3` (move state)
- `self.move_timer` → `$F4` (move timer)
- `self.game_timer` → `$D3/$F0/$F1` (game timers)
- `self.en_passant_square` → Not directly mapped (our addition)
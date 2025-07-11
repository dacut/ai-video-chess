"""
Atari 2600 Video Chess - Python Implementation
Replicates the core logic from the original ROM assembly code
"""

class VideoChess:
    def __init__(self):
        # Game state variables (equivalent to zero page memory)
        self.board = [0] * 64  # 8x8 chess board
        self.current_player = 0  # 0=white, 1=black
        self.game_timer = 0
        self.move_timer = 0
        self.difficulty = 0
        self.game_flags = 0
        self.castling_flags = 0
        
        # Move state
        self.source_square = 0
        self.dest_square = 0
        self.moving_piece = 0
        self.captured_piece = 0
        self.move_state = 0
        self.en_passant_square = -1  # Track en passant target square
        
        # Display and input
        self.joystick_state = 0
        self.console_switches = 0
        self.cursor_pos = 0
        
        # Piece values (from ROM data) - corrected mapping
        self.piece_values = [0, 100, 9, 3, 3, 5, 1]  # empty, king, queen, bishop, knight, rook, pawn
        
        # Initialize board to starting position
        self.init_board()
    
    def init_board(self):
        """Initialize chess board to starting position (F2B6-F2D0)"""
        # Clear board
        self.board = [0] * 64
        
        # Initial piece setup (back rank) - actual Atari encoding
        initial_pieces = [5, 4, 3, 2, 1, 3, 4, 5]  # rook, knight, bishop, queen, king, bishop, knight, rook
        
        # White pieces (bottom) - bit 3 set (0x08)
        for i in range(8):
            self.board[i] = initial_pieces[i] | 0x08  # white pieces
            self.board[i + 8] = 0x8E  # white pawns (0x80 | 0x08 | 0x06)
        
        # Black pieces (top) - no color bit
        for i in range(8):
            self.board[i + 48] = 0x86  # black pawns (0x80 | 0x06)
            self.board[i + 56] = initial_pieces[i]  # black pieces
        
        # Reset game state
        self.current_player = 0
        self.game_flags = 0
        self.castling_flags = 0xFF
        self.move_state = 0
    
    def main_loop(self):
        """Main game loop (F00F-F07B)"""
        while not (self.game_flags & 0x80):  # Continue until game over
            # Increment game timer
            self.game_timer = (self.game_timer + 1) & 0xFFFF
            
            # Read console switches and joystick
            self.read_input()
            
            # Process game logic based on current state
            if self.move_timer > 0:
                self.move_timer -= 1
            else:
                self.process_move()
            
            # Handle display and timing
            self.update_display()
    
    def read_input(self):
        """Read joystick and console switches (F4D6-F53B)"""
        # Simplified input reading - in real implementation would read hardware
        pass
    
    def process_move(self):
        """Process player/AI moves (F35D-F3E6)"""
        if self.current_player == 0:  # Human player
            self.process_human_move()
        else:  # Computer player
            self.process_ai_move()
    
    def process_human_move(self):
        """Process human player input (F46C-F4D5)"""
        if self.move_state == 0:
            # Select piece
            piece = self.board[self.cursor_pos]
            if piece & 0x08:  # White piece
                self.source_square = self.cursor_pos
                self.moving_piece = piece
                self.move_state = 1
        else:
            # Select destination
            self.dest_square = self.cursor_pos
            if self.validate_move():
                self.execute_move()
                self.current_player = 1
            self.move_state = 0
    
    def process_ai_move(self):
        """AI move generation (F41C-F468)"""
        best_move = self.find_best_move()
        if best_move:
            self.source_square, self.dest_square = best_move
            self.moving_piece = self.board[self.source_square]
            self.captured_piece = self.board[self.dest_square]
            self.execute_move()
            self.current_player = 0
    
    def find_best_move(self):
        """Simple AI move selection based on difficulty (F428-F465)"""
        moves = self.generate_moves(0x80)  # Black pieces
        if not moves:
            return None
        
        # Improved AI - prioritize captures and center control
        best_score = -999
        best_move = moves[0]
        
        for move in moves:
            score = self.evaluate_move(move)
            # Add positional bonus for center squares
            dest_row, dest_col = move[1] // 8, move[1] % 8
            if 2 <= dest_row <= 5 and 2 <= dest_col <= 5:
                score += 1
            
            if score > best_score:
                best_score = score
                best_move = move
        
        return best_move
    
    def generate_moves(self, color_mask):
        """Generate all legal moves for given color"""
        moves = []
        for sq in range(64):
            piece = self.board[sq]
            if piece & color_mask:
                piece_type = piece & 0x0F
                for dest in self.get_piece_moves(sq, piece_type):
                    if self.is_valid_move(sq, dest):
                        moves.append((sq, dest))
        return moves
    
    def get_piece_moves(self, square, piece_type):
        """Get possible moves for piece type (simplified)"""
        moves = []
        row, col = square // 8, square % 8
        
        if piece_type == 6:  # Pawn
            direction = 1 if self.board[square] & 0x08 else -1  # White moves up, black moves down
            new_row = row + direction
            
            # Forward move
            if 0 <= new_row < 8 and self.board[new_row * 8 + col] == 0:
                moves.append(new_row * 8 + col)
                
                # Two-square advance from starting position
                start_row = 1 if self.board[square] & 0x08 else 6
                if row == start_row and 0 <= new_row + direction < 8 and self.board[(new_row + direction) * 8 + col] == 0:
                    moves.append((new_row + direction) * 8 + col)
            
            # Diagonal captures
            for dc in [-1, 1]:
                if 0 <= new_row < 8 and 0 <= col + dc < 8:
                    target_square = new_row * 8 + (col + dc)
                    target_piece = self.board[target_square]
                    # Normal diagonal capture
                    if target_piece != 0 and (target_piece & 0x08) != (self.board[square] & 0x08):
                        moves.append(target_square)
                    # En passant capture
                    elif target_square == self.en_passant_square:
                        moves.append(target_square)
        
        elif piece_type == 3:  # Bishop
            for dr, dc in [(1,1), (1,-1), (-1,1), (-1,-1)]:
                for i in range(1, 8):
                    nr, nc = row + dr*i, col + dc*i
                    if 0 <= nr < 8 and 0 <= nc < 8:
                        moves.append(nr * 8 + nc)
                        if self.board[nr * 8 + nc] != 0:
                            break
        
        elif piece_type == 4:  # Knight
            knight_moves = [(2,1), (2,-1), (-2,1), (-2,-1), (1,2), (1,-2), (-1,2), (-1,-2)]
            for dr, dc in knight_moves:
                nr, nc = row + dr, col + dc
                if 0 <= nr < 8 and 0 <= nc < 8:
                    moves.append(nr * 8 + nc)
        
        elif piece_type == 5:  # Rook
            for dr, dc in [(0,1), (0,-1), (1,0), (-1,0)]:
                for i in range(1, 8):
                    nr, nc = row + dr*i, col + dc*i
                    if 0 <= nr < 8 and 0 <= nc < 8:
                        moves.append(nr * 8 + nc)
                        if self.board[nr * 8 + nc] != 0:
                            break
        
        elif piece_type == 2:  # Queen
            for dr, dc in [(0,1), (0,-1), (1,0), (-1,0), (1,1), (1,-1), (-1,1), (-1,-1)]:
                for i in range(1, 8):
                    nr, nc = row + dr*i, col + dc*i
                    if 0 <= nr < 8 and 0 <= nc < 8:
                        moves.append(nr * 8 + nc)
                        if self.board[nr * 8 + nc] != 0:
                            break
        
        elif piece_type == 1:  # King
            for dr, dc in [(0,1), (0,-1), (1,0), (-1,0), (1,1), (1,-1), (-1,1), (-1,-1)]:
                nr, nc = row + dr, col + dc
                if 0 <= nr < 8 and 0 <= nc < 8:
                    moves.append(nr * 8 + nc)
            
            # Castling moves
            if self.castling_flags != 0:  # If castling still possible
                is_white = self.board[square] & 0x40
                king_start = 4 if is_white else 60  # E1 for white, E8 for black
                
                if square == king_start:  # King hasn't moved
                    # Kingside castling
                    if (col < 7 and self.board[square + 1] == 0 and 
                        self.board[square + 2] == 0):
                        moves.append(square + 2)
                    
                    # Queenside castling  
                    if (col > 0 and self.board[square - 1] == 0 and 
                        self.board[square - 2] == 0 and self.board[square - 3] == 0):
                        moves.append(square - 2)
        
        return moves
    
    def validate_move(self):
        """Validate if current move is legal (F38D-F3B7)"""
        return self.is_valid_move(self.source_square, self.dest_square)
    
    def is_valid_move(self, source, dest):
        """Check if move from source to dest is valid"""
        if not (0 <= source < 64 and 0 <= dest < 64):
            return False
        
        source_piece = self.board[source]
        if source_piece == 0:
            return False
        
        dest_piece = self.board[dest]
        
        # Can't capture own piece
        if dest_piece != 0 and (source_piece & 0xC0) == (dest_piece & 0xC0):
            return False
        
        # Check if destination is in legal moves for this piece
        piece_type = source_piece & 0x0F
        legal_moves = self.get_piece_moves(source, piece_type)
        
        if dest not in legal_moves:
            return False
        
        # Basic check detection - don't allow king to move into attack
        if piece_type == 1:  # King
            return not self.is_square_attacked(dest, source_piece & 0xC0)
        
        return True
    
    def execute_move(self):
        """Execute the current move (F379-F383)"""
        # Clear previous en passant opportunity
        self.en_passant_square = -1
        
        # Handle special moves (castling, en passant)
        if self.is_special_move():
            self.handle_special_move()
        
        # Standard move
        self.captured_piece = self.board[self.dest_square]
        
        # Check for pawn two-square advance (sets up en passant)
        piece_type = self.moving_piece & 0x0F
        if piece_type == 1 and abs(self.dest_square - self.source_square) == 16:
            # Set en passant square behind the pawn
            self.en_passant_square = (self.source_square + self.dest_square) // 2
        
        # Check for king capture (game over)
        if self.captured_piece != 0 and (self.captured_piece & 0x0F) == 1:
            self.game_flags |= 0x80  # Set game over flag
        
        self.board[self.dest_square] = self.moving_piece
        self.board[self.source_square] = 0
        
        # Update game state
        self.update_game_state()
    
    def is_special_move(self):
        """Check for castling or en passant (F13E-F182)"""
        piece_type = self.moving_piece & 0x07
        
        # Check for castling (king moving 2 squares)
        if piece_type == 1:  # King
            if abs(self.dest_square - self.source_square) == 2:
                return True
        
        # Check for en passant (pawn diagonal capture to empty square)
        if piece_type == 6:  # Pawn
            if self.dest_square == self.en_passant_square:
                return True
        
        return False
    
    def handle_special_move(self):
        """Handle castling and en passant moves (F17F)"""
        piece_type = self.moving_piece & 0x07
        
        if piece_type == 1:  # Castling
            # Move rook as well
            if self.dest_square > self.source_square:  # Kingside
                rook_source = self.source_square + 3
                rook_dest = self.source_square + 1
            else:  # Queenside
                rook_source = self.source_square - 4
                rook_dest = self.source_square - 1
            
            self.board[rook_dest] = self.board[rook_source]
            self.board[rook_source] = 0
        
        elif piece_type == 6:  # En passant
            # Remove captured pawn (it's on the same rank as source, not destination)
            if self.dest_square == self.en_passant_square:
                captured_pawn_square = self.source_square + (self.dest_square % 8 - self.source_square % 8)
                self.board[captured_pawn_square] = 0
    
    def evaluate_move(self, move):
        """Evaluate move quality for AI (F430-F452)"""
        source, dest = move
        score = 0
        
        # Prefer captures
        if self.board[dest] != 0:
            captured_type = self.board[dest] & 0x0F
            score += self.piece_values[captured_type]
        
        # Add positional bonuses based on difficulty
        score += self.difficulty
        
        return score
    
    def update_game_state(self):
        """Update castling rights and other game state"""
        piece_type = self.moving_piece & 0x07
        
        # Update castling rights
        if piece_type == 1:  # King moved
            if self.moving_piece & 0x40:  # White king
                self.castling_flags &= 0xFC  # Clear white castling
            else:  # Black king
                self.castling_flags &= 0xF3  # Clear black castling
        
        elif piece_type == 5:  # Rook moved
            # Update castling based on rook position
            pass
    
    def update_display(self):
        """Update display (simplified - original has complex TIA programming)"""
        pass
    
    def get_board_state(self):
        """Get current board state for display"""
        return self.board.copy()
    
    def set_difficulty(self, level):
        """Set AI difficulty level (0-7)"""
        self.difficulty = max(0, min(7, level))
    
    def is_square_attacked(self, square, by_color):
        """Check if square is attacked by pieces of given color"""
        enemy_color = 0x80 if by_color == 0x40 else 0x40
        
        for sq in range(64):
            piece = self.board[sq]
            if piece & enemy_color:
                piece_type = piece & 0x0F
                moves = self.get_piece_moves(sq, piece_type)
                if square in moves:
                    return True
        return False

# Example usage
if __name__ == "__main__":
    game = VideoChess()
    game.main_loop()  # Start the game loop

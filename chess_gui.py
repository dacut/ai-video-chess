import pygame
import sys
from video_chess import VideoChess

class ChessGUI:
    def __init__(self):
        pygame.init()
        self.size = 640
        self.square_size = self.size // 8
        self.screen = pygame.display.set_mode((self.size + 40, self.size + 130))
        pygame.display.set_caption("Atari Video Chess")
        
        self.game = VideoChess()
        # Load fonts - 48pt for pieces, 36pt for UI text
        try:
            self.piece_font = pygame.font.Font('NotoSansSymbols2-Regular.ttf', 48)
            self.ui_font = pygame.font.Font(None, 36)
        except:
            # Fallback to system font if file not found
            self.piece_font = pygame.font.Font(None, 48)
            self.ui_font = pygame.font.Font(None, 36)
        
        self.input_text = ""
        self.game_over_message = ""
        
        # Colors
        self.WHITE = (240, 217, 181)
        self.BLACK = (181, 136, 99)
        self.HIGHLIGHT = (255, 255, 0)
        
        # Unicode chess piece symbols - corrected mapping
        self.pieces = {
            1: '♚', 2: '♛', 3: '♝', 4: '♞', 5: '♜', 6: '♟'  # Black
        }
        self.white_pieces = {
            1: '♔', 2: '♕', 3: '♗', 4: '♘', 5: '♖', 6: '♙'  # White
        }
    
    def draw_board(self):
        for row in range(8):
            for col in range(8):
                color = self.WHITE if (row + col) % 2 == 0 else self.BLACK
                rect = pygame.Rect(col * self.square_size, row * self.square_size, 
                                 self.square_size, self.square_size)
                pygame.draw.rect(self.screen, color, rect)
                
                # Draw piece (flip row for chess convention)
                square = (7 - row) * 8 + col
                piece = self.game.board[square]
                if piece != 0:
                    piece_type = piece & 0x0F
                    is_white = piece & 0x08
                    symbol = self.white_pieces[piece_type] if is_white else self.pieces[piece_type]
                    
                    text = self.piece_font.render(symbol, True, (0, 0, 0))
                    text_rect = text.get_rect(center=rect.center)
                    self.screen.blit(text, text_rect)
        
        # Draw column letters (A-H) at bottom
        for col in range(8):
            letter = chr(ord('A') + col)
            text = self.ui_font.render(letter, True, (0, 0, 0))
            x = col * self.square_size + self.square_size // 2 - text.get_width() // 2
            self.screen.blit(text, (x, self.size + 5))
        
        # Draw row numbers (1-8) on right side
        for row in range(8):
            number = str(8 - row)  # Chess rows are numbered 8-1 from top to bottom
            text = self.ui_font.render(number, True, (0, 0, 0))
            y = row * self.square_size + self.square_size // 2 - text.get_height() // 2
            self.screen.blit(text, (self.size + 5, y))
    
    def draw_ui(self):
        # Check for game over
        if self.game.game_flags & 0x80:
            if not self.game_over_message:
                winner = "White" if self.game.captured_piece & 0x80 else "Black"
                self.game_over_message = f"Game Over! {winner} wins!"
        
        if self.game_over_message:
            # Game over message
            text = self.ui_font.render(self.game_over_message, True, (255, 0, 0))
            self.screen.blit(text, (10, self.size + 50))
        else:
            # Input area
            input_rect = pygame.Rect(10, self.size + 40, self.size - 20, 40)
            pygame.draw.rect(self.screen, (255, 255, 255), input_rect)
            pygame.draw.rect(self.screen, (0, 0, 0), input_rect, 2)
            
            # Input text
            text = self.ui_font.render(f"Move: {self.input_text}", True, (0, 0, 0))
            self.screen.blit(text, (15, self.size + 50))
            
            # Instructions
            inst = self.ui_font.render("Enter move (e.g., A2 B4 or A2B4)", True, (0, 0, 0))
            self.screen.blit(inst, (10, self.size + 90))
    
    def parse_move(self, text):
        """Parse simple notation like 'A2 B4' or 'A2B4'"""
        text = text.upper().replace(' ', '')
        if len(text) != 4:
            return None
        
        try:
            from_col = ord(text[0]) - ord('A')
            from_row = int(text[1]) - 1
            to_col = ord(text[2]) - ord('A')
            to_row = int(text[3]) - 1
            
            if not all(0 <= x < 8 for x in [from_col, from_row, to_col, to_row]):
                return None
            
            from_square = from_row * 8 + from_col
            to_square = to_row * 8 + to_col
            return from_square, to_square
        except:
            return None
    
    def make_move(self, from_square, to_square):
        """Execute move if valid"""
        if self.game.board[from_square] & 0x08:  # White piece
            self.game.source_square = from_square
            self.game.dest_square = to_square
            self.game.moving_piece = self.game.board[from_square]
            
            if self.game.validate_move():
                self.game.execute_move()
                self.game.current_player = 1
                return True
        return False
    
    def run(self):
        clock = pygame.time.Clock()
        
        while True:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    sys.exit()
                
                elif event.type == pygame.KEYDOWN and not (self.game.game_flags & 0x80):
                    if event.key == pygame.K_RETURN:
                        move = self.parse_move(self.input_text)
                        if move and self.make_move(*move):
                            # AI move
                            self.game.process_ai_move()
                        self.input_text = ""
                    
                    elif event.key == pygame.K_BACKSPACE:
                        self.input_text = self.input_text[:-1]
                    
                    else:
                        self.input_text += event.unicode
            
            self.screen.fill((200, 200, 200))
            self.draw_board()
            self.draw_ui()
            pygame.display.flip()
            clock.tick(60)

if __name__ == "__main__":
    gui = ChessGUI()
    gui.run()
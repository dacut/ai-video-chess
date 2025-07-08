#![allow(dead_code)] // Remove once we're done documenting constants

/// Game state for Video Chess
pub struct VideoChess {
    /// RAM on the Atarti 2600; the lower 128 bytes are not present and unused.
    /// Only the bytes from 0x80-0xff are available.
    pub ram: [u8; 256],
}

/// The base address for the chess board in RAM.
const BOARD_BASE: usize = 0x80;

/// Game timer ($D3)
const GAME_TIMER_D3: usize = 0xd3;

/// Unknown ($D4)
const UNKNOWN_D4: usize = 0xd4;

/// Unknown ($D5)
const UNKNOWN_D5: usize = 0xd5;

/// Unknown ($D6)
const UNKNOWN_D6: usize = 0xd6;

/// Unknown ($D7)
const UNKNOWN_D7: usize = 0xd7;

/// Unknown ($D8)
const UNKNOWN_D8: usize = 0xd8;

/// Unknown ($D9)
const UNKNOWN_D9: usize = 0xd9;

/// Unknown ($DA)
const UNKNOWN_DA: usize = 0xda;

/// Unknown ($DB)
const UNKNOWN_DB: usize = 0xdb;

/// Unknown ($DC)
const UNKNOWN_DC: usize = 0xdc;

/// Unknown ($DD)
const UNKNOWN_DD: usize = 0xdd;

/// Game flags ($E2)
const GAME_FLAGS_E2: usize = 0xe2;

/// Move flags ($E5)
/// FIXME: How is this different from MOVE_FLAGS_E7?
const MOVE_FLAGS_E5: usize = 0xe5;

/// Console switches ($ED)
const CONSOLE_SWITCHES_ED: usize = 0xed;

/// Difficulty setting in RAM ($E4).
const DIFFICULTY_E4: usize = 0xe4;

/// Move flags ($E7)
/// FIXME: How is this different from MOVE_FLAGS_E5?
const MOVE_FLAGS_E7: usize = 0xe7;

/// Random seed ($E9)
const RANDOM_SEED_E9: usize = 0xe9;

/// Current player ($EE)
const CURRENT_PLAYER_EE: usize = 0xee;

/// Timer high byte
const TIMER_HIGH_F0: usize = 0xf0;

/// Timer low byte
const TIMER_LOW_F1: usize = 0xf1;

/// Move state ($F3)
const MOVE_STATE_F3: usize = 0xf3;

/// Move timer ($F4)
const MOVE_TIMER_F4: usize = 0xf4;

/// Unknown ($F5)
const UNKNOWN_F5: usize = 0xf5;

/// Unknown ($F6)
const UNKNOWN_F6: usize = 0xf6;

/// AI state ($F7)
const AI_STATE_F7: usize = 0xf7;

/// Piece value: King
const KING: u8 = 1;
/// Piece value: Queen
const QUEEN: u8 = 2;
/// Piece value: Bishop
const BISHOP: u8 = 3;
/// Piece value: Knight
const KNIGHT: u8 = 4;
/// Piece value: Rook
const ROOK: u8 = 5;
/// Piece value: Pawn
const PAWN: u8 = 6;

/// Piece flag: white
const WHITE: u8 = 0x08;

/// Piece flag: en passant tracking for white pawn
const EN_PASSANT_WHITE: u8 = 0x80;

/// Piece flag: en passant tracking for black pawn
const EN_PASSANT_BLACK: u8 = 0x40;


/// The initial layout of the top and bottom ranks, $FEF2-FEF9
const HIGHER_RANK_INIT: [u8; 8] = [
    ROOK,
    KNIGHT,
    BISHOP,
    QUEEN,
    KING,
    BISHOP,
    KNIGHT,
    ROOK,
];

impl VideoChess {
    /// Board setup, $F2AA-$F2FC
    /// This omits reading and handling select/reset inputs.
    #[allow(clippy::erasing_op, clippy::identity_op)]
    pub fn board_setup(&mut self) {
        // $F2B2: Set game difficulty to 0
        self.ram[DIFFICULTY_E4] = 0;

        // Initialize tiles, $F2B6-$F2CF
        for (col, piece) in HIGHER_RANK_INIT.iter().enumerate() {
            // Higher ranks, $F2B6-$F2BD
            self.ram[BOARD_BASE + 0 * 8 + col] = *piece;
            self.ram[BOARD_BASE + 7 * 8 + col] = *piece | WHITE;

            // Pawns, $F2BF-F2C5
            self.ram[BOARD_BASE + 6 * 8 + col] = PAWN | WHITE | EN_PASSANT_WHITE;
            self.ram[BOARD_BASE + 1 * 8 + col] = PAWN | EN_PASSANT_BLACK;

            // Clear middle ranks, $F2C7-$F2CF
            for row in 2..6 { 
                self.ram[BOARD_BASE + row * 8 + col] = 0;
            }
        }

        // Clear game flags, $F2D2
        self.ram[GAME_FLAGS_E2] = 0xff;

        // Clear AI state, $F2D5
        self.ram[AI_STATE_F7] = 0xff;

        // Clear move flags, $F2D6
        self.ram[MOVE_FLAGS_E5] = 0xff;

        // TODO: Handle $F2DC-$F2EA

        // Clear move state, $F2EC
        self.ram[MOVE_STATE_F3] = 0;

        // Clear move flags at E7, $F2EE
        self.ram[MOVE_FLAGS_E7] = 0;

        // Set current player to white (why is this 3?), #F2F0
        self.ram[CURRENT_PLAYER_EE] = 3;

        // Set $D5, $D4, and $D8 to 0x46 (black pawn en passant) shifted right by 1 == 0x23.
        // FIXME: Why?
        self.ram[UNKNOWN_D5] = 0x23;
        self.ram[UNKNOWN_D4] = 0x23;
        self.ram[UNKNOWN_D8] = 0x23;

        // Tail call to game_init at $F520, $F2FC
        self.game_init(0);

        // Normally falls through to main_loop, but we'll let the caller handle that.
    }

    /// Game initialization, $F520-$F53B
    /// This is called at the end of board setup.
    pub fn game_init(&mut self, arg: u8) {
        // Store in $D6 (?), $F520
        self.ram[UNKNOWN_D6] = arg;

        // Store in $D7 (?), $F522
        self.ram[UNKNOWN_D7] = arg;

        // Reset game timer, $F524-$F528
        self.ram[TIMER_LOW_F1] = 0;
        self.ram[TIMER_HIGH_F0] = 0;

        // Initialize move timer to 32, $F52A-F52C
        self.ram[MOVE_TIMER_F4] = 32;

        // Clear unknowns at $F5 and $F6
        // FIXME: What are these?
        self.ram[UNKNOWN_F5] = 0;
        self.ram[UNKNOWN_F6] = 0;

        // Copy board state from $D4-D8 to $D9-DD, $F532-$F539
        for i in 0..5 {
            self.ram[UNKNOWN_D9 + i] = self.ram[UNKNOWN_D4 + i];
        }
    }

    /// Main game loop, $F00F-
    pub fn main_loop(&mut self) {
        // TIA WSYNC/VSYNC/VBLANK ignored - $F00F-$F015
        // A set to 0xff here.

        // Increment game timer, $F017
        self.ram[GAME_TIMER_D3] = self.ram[GAME_TIMER_D3].wrapping_add(1);

        // Check if game timer overflowed, $F019
        if self.ram[GAME_TIMER_D3] == 0 {
            // Increment the regular timer, $F01B
            self.ram[TIMER_LOW_F1] = self.ram[TIMER_LOW_F1].wrapping_add(1);

            // Check if the low byte of the regular timer overflowed, $F01D
            if self.ram[TIMER_LOW_F1] == 0 {
                // Set the high byte of the regular timer to a == 0xff, $F01F
                // FIXME: Why 0xff and not increment?
                self.ram[TIMER_HIGH_F0] = 0xff;
            }
        }

        // Update random number seed, $F021-$F025
        let a = self.ram[TIMER_HIGH_F0] ^ 0xff;
        let a = a | 0xf7;
        self.ram[RANDOM_SEED_E9] = a;
    }
}

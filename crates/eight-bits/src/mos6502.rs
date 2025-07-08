
#[derive(Clone, Copy, Debug)]
pub struct Mos6502Emu {
    // CPU registers
    pub a: u8,      // Accumulator
    pub x: u8,      // X register
    pub y: u8,      // Y register
    pub sp: u8,     // Stack pointer
    pub pc: u16,    // Program counter
    pub status: Mos6502StatusBits, // Processor status
}

#[derive(Clone, Copy, Debug)]
pub struct Mos6502StatusBits(u8);

impl Default for Mos6502Emu {
    fn default() -> Self {
        Self {
            a: 0,
            x: 0,
            y: 0,
            sp: 0xFD, // Stack pointer starts at 0xFD
            pc: 0xfffc,
            status: Mos6502StatusBits::default(),
        }
    }
}

impl Mos6502Emu {
    /// Reset the CPU as if the reset pin was asserted.
    /// 
    /// This does *not* reset the CPU to the initial power-on state! The MOS 6502 only changes
    /// the program counter, subtracts 3 from the stack pointer, and disables interrupts.
    /// No other registers are changed.
    #[inline(always)]
    pub fn reset(&mut self) {
        self.sp = self.sp.wrapping_sub(3);
        self.pc = 0xfffc;
        self.status.set_interrupt_disable(true);
    }
}

impl Default for Mos6502StatusBits {
    fn default() -> Self {
        Self(0x24) // Default status with unused bit set
    }
}

impl Mos6502StatusBits {
    #[inline(always)]
    pub fn get_bits(&self) -> u8 {
        self.0
    }

    #[inline(always)]
    pub fn set_bits(&mut self, value: u8) {
        self.0 = value;
    }

    #[inline(always)]
    pub fn get_carry(&self) -> bool {
        self.0 & 0x01 != 0
    }

    #[inline(always)]
    pub fn set_carry(&mut self, value: bool) {
        if value {
            self.0 |= 0x01;
        } else {
            self.0 &= !0x01;
        }
    }

    #[inline(always)]
    pub fn get_zero(&self) -> bool {
        self.0 & 0x02 != 0
    }

    #[inline(always)]
    pub fn set_zero(&mut self, value: bool) {
        if value {
            self.0 |= 0x02;
        } else {
            self.0 &= !0x02;
        }
    }

    #[inline(always)]
    pub fn get_interrupt_disable(&self) -> bool {
        self.0 & 0x04 != 0
    }

    #[inline(always)]
    pub fn set_interrupt_disable(&mut self, value: bool) {
        if value {
            self.0 |= 0x04;
        } else {
            self.0 &= !0x04;
        }
    }

    #[inline(always)]
    pub fn get_decimal_mode(&self) -> bool {
        self.0 & 0x08 != 0
    }

    #[inline(always)]
    pub fn set_decimal_mode(&mut self, value: bool) {
        if value {
            self.0 |= 0x08;
        } else {
            self.0 &= !0x08;
        }
    }

    #[inline(always)]
    pub fn get_break(&self) -> bool {
        self.0 & 0x10 != 0
    }

    #[inline(always)]
    pub fn set_break(&mut self, value: bool) {
        if value {
            self.0 |= 0x10;
        } else {
            self.0 &= !0x10;
        }
    }

    #[inline(always)]
    pub fn get_overflow(&self) -> bool {
        self.0 & 0x40 != 0
    }

    #[inline(always)]
    pub fn set_overflow(&mut self, value: bool) {
        if value {
            self.0 |= 0x40;
        } else {
            self.0 &= !0x40;
        }
    }

    #[inline(always)]
    pub fn get_negative(&self) -> bool {
        self.0 & 0x80 != 0
    }

    #[inline(always)]
    pub fn set_negative(&mut self, value: bool) {
        if value {
            self.0 |= 0x80;
        } else {
            self.0 &= !0x80;
        }
    }
}
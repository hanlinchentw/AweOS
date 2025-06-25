#include "../drivers/ports.h"

void main() 
{
	/* Screen cursor position: ask VGA control register (0x3d4) for bytes
     * 14 = high byte of cursor and 15 = low byte of cursor. */
	port_byte_out(0x3d4, 14);  /* Requesting byte 14: high byte of cursor pos */

	int position = port_byte_in(0x3d5); /* Data is returned in VGA data register (0x3d5) */
	position = position << 8; /* high byte, e.g, 0x10 << 8 = 0x1000 */

	port_byte_out(0x3d4, 15); /* requesting low byte */
	position |= port_byte_in(0x3d5); /* add low byte, 0x1000 | 0x2C = 0x102C = Cursor cell index */

	int offset_from_vga = position * 2; // Each character takes 2 bytes in VGA memory
	char *vga = (char *) 0xb8000;
	vga[offset_from_vga] = 'X';
	vga[offset_from_vga + 1] = 0x0f; // White on black
}

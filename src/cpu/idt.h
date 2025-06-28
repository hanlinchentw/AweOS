#ifndef IDT_H
#define IDT_H

#include "types.h"

#define KERNEL_CS 0x08

typedef struct
{
  u16 low_offset; // Lower 16 bits of handler function address
  u16 sel;        // Kernel segment selector
  u8 always0;
  u8 flags;
  u16 high_offset; // Higher 16 bits of handler function address
} __attribute__((packed)) idt_gate_t;

typedef struct
{
  u16 limit;
  u32 base;
} __attribute((packed)) idt_register_t;

#define IDT_ENTRIES 256
extern idt_gate_t idt[IDT_ENTRIES];
extern idt_register_t idt_reg;

void set_idt_gate(int n, u32 handler);
void set_idt();

#endif
#include "idt.h"

idt_gate_t idt[IDT_ENTRIES];
idt_register_t idt_reg;

void set_idt_gate(int n, u32 handler)
{
  idt[n].low_offset = low_16(handler);
  // KERNEL_CS=0x08,
  // So 0x08 means: Use the second GDT entry (which is usually the kernel code segment) in GDT, ring 0.
  // sel = 0x08 tells the CPU to jump to the kernel code segment
  idt[n].sel = KERNEL_CS;
  idt[n].always0 = 0;
  idt[n].flags = 0x8E;
  idt[n].high_offset = high_16(handler);
}

void set_idt()
{
  idt_reg.base = (u32)&idt;
  idt_reg.limit = IDT_ENTRIES * sizeof(idt_gate_t) - 1;
  __asm__ __volatile__("lidtl (%0)" : : "r" (&idt_reg));
}

# 🧠 AweOS

**AweOS** is a minimal educational microkernel built from scratch. It’s my personal systems programming journey — from booting into kernel space to serving HTTP over raw Ethernet. Think of it as a hands-on operating system walkthrough, one milestone at a time.

---

## 🚀 What It Does

* Boots from a custom bootloader (or GRUB)
* Handles keyboard I/O and logging
* Manages memory (physical & virtual)
* Reads files from a minimal in-memory filesystem
* Implements a basic TCP/IP stack
* Serves HTTP requests over real or emulated network interfaces

---

## 🧭 Weekly Progress

### 🔰 Week 1 – Boot & Kernel Basics

* Set up folder structure: `boot/`, `kernel/`, `build/`
* Display “Hello from kernel” via VGA text buffer
* Bootable with QEMU or Bochs
* Added `Makefile` for automated builds

### 💬 Week 2 – Basic I/O & Logging

* Implemented keyboard scan code reader
* Built `kprintf()` for kernel-level logging
* Wrote first interactive shell: echo typed input
* Cleaned up boot logs for readability

### 🧠 Week 3 – Memory Management

* Physical memory allocator (bitmap-based)
* Basic paging with page tables
* Simple heap: `malloc()` and `free()`
* Tested with dynamic buffers and data structures

### 💾 Week 4 – Minimal File System

* Fake file system (hardcoded in kernel binary)
* API: `read_file(path)` loads files into memory
* Parsed and displayed `/www/index.html`

### 🌐 Week 5 – Networking (Part 1)

* Wrote NIC driver for RTL8139 (QEMU-compatible)
* Sent and received Ethernet frames
* Implemented ARP and basic IPv4 packet handling
* Able to ping from inside the OS

### 🔄 Week 6 – Networking (Part 2 - TCP)

* Parsed TCP headers
* 3-way handshake (SYN, SYN-ACK, ACK)
* Created basic `tcp_listen()` and `tcp_read()` API

### 📡 Week 7 – HTTP Request Parsing

* Parsed basic `GET /path HTTP/1.1` requests
* Routed requests to in-memory files in `/www/`
* Returned HTTP/1.1 200 OK + file contents
* Returned 404 for missing files

### 🧪 Week 8 – Testing the Web Server

* Served `index.html` in browser via HTTP
* Logged requests and status codes
* Optimized buffer sizes for performance

### 🧰 Week 9 – OS Cleanup & Robustness

* Improved memory safety and error handling
* Added minimal scheduler (round-robin)
* Restructured code: `fs/`, `net/`, `http/`, `kernel/`

### 🎁 Week 10 – Polish & Optional Features

* MIME type detection (`.html`, `.css`, `.js`)
* Optional: static IP and basic DHCP
* Visual UI: shell panel + log panel
* ISO image + USB support
* [ ] Publish source code and documentation

---

## 🧾 Summary of Milestones

| Milestone                 | Week    |
| ------------------------- | ------- |
| Bootable kernel           | Week 1  |
| Keyboard input + logging  | Week 2  |
| Memory management         | Week 3  |
| Fake file system          | Week 4  |
| Ethernet + IPv4           | Week 5  |
| TCP stack basics          | Week 6  |
| HTTP parsing              | Week 7  |
| Serve files over HTTP     | Week 8  |
| Robust multitasking (WIP) | Week 9  |
| Final polish + ISO        | Week 10 |

---

## 🛠 Tech Stack

* **Language**: C, Assembly (x86)
* **Tools**: QEMU, Make, GDB, NASM
* **Concepts**: Memory management, paging, interrupts, networking (Ethernet, ARP, IP, TCP)

---

## 📦 Build & Run

```bash
make run   # boots the OS in QEMU
make iso   # build bootable ISO image
```

> Requirements: `nasm`, `qemu`, `make`, `gcc`

---

## 📚 Inspiration

* [os-tutorial](https://github.com/cfenollosa/os-tutorial/)
* [JamesM's Kernel Dev Tutorials](http://www.jamesmolloy.co.uk/tutorial_html/)
* [OSDev Wiki](https://wiki.osdev.org/Main_Page)
* [Writing a TCP/IP Stack](https://nicoleorchard.dev/posts/writing-a-tcp-stack/)

---

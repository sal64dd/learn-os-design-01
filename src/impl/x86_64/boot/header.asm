section .multiboot_header
header_start:
  ; magic
  dd 0xE85250D6 ; multiboot2
  ; arch
  dd 0 ; protected i386
  ; header size
  dd header_end - header_start
  ; checksum
  dd 0x100000000 - (0xE85250D6 + 0 + (header_end - header_start))
  ; type
  dw 0
  ; flags
  dw 0
  ; size
  dd 8
header_end:
kernal_source_files := $(shell find src/impl/kernal -name *.c)
kernal_object_files := $(patsubst src/impl/kernal/%.c, build/kernal/%.o, $(kernal_source_files))

x86_64_c_source_files := $(shell find src/impl/x86_64 -name *.c)
x86_64_c_object_files := $(patsubst src/impl/x86_64/%.c, build/x86_64/%.o, $(x86_64_c_source_files))

x86_64_asm_source_files := $(shell find src/impl/x86_64 -name *.asm)
x86_64_asm_object_files := $(patsubst src/impl/x86_64/%.asm, build/x86_64/%.o, $(x86_64_asm_source_files))

x86_64_object_files := $(x86_64_c_object_files) $(x86_64_asm_object_files)

$(x86_64_c_object_files): build/x86_64/%.o : src/impl/x86_64/%.c
	mkdir -p $(dir $@) && \
	x86_64-elf-gcc -c -I src/intf -ffreestanding $(patsubst build/x86_64/%.o, src/impl/x86_64/%.c, $@) -o $@

$(kernal_object_files): build/kernal/%.o :src/impl/kernal/%.c
	mkdir -p $(dir $@) && \
	x86_64-elf-gcc -c -I src/intf -ffreestanding $(patsubst build/kernal/%.o, src/impl/kernal/%.c, $@) -o $@


$(x86_64_asm_object_files): build/x86_64/%.o : src/impl/x86_64/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $(patsubst build/x86_64/%.o, src/impl/x86_64/%.asm, $@) -o $@ 

.PHONY: build-x86_64
build-x86_64: $(kernal_object_files) $(x86_64_object_files)
	mkdir -p dist/x86_64 && \
	x86_64-elf-ld -n -o dist/x86_64/kernal.bin -T targets/x86_64/linker.ld $(kernal_object_files) $(x86_64_object_files)
	cp dist/x86_64/kernal.bin targets/x86_64/iso/boot/kernal.bin && \
	grub-mkrescue /usr/lib/grub/i386-pc -o dist/x86_64/kernal.iso targets/x86_64/iso

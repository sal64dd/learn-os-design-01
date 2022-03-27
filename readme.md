# Run Docker
docker run --rm -it -v ${pwd}:/root/env myos-buildenv

# Build OS
make build-x86_64

# Run OS in QEMU
 qemu-system-x86_64.exe -cdrom .\dist\x86_64\kernal.iso
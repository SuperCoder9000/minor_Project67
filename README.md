do these:

sudo apt install -y nasm qemu-system-x86 git && git clone 

https://github.com/SuperCoder9000/minor_Project67.git && cd minor_Project67/day3 && nasm boot.asm -f bin -o boot.bin && nasm kernel.asm -f bin -o kernel.bin && cat boot.bin kernel.bin > os-image.bin && qemu-system-x86_64 -fda os-image.bin
read -p "Enter new vm name: " NAME
read -p "Which version of linux (eg Ubuntu): " LINUX

vboxmanage createvm --name $NAME --ostype $LINUX"_64" --register --basefolder `pwd`

read -p "Memory: " RAM
read -p "Vram: " VRAM
read -p "CPUs: " CPU

vboxmanage modifyvm $NAME --ioapic on
vboxmanage modifyvm $NAME --memory $RAM --vram $VRAM
vboxmanage modifyvm $NAME --nic1 nat
vboxmanage modifyvm $NAME --cpus $CPU

read -p "Disk size: " DISK

vboxmanage createhd --filename `pwd`/$NAME/$NAME_DISK.vdi --size $DISK --format VDI
vboxmanage storagectl $NAME --name "SATA Controller" --add sata --controller IntelAHCI
vboxmanage storageattach $NAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  `pwd`/$NAME/$NAME_DISK.vdi

vboxmanage storagectl $NAME --name "IDE Controller" --add ide --controller PIIX4
vboxmanage storageattach $NAME --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "/c/Users/OnlyO/VirtualBox VMs/iso/$LINUX.iso"

echo "/c/Users/OnlyO/VirtualBox VMs/iso/$LINUX.iso"
vboxmanage modifyvm $NAME  --boot1 dvd --boot2 disk --boot3 none --boot4 none

vboxmanage modifyvm $NAME --vrde on
vboxmanage modifyvm $NAME --vrdemulticon on --vrdeport 10001
vboxmanage startvm $NAME

# installSwapfile
Install a swap file on the NVIDIA Jetson Nano Developer Kit. This should help with memory pressure issues.

### Setup Swap File
> installSwapFile.sh - Create a swap file ; Use on external media like USB drive or SSD

> usage: installSwapFile [[[-d directory ] [-s size] -a] | [-h]]
>
> -d | --dir [directoryname]   Directory to place swapfile (defaults to /mnt)
>
> -s | --size [gigabytes] (defaults to 6 )
>
> -a | --auto  Enable swap on boot in /etc/fstab (defaults enabled)
>
> -h | --help  This message
>
> Defaults to creating a 6GB Swapfile in the current directory
>
> Note: If you enable swap on boot, you should also automount the drive that you're using



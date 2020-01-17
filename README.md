# installSwapfile
<b><em>Note: While you can still use this method to add a swap file, note that </b>newer versions of L4T/JetPack have swap memory as part of the default distribution, implemented through zram. You may choose to use both a swapfile, as implemented here, and the zram swap memory at the same time.</em>

Original article on JetsonHacks: https://wp.me/p7ZgI9-1ac

Install a swap file on the NVIDIA Jetson Nano Developer Kit. This should help with memory pressure issues.

### Setup Swap File
> installSwapFile.sh - Create a swap file ; Use on external media like USB drive or SSD

> usage: installSwapFile.sh [[[-d directory ] [-s size] -a] | [-h]]
>
> -d | --dir [directoryname]   Directory to place swapfile (defaults to /mnt)
>
> -s | --size [gigabytes] (defaults to 6 )
>
> -a | --auto  Enable swap on boot in /etc/fstab (default: "Y")
>
> -h | --help  This message
>
> Defaults to creating a 6GB Swapfile in the current directory
>
> Note: If you enable swap on boot, you should also automount the drive that you're using

### Automount
Automount a device given the label
> autoMount.sh - Automount a device, useful for external media like USB drives

> usage: autoMount.sh [ [-l label] | [-h]]
>
> -l | --label  [labelname]   Label to lookup
>
> -h | --help  This message
>
> Example usage:
>
> $ ./shellScript.sh -l RaceUSB
>
> where RaceUSB is the label of the device mounted at /media/jetsonhacks/RaceUSB
>
> Tool to help automount the device given from the label
> The script looks up the device, mounting point and UUID for the given label
> Optionally add it to /etc/fstab

<h2>Release Notes</h2>

v0.7 April 2019
* Add Automount Support
* L4T 32.1.0 (JetPack 4.2)
* Tested on Jetson Nano

Initial Release April, 2019
* L4T 32.1.0 (JetPack 4.2)
* Tested on Jetson Nano


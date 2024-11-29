# arch-chroot

Instructions on how to perform `chroot` into a **Btrfs**-based
installation. Before that, the volume must be decrypted.

```sh
# mount -o subvol=@ /dev/sdXY /mnt
# mount -o subvol=@home /dev/sdXY /mnt/home
# mount -o subvol=@pkg /dev/sdXY /mnt/var/cache/pacman/pkg
# mount -o subvol=@log /dev/sdXY /mnt/var/log
# mount -o subvol=@snapshots /dev/sdXY /mnt/.snapshots
# mount /dev/sdXZ /mnt/boot
# arch-chroot /mnt
```

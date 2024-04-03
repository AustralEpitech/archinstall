# archinstall
My personal Arch install script. It automates from step 2 of ArchWiki's
[Installation guide](https://wiki.archlinux.org/title/Installation_guide#Installation)
and more!

## HOW-TO
Follow the [Pre-installation](https://wiki.archlinux.org/title/Installation_guide#Pre-installation).
Once you mounted the partitions, clone this script
```bash
git clone https://git.maby.dev/ange/archinstall /tmp/ai && cd "$_"
```

To install the base system, run:
```bash
$EDITOR config
./base.sh
```

If you want a desktop install:
```bash
$EDITOR ./desktop/config
./desktop/install.sh

$EDITOR ./desktop/$WM/config
./desktop/$WM/install.sh
```

For the dotfiles, run the script as the newly created user:
```bash
su - $user -c ./dotfiles.sh
```

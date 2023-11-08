# archinstall
My personal Arch install script. It automates from step 2 of ArchWiki's
[Installation guide](https://wiki.archlinux.org/title/Installation_guide) and
more!

## How to
Follow the [Pre-installation](https://wiki.archlinux.org/title/Installation_guide#Pre-installation).
Once you chrooted in the system, clone this script
```bash
git clone https://git.maby.dev/ange/archinstall /tmp/ai && cd $_
```

To install the base system, run:
```bash
$EDITOR config
./base.sh
```

If you want to install a gui
```bash
$EDITOR ./gui/config
./gui/install.sh

$EDITOR ./gui/$GUI/config
./gui/$GUI/install.sh
```

For the dotfiles, run the script as the newly created user:
```bash
su $user -c ./dotfiles.sh
```

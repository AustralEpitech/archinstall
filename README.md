# archinstall

My personal Arch install script. It automates from step 2 of ArchWiki's
[Installation guide](https://wiki.archlinux.org/title/Installation_guide)
and more!

## How to

Follow the [Pre-installation](https://wiki.archlinux.org/title/Installation_guide#Pre-installation).
Once you chrooted in the system, clone this script
```bash
git clone https://git.maby.dev/ange/archinstall /tmp/ai && cd $_
```

**Review and edit the `config` file before running any script!**

To install the base system, run:
```bash
./base.sh
```

If you want a post install script, login as a normal user and run (replace
*desktopEnvironment* with your choice):
```bash
./desktopEnvironment/install.sh
```

For the dotfiles, run the script as the new user:
```bash
su $user -c ./dotfiles.sh
```

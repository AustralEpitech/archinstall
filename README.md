# archinstall
My personal Arch install script.

## HOW-TO
Install git, clone the script, edit the `config` file to match your preferences
and run the `install.sh` script.

```bash
pacman -Sy git
git clone https://git.gmoker.com/ange/archinstall.git
cd archinstall
$EDITOR config
./install.sh
```

## Extend
If you want to extend this script, simply place your own commands in a `.sh`
file in `modules/**/` depending on when you need it to be executed.

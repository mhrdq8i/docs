# NoeVim

## Installation

According this link [Install nvim][installation]

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
```

Then add this to your shell config (`~/.bashrc`, `~/. zshrc`, ...)
or create soft link

```bash
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/bin/nvim
```

**Note:** Be careful to have installed last version of 'nvim'

## Configuration

create neovim config path at first

```bash
mkdir ~/.config/nvim/
```

### Better way for your config is **lazy**

Make a backup of your current Neovim files

```bash
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

Clone the starter

```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
```

Remove the `.git` folder, so you can add it to your own repo later

```bash
rm -rf ~/.config/nvim/.git
```

Start Neovim!

```bash
nvim
```

<!-- links -->
[installation]: https://github.com/neovim/neovim/blob/master/INSTALL.md

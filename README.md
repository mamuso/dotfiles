# Mamuso's dotfiles

I was inpired by [Nicola Paolucci's article](https://www.atlassian.com/git/tutorials/dotfiles) about storing and consuming dotfiles.

These are my dotfiles (for macOS), you are free to take anything you want, but at your own risk.

## Installation

Befor installing, make sure you have installed `git` and `curl`:

```bash

sudo softwareupdate -i -a
xcode-select --install
```

Then, you can install the dotfiles by running the following command:

```
curl -Lks https://raw.githubusercontent.com/mamuso/.dotfiles/main/.init/install.sh | /bin/bash
```

## Post-installation

Make sure that your terminal app has full disk access, otherwise some features may not work as expected. You can do this by going to `System Preferences > Security & Privacy > Privacy > Full Disk Access` and adding your terminal app.

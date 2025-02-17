# m104's nvim configuration files

## Installation

1. Fork and clone this project to your home directory:

```sh
git clone --recursive git@github.com:$GITUSER/nvim-config.git ~/.config/nvim
```

2. For python3/black support:

```sh
pip3 install --upgrade pynvim
pip3 install --upgrade git+https://github.com/psf/black.git
```

3. Install the plugins:

```sh
nvim +PlugInstall +UpdateRemotePlugins +qall
```

Enjoy!

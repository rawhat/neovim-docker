# neovim-docker

This is a (super simple) `Dockerfile` to pull down `neovim`, install
`packer`, and set up a ridiculously basic `init.lua` file.

You can `docker build -t neovim .` and `docker run -it neovim` and get into
a shell.  Once there, feel free to... install whatever plugins.

I made this to troubleshoot a keybind issue, so it's pretty extensible with
regards to adding or removing plugins.

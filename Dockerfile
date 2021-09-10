FROM ubuntu:latest

RUN apt update && apt install -y curl git sudo

RUN useradd alex && usermod -aG sudo alex

RUN mkdir -p /home/alex/bin
ENV PATH="/home/alex/bin:${PATH}"

WORKDIR /home/alex

# Install `neovim`
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage && \
  chmod +x /home/alex/nvim.appimage && \
  ./nvim.appimage --appimage-extract && \
  chmod +x /home/alex/squashfs-root/usr/bin/nvim && \
  ln -s /home/alex/squashfs-root/usr/bin/nvim /home/alex/bin/nvim

# Install `packer`
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim /home/alex/.local/share/nvim/site/pack/packer/start/packer.nvim

COPY init.lua /home/alex/.config/nvim/

RUN chown -R alex /home/alex

USER alex

CMD ["nvim"]

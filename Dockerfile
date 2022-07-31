FROM ubuntu:latest

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y curl git sudo ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip doxygen nodejs npm

RUN useradd alex && usermod -aG sudo alex
RUN echo 'alex:pass' | chpasswd

RUN mkdir -p /home/alex/bin
ENV PATH="/home/alex/bin:${PATH}"

WORKDIR /home/alex

RUN git clone https://github.com/neovim/neovim && cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install

# Install `packer`
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim /home/alex/.local/share/nvim/site/pack/packer/start/packer.nvim

COPY init.lua /home/alex/.config/nvim/

RUN chown -R alex /home/alex
RUN echo 'alex  ALL=(ALL) /bin/su' >>  /etc/sudoers

USER alex

RUN npm i tree-sitter-cli && cp node_modules/tree-sitter-cli/tree-sitter ~/bin/tree-sitter && chmod +x ~/bin/tree-sitter

CMD ["/bin/bash"]

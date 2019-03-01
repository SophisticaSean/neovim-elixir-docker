FROM python:3.6.5-stretch

ENV DEBIAN_URL "http://ftp.us.debian.org/debian"

RUN echo "deb $DEBIAN_URL testing main contrib non-free" >> /etc/apt/sources.list \
  && apt-get update                                             \
  && apt-get install -y                                         \
    autoconf                                                    \
    automake                                                    \
    cmake                                                       \
    fish                                                        \
    g++                                                         \
    gettext                                                     \
    git                                                         \
    libtool                                                     \
    libtool-bin                                                 \
    lua5.3                                                      \
    ninja-build                                                 \
    pkg-config                                                  \
    unzip                                                       \
    xclip                                                       \
    xfonts-utils                                                \
    elixir  \
    wget \
    git \
    erlang-ssl  \
    erlang-inets \
  && apt-get clean all

RUN cd /usr/src                                                 \
  && git clone https://github.com/neovim/neovim.git             \
  && cd neovim                                                  \
  && make CMAKE_BUILD_TYPE=RelWithDebInfo                       \
          CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local" \
  && make install                                               \
  && rm -r /usr/src/neovim

ENV PATH "$HOME/.local/bin:${PATH}"

RUN mkdir -p $HOME/.config/nvim/colors $HOME/.SpaceVim.d

# download elixir and erlang otp source code
RUN mkdir -p /usr/local/share/src && \
    cd /usr/local/share/src && \
    git clone https://github.com/elixir-lang/elixir.git && \
    git clone https://github.com/erlang/otp.git

RUN pip install --user neovim pipenv

RUN apt-get install -y zsh

COPY ./nvimrc /root/.config/nvim/init.vim
COPY ./srcery.vim /root/.config/nvim/colors/srcery.vim

# install nvim plugin deps
RUN curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
  sh ./installer.sh ~/.cache/dein && \
  rm ./installer.sh && \
  nvim --headless +'call dein#install()' +qall

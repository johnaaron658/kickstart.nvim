FROM debian

# Set image locale.
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TZ=Asia/Manila

EXPOSE 8080 8081 8082 8083 8084 8085

# Update repositories and install software:
# 1. curl.
# 2. fzf for fast file search.
# 3. ripgrep for fast text occurrence search.
# 4. tree for files tree visualization.
# 5. Git.
# 6. Lazygit for Git visualization.
# 7. xclip for clipboard handling.
# 8. Python 3.
# 9. pip for Python.
# 10. NodeJS.
# 11. npm for NodeJS.
# 12. tzdata to set default container timezone.
# 13. Everything needed to install Neovim from source.
RUN apt-get update 
RUN apt-get -y install curl 
RUN apt-get -y install fzf 
RUN apt-get -y install ripgrep 
RUN apt-get -y install tree 
RUN apt-get -y install git 
RUN apt-get -y install xclip 
RUN apt-get -y install python3 
RUN apt-get -y install python3-pip 
RUN apt-get -y install nodejs 
RUN apt-get -y install npm 
RUN apt-get -y install tzdata 
RUN apt-get -y install ninja-build 
RUN apt-get -y install gettext 
RUN apt-get -y install libtool 
RUN apt-get -y install libtool-bin 
RUN apt-get -y install autoconf 
RUN apt-get -y install automake 
RUN apt-get -y install cmake 
RUN apt-get -y install g++ 
RUN apt-get -y install pkg-config 
RUN apt-get -y install zip 
RUN apt-get -y install unzip 


# Create TMP dir
RUN mkdir -p /root/TMP

# Lazygit variables
ARG LG='lazygit'
ARG LG_GITHUB='https://github.com/jesseduffield/lazygit/releases/download/v0.31.4/lazygit_0.31.4_Linux_x86_64.tar.gz'
ARG LG_ARCHIVE='lazygit.tar.gz'

# Install Lazygit from binary
RUN cd /root/TMP && curl -L -o $LG_ARCHIVE $LG_GITHUB
RUN cd /root/TMP && tar xzvf $LG_ARCHIVE && mv $LG /usr/bin/

# Install Neovim from source.
RUN cd /root/TMP && git clone https://github.com/neovim/neovim
RUN cd /root/TMP/neovim && git checkout stable && make -j4 && make install

# Remove TMP dir
RUN rm -rf /root/TMP

# Create directory for Neovim configuration files.
RUN mkdir -p /root/.config/nvim

# Copy Neovim configuration files.
COPY ./init.lua /root/.config/nvim
COPY ./snippets /root/.config/nvim/snippets
COPY ./lua /root/.config/nvim/lua
COPY ./lazy-lock.json /root/.config/nvim/

# Create directory for projects (there should be mounted from host).
RUN mkdir -p /root/workspace

# Set default location after container startup.
WORKDIR /root/workspace

# Avoid container exit.
CMD ["tail", "-f", "/dev/null"]

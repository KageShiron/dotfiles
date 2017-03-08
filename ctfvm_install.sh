#!/bin/bash
if [ ${EUID:-${UID}} != 0 ]; then
    echo "This script runs in only root"
    exit
fi
# based on https://gist.github.com/K-atc/750b1da15dc42aa1f3f41a31e74a0208

cd $HOME
pwd

# ■common
apt-get update
apt-get upgrade -y
apt-get install -y vim mux gdb gdbserver socat binutils nasm python git autoconf libtool make || \
    (echo "[!] apt-get stall failed"; exit)
apt-get install -y vim-gtk
apt-get install -y virtualbox-guest-dkms 

# ■pwnlib
apt-get install -y python2.7-dev python-pip
pip install pwntools
 
# ■peda
cd $HOME
git clone https://github.com/longld/peda.git $HOME/peda
echo source $HOME/peda/peda.py >> $HOME/.gdbinit
 
# ■rp++
cd $HOME
wget -q https://github.com/downloads/0vercl0k/rp/rp-lin-x64
chmod +x rp-lin-x64 && mv rp-lin-x64 /usr/local/bin
 
# ■disas-seccomp-filter
cd $HOME
git clone git://github.com/seccomp/libseccomp && cd libseccomp
./autogen.sh && ./configure && make
cp tools/scmp_bpf_disasm tools/scmp_sys_resolver /usr/local/bin
wget -q https://raw.githubusercontent.com/akiym/akitools/master/disas-seccomp-filter
chmod +x disas-seccomp-filter && mv disas-seccomp-filter /usr/local/bin


# 以下，使うかどうかわからないけど取り敢えず
 
# ■libheap
cd $HOME
apt-get install -y libc6-dbg || \
    (echo "[!] apt-get install failed"; exit)
wget -q http://pastebin.com/raw/8Mx8A1zG -O libheap.py
echo 'from .libheap import *' > __init__.py
mkdir -p /usr/local/lib/python3.4/dist-packages/libheap/
mv libheap.py __init__.py /usr/local/lib/python3.4/dist-packages/libheap/
echo -e 'define heap\n  python from libheap import *\nend' >> $HOME/.gdbinit
 
# ■katana
cd $HOME
apt-get -y install libelf-dev libdwarf-dev libunwind8-dev libreadline-dev bison flex g++
git clone git://git.savannah.nongnu.org/katana.git && cd katana
ls /usr/bin/aclocal-1.15 || ln -s /usr/bin/aclocal-1.14 /usr/bin/aclocal-1.15
ls /usr/bin/automake-1.15 || ln -s /usr/bin/automake-1.14 /usr/bin/automake-1.15
sed -i '784,787d' src/patchwrite/patchwrite.c
sed -i '783a\int res=dwarf_producer_init(flags,dwarfWriteSectionCallback,dwarfErrorHandler,NULL,&err);' src/patchwrite/patchwrite.c
./configure && make
sed -i 's/\($(AM_V_CCLD).*\)/\1 $(lebtest_LDFLAGS)/' tests/code/Makefile
make && make install



# ■my
DOTDIR="$HOME/dotfiles"
cd "${DOTDIR}"
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

mkdir ~/.vim
ln -si ./.bashrc ~/.bashrc
ln -si ./.vimrc ~/.vimrc
ln -si ./.gvimrc ~/.gvimrc
ln -si ./dein.toml ~/.vim/dein.toml

echo "[+] bootstrap.sh done!"



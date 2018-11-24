#/bin/bash

WORKDIR=`pwd`

echo "start at ${WORKDIR}"

PLUG_INSTALL_DIR=~/.config/nvim/autoload/plug.vim
if [ ! -f ${PLUG_INSTALL_DIR} ]; then
	echo "install vim-plug ..."
	curl -fLo ${PLUG_INSTALL_DIR} --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
	echo 'plug.vim detected, skip install ...'
fi

VIMSCRIPTS=(
	plugins.vim
	plugins_settings.vim
	basic_config.vim
	keymap.vim
	language.vim
	.ycm_extra_conf.py
)

echo 'copy vim scripts to ~/.vim/config/'
mkdir -p ~/.vim/config/

for item in ${VIMSCRIPTS[*]}
do
	cp ${WORKDIR}/${item} ~/.vim/config/${item}
done

echo 'install entrance.vim to autoload dir'
mkdir -p ~/.config/nvim/autoload
cp ${WORKDIR}/entrance.vim ~/.config/nvim/autoload/entrance.vim

NVIM_INIT_FILE=~/.config/nvim/init.vim
if [ ! -f ${NVIM_INIT_FILE} ]; then
	mkdir -p '~/.config/nvim/'
	echo 'call entrance#Main()' > ${NVIM_INIT_FILE}
	echo "install load scripts in ${NVIM_INIT_FILE}"
else
	echo 'now you can add "call entrance#Main()" at ~/.config/nvim/init.vim'
fi

echo 'install done'



if [ ! -e $HOME/.bashrc ]; then
	ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
	echo "install done"
fi

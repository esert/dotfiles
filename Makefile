install:
	cd; rm -rf .profile .bash_profile .bashrc .prompt .emacs .emacs.d
	cp -a .profile .prompt .emacs.d ~
	cd; ln -s .profile .bash_profile; ln -s .profile .bashrc

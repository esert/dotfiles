install:
	cd; rm -rf .profile .bash_profile .bashrc .prompt .emacs .emacs.d
	cp .profile .prompt .emacs ~
	cd; ln -s .profile .bash_profile; ln -s .profile .bashrc

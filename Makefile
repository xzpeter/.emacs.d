default: init
emacsfile=~/.emacs
user_files='.ecb-user-layouts.el .tmux.conf .gitconfig .bashrc .vimrc .inputrc'
makelog=/tmp/emacs-make.log
file=$(shell ls HyperSpec*.gz)
.PHONY: init clean build_packages cp_user_files install_hyperspec config_mutt

init: install_hyperspec build_packages cp_user_files config_mutt
	@echo "### ALL DONE! ###"

config_mutt:
	@echo "Copy MUTT config"
	@ln -s ${PWD}/.mutt ${HOME}/

install_hyperspec:
	@echo "unpacking HyperSpec..."
	@tar zxvf ${file} &>${makelog}
	@rm -rf ._HyperSpec

build_packages: 
	@echo "making org..."
	@echo "make sure emacs.el load at emacs startup... "
	@grep -q '.emacs.d/lisp/emacs.el' ${emacsfile} || \
		echo '(load "~/.emacs.d/lisp/emacs.el")' >> ${emacsfile}

cp_user_files:
	@echo "copying user files (${user_files})..."
	@for f in ${user_files}; do\
		ln -f $$f ~/;\
	done &>${makelog}

clean:
	@(cd cedet-1.1; make clean-autoloads; make clean-all; cd ..;) &>${makelog}
	@(cd ecb-2.40; make clean; cd ..;) &>${makelog}
	@rm -rf HyperSpec/
	@echo "### CLEANED! ###"

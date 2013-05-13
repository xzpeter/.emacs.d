default: init
emacsfile=~/.emacs
user_files='.ecb-user-layouts.el .tmux.conf .gitconfig .bashrc'
makelog=/tmp/emacs-make.log
file=$(shell ls HyperSpec*.gz)
.PHONY: init clean build_packages cp_user_files install_hyperspec

init: install_hyperspec build_packages cp_user_files 
	@echo "### ALL DONE! ###"

install_hyperspec:
	@echo "unpacking HyperSpec..."
	@tar zxvf ${file} &>${makelog}

build_packages: 
	@echo "making cedet..."
	@(cd cedet-1.1; make; cd ..;) &>${makelog}
	@echo "making ecb..."
	@(cd ecb-2.40; make; cd ..;) &>${makelog}
	@echo "making org..."
	@(cd org-7.7; make; cd ..;) &>${makelog}
	@echo "make sure emacs.el load at emacs startup... "
	@grep -q '.emacs.d/emacs.el' ${emacsfile} || \
		echo '(load "~/.emacs.d/emacs.el")' >> ${emacsfile}

cp_user_files:
	@echo "copying user files (${user_files})..."
	@for f in ${user_files}; do\
		ln -f $$f ~/;\
	done &>${makelog}

clean:
	@(cd cedet-1.1; make clean-autoloads; make clean-all; cd ..;) &>${makelog}
	@(cd ecb-2.40; make clean; cd ..;) &>${makelog}
	@(cd org-7.7; make clean; cd ..;) &>${makelog}
	@rm -rf HyperSpec/
	@echo "### CLEANED! ###"

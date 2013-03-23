default: init
emacsfile=~/.emacs

init:
	cd cedet-1.1; make; cd ..;
	cd ecb-2.40; make; cd ..;
	cd org-7.7; make; cd ..;
	for f in .ecb-user-layouts.el .tmux.conf .gitconfig; do\
		ln -f $$f ~/;\
	done
	grep -q '.emacs.d/emacs.el' ${emacsfile} || \
		echo '(load "~/.emacs.d/emacs.el")' >> ${emacsfile}
	@echo "### ALL DONE! ###"

clean:
	cd cedet-1.1; make clean-autoloads; make clean-all; cd ..;
	cd ecb-2.40; make clean; cd ..;
	cd org-7.7; make clean; cd ..;
	@echo "### CLEANED! ###"

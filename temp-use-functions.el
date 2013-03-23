;; I put all the temp use functions here

;; (defun my-setools-find-function ()
;;   "This function is used for me when reading shell codes (especially
;; setools in SYSENG). "
;;   (interactive)
;;   (let (file (func (current-word)))
;; 	(setq file
;; 		  (nth 0 (split-string
;; 				  (shell-command-to-string
;; 				   (concatenate 'string "f " func)))))
;; 	(my-setools-goto-file-with-function file func)))
;; (defun my-setools-goto-file-with-function (file func)
;;   "Open the file and move the cursor to the function"
;;   (find-file file)
;;   (evil-search-symbol-forward func))


(provide 'temp-use-functions)

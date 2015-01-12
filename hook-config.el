;; enabling auto-fill-mode in various modes

;;; detect whether file is to be indented using tab or spaces
(defvar *indent-tabs-directory-list*
  (list "/root/git/cyvtl/" "/usr/src/")
  "List of directories that I would like to indent tabs rather than spaces")

(defun detect-indent-tabs-mode-by-name (file)
  "Check whether file `file' is to be indented using spaces. By
default, we do indent using spaces. However, if `file' is stored
in any of the directory in the `dir-list' parameter, we will use
tabs rather than spaces"
  (message "Detecting file '%s' indent type" file)
  (when file
    (let ((file-name-len (string-width file)) (result nil))
      (dolist (dir *indent-tabs-directory-list*)
        (let ((dir-name-len (string-width dir)))
          (when (> file-name-len dir-name-len)
            (let ((file-prefix-name (substring file 0 dir-name-len)))
              (when (string= dir file-prefix-name)
                ;; could be better if I know how to break... I am lazy.
                (message "Detected file '%s' should use tabs when indent" file)
                (setq result t))))))
      result)))

(defun common-hook-function ()
  (auto-fill-mode 1)
  ;; by default, all use tabs
  (setq indent-tabs-mode t)
  (modify-syntax-entry ?_ "w"))
	
(add-hook 'text-mode-hook 'common-hook-function)
(add-hook 'emacs-lisp-mode-hook 'common-hook-function) 
(add-hook 'emacs-lisp-mode-hook 'common-hook-function) 
(defun sh-hook-function ()
  (common-hook-function)
  ;; not using tabs, but spaces
  (setq indent-tabs-mode nil)
  (setq sh-basic-offset 8)
  (my-set-tab-width 8))
(add-hook 'sh-mode-hook 'sh-hook-function)
(add-hook 'shell-script-mode-hook 'sh-hook-function)

(add-hook 'lisp-mode-hook 'common-hook-function) 

(defalias 'perl-mode 'cperl-mode)
(defun perl-hook-function ()
  (common-hook-function)
  (setq indent-tabs-mode t)
  (setq cperl-indent-level 4))
(add-hook 'cperl-mode-hook 'perl-hook-function) 

(add-hook 'minibuffer-inactive-mode-hook 'common-hook-function) 
(add-hook 'scheme-mode-hook 'common-hook-function) 
(defun python-hook-function ()
  (common-hook-function)
  ;; not using tabs, but spaces
  (setq indent-tabs-mode nil)
  (my-set-tab-width 8)
  (setq python-indent 8)
  ;; (define-key python-mode-map "\C-ch" 'pylookup-lookup)
  (define-key python-mode-map (kbd "C-c !") 'run-python)
  (define-key python-mode-map (kbd "C-M-,") 'python-shift-left)
  (define-key python-mode-map (kbd "C-M-.") 'python-shift-right))
(add-hook 'python-mode-hook 'python-hook-function)

;; c defines
(defconst c-style-cyphy
  '((c-basic-offset . 8)
	(c-offsets-alist . ((statement-cont . 4)
						(arglist-intro . 4)
						(arglist-cont-nonempty . c-lineup-arglist-intro-after-paren)
						(arglist-close . c-lineup-arglist-intro-after-paren)
						(label . 0)
						(case-label . 0)))))
(c-add-style "cyphy" c-style-cyphy)
(defun c-hook-function ()
  (common-hook-function)
  (setq c-basic-offset 8)
  (c-set-style "cyphy")
  (my-set-tab-width 8)
  (setq indent-tabs-mode
        (detect-indent-tabs-mode-by-name buffer-file-name))
  ;; this poor minor mode bring me bug when I opened *.c before I try to
  ;; open big *.py files. It will make it damn slow to open the python
  ;; script.
  ;; (which-function-mode 1)
  )
(add-hook 'c-mode-hook 'c-hook-function)
(add-hook 'c++-mode-hook 'c-hook-function)

(provide 'hook-config)

;; enabling auto-fill-mode in various modes

;;; detect whether file is to be indented using tab or spaces, and how many
;;; spaces to use if we are not using tab.
(defvar my-c-indent-tabs-hint-list
  '(("/root/git/cyvtl/" . 8)
    ("/root/git/CyphyOS-1/" . 8)
    ("/root/git/cscope/" . 4)
    ("/usr/src/" . nil))
  "List of directories that has indent hints. When the hint is `nil', then we
will use tab for indent. When the hint is non-nil, we will use spaces with
specific number.")
(defvar my-c-indent-tabs-default 8
  "Default value on how to indent in C")
(defvar my-c-indent-tabs-width 8
  "Default value of width of a tab")

(defun my-c-set-indent-tabs-by-name (file)
  "Check how C source file `file' should be indented. By default, we aure using
`my-c-indent-tabs-default' as the default value. But, if the file could be
  looked up in `my-c-indent-tabs-hint-list', then we will use that customized
  value rather than default."
  (message "Detecting file '%s' indent type" file)
  (when file
    (let ((file-name-len (string-width file)) (result nil))
      (dolist (hint my-c-indent-tabs-hint-list)
        (let* ((dir (car hint))
               (dir-name-len (string-width dir)))
          (when (> file-name-len dir-name-len)
            (let ((file-prefix-name (substring file 0 dir-name-len)))
              (when (string= dir file-prefix-name)
                ;; could be better if I know how to break... I am lazy.
                (message "Detected file '%s' should use '%s' when indent"
                         file (cdr hint))
                (setq result (cdr hint)))))))
      (if result
          (setq final-tabs-mode nil
                final-width result)
        (setq final-tabs-mode t
              final-width my-c-indent-tabs-width))
      (setq indent-tabs-mode final-tabs-mode
            c-basic-offset final-width)
      (my-set-tab-width final-width))))

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
  (my-c-set-indent-tabs-by-name buffer-file-name)
  ;; this poor minor mode bring me bug when I opened *.c before I try to
  ;; open big *.py files. It will make it damn slow to open the python
  ;; script.
  ;; (which-function-mode 1)
  )
(add-hook 'c-mode-hook 'c-hook-function)
(add-hook 'c++-mode-hook 'c-hook-function)

(add-hook 'asm-mode-hook 'common-hook-function)

(provide 'hook-config)

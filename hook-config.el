;; enabling auto-fill-mode in various modes

;;; detect whether file is to be indented using tab or spaces, and how many
;;; spaces to use if we are not using tab.
(defvar my-c-indent-tabs-hint-list
  '(
    ;; format: ( "root_dir_path" . ( use_tab_p . tab_width ))
    ("/root/git/kvm" . (t . 8))
    ("/root/codes/glib" . (nil . 8))
    ("/root/git/linux" . (t . 8))
    ("/root/git/rh/rhel7" . (t . 8))
    ("/root/codes/emacs" . (nil . 2))
    ("/root/git/qemu" . (nil . 4))
    ("/root/git/rh/qemu-kvm" . (nil . 4))
    )
  "List of directories that has indent hints. When the hint is `nil', then we
will use tab for indent. When the hint is non-nil, we will use spaces with
specific number.")
(defvar my-c-indent-tabs-default nil
  "Default value on how to indent in C")
(defvar my-c-indent-tabs-width 4
  "Default value of width of a tab")

(defun my-c-set-indent-tabs-by-name (file)
  "Check how C source file `file' should be indented. By default, we aure using
`my-c-indent-tabs-default' as the default value. But, if the file could be
  looked up in `my-c-indent-tabs-hint-list', then we will use that customized
  value rather than default."
  (message "Detecting file '%s' indent type" file)
  (when file
    (let ((file-name-len (string-width file))
          (final-tabs-mode my-c-indent-tabs-default)
          (final-tabs-width my-c-indent-tabs-width))
      (dolist (hint my-c-indent-tabs-hint-list)
        (let* ((dir (car hint))
               (dir-name-len (string-width dir)))
          (when (> file-name-len dir-name-len)
            (let ((file-prefix-name (substring file 0 dir-name-len)))
              (when (string= dir file-prefix-name)
                ;; could be better if I know how to break... I am lazy.
                (setq final-tabs-mode (car (cdr hint))
                      final-tabs-width (cdr (cdr hint)))
                (message "'%s' identation: tab mode '%s', width '%s'"
                         file final-tabs-mode final-tabs-width))))))
      (setq indent-tabs-mode final-tabs-mode
            c-basic-offset final-tabs-width)
      (my-set-tab-width final-tabs-width))))

(defun common-hook-function ()
  (auto-fill-mode 1)
  ;; by default, all use tabs
  (setq indent-tabs-mode t)
  (modify-syntax-entry ?_ "w"))
	
(add-hook 'text-mode-hook 'common-hook-function)

(defun diff-hook-function ()
  (common-hook-function)
  (define-key diff-mode-map (kbd "M-1") nil)
  (define-key diff-mode-map (kbd "M-4") nil)
  (define-key diff-mode-map (kbd "C-c C-c") 'my-save-buffer-and-close))

(add-hook 'diff-mode-hook 'diff-hook-function)
(defun sh-hook-function ()
  (common-hook-function)
  ;; not using tabs, but spaces
  (setq indent-tabs-mode nil)
  (setq sh-basic-offset 4)
  (my-set-tab-width 4))
(add-hook 'sh-mode-hook 'sh-hook-function)
(add-hook 'shell-script-mode-hook 'sh-hook-function)
(add-hook 'makefile-mode-hook 'common-hook-function)

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
  (my-set-tab-width 4)
  (setq python-indent 4)
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
  (setq c-basic-offset 4)
  (my-set-tab-width 8)
  (electric-pair-mode 1)
  (my-c-set-indent-tabs-by-name buffer-file-name)
  ;; this poor minor mode bring me bug when I opened *.c before I try to
  ;; open big *.py files. It will make it damn slow to open the python
  ;; script.
  ;; (which-function-mode 1)
  )
(add-hook 'c-mode-hook 'c-hook-function)
(add-hook 'c++-mode-hook 'c-hook-function)
(add-hook 'cscope-list-entry-hook 'common-hook-function)

(add-hook 'asm-mode-hook 'common-hook-function)

(defun magit-hook-function ()
  ;; this is hacky. i cannot re-define it in 'magit-mode-map. The
  ;; only working way to do this is to do local-set-key here.
  (local-set-key (kbd "j") 'next-line))
(when (featurep 'magit)
  (add-hook 'magit-mode-hook 'magit-hook-function))

(provide 'hook-config)

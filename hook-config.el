;; enabling auto-fill-mode in various modes

;;; detect whether file is to be indented using tab or spaces, and how many
;;; spaces to use if we are not using tab.
(defvar my-c-indent-tabs-hint-list
  '(
    ;; format: ( "dir_path_under_HOME" . ( use_tab_p . tab_width ))
    ;; Note: the path will be prefixed with $HOME later on.
    ("git/kvm-unit-test" . (t . 8))
    ("codes/glib" . (nil . 8))
    ("git/linux" . (t . 8))
    ("git/rh" . (t . 8))
    ("codes/emacs" . (nil . 2))
    ("codes/mutt" . (nil . 2))
    ("git/qemu" . (nil . 4))
    ("git/dpdk" . (t . 4))
    ("git/jitterz" . (t . 4))
    ("git/trace-cmd" . (t . 8))
    ("git/rt-tests" . (t . 8))
    ("git/rh/qemu-kvm" . (nil . 4)))
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
        (let* ((dir (format "%s/%s" home-dir (car hint)))
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
  (setq indent-tabs-mode t
        fill-column 79)
  (modify-syntax-entry ?_ "w"))
	
(defun text-hook-function ()
  (common-hook-function)
  (setq indent-tabs-mode nil)
  (my-set-tab-width 8))
(add-hook 'text-mode-hook 'text-hook-function)

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
(defun makefile-hook-function ()
  (common-hook-function)
  (modify-syntax-entry ?- "w"))
(add-hook 'makefile-mode-hook 'makefile-hook-function)

(add-hook 'lisp-mode-hook 'common-hook-function) 

(defalias 'perl-mode 'cperl-mode)
(defun perl-hook-function ()
  (common-hook-function)
  (setq indent-tabs-mode t)
  (setq cperl-indent-level 4))
(add-hook 'cperl-mode-hook 'perl-hook-function) 

(defun minibuffer-hook-function ()
  (common-hook-function)
  ;; TODO: this is still not working. not sure why.
  (modify-syntax-entry ?- "w"))
(add-hook 'minibuffer-inactive-mode-hook 'minibuffer-hook-function)
(add-hook 'scheme-mode-hook 'common-hook-function) 
(defun python-hook-function ()
  (common-hook-function)
  ;; not using tabs, but spaces
  (setq indent-tabs-mode nil)
  (my-set-tab-width 4)
  (setq python-indent 4)
  ;; with pycscope I can use cscope with python now!
  (cscope-minor-mode)
  ;; (define-key python-mode-map "\C-ch" 'pylookup-lookup)
  (define-key python-mode-map (kbd "C-c !") 'run-python)
  (define-key python-mode-map (kbd "C-c C-j") 'nil)
  (define-key python-mode-map (kbd "C-M-,") 'python-shift-left)
  (define-key python-mode-map (kbd "C-M-.") 'python-shift-right))
(add-hook 'python-mode-hook 'python-hook-function)

;; c defines
(defconst c-style-peterxu
  '((c-basic-offset . 8)
	(c-offsets-alist . ((statement-cont . 4)
						(arglist-intro . 4)
						(arglist-cont-nonempty . c-lineup-arglist-intro-after-paren)
						(arglist-close . c-lineup-arglist-intro-after-paren)
						(label . 0)
						(case-label . 0)))))
(c-add-style "peterxu" c-style-peterxu)
(defun c-hook-function ()
  (common-hook-function)
  (electric-pair-mode 1)
  (c-set-style "peterxu")
  (my-c-set-indent-tabs-by-name buffer-file-name)
  (define-key c-mode-map (kbd "C-c C-k") nil)
  ;; this poor minor mode bring me bug when I opened *.c before I try to
  ;; open big *.py files. It will make it damn slow to open the python
  ;; script.
  ;; (which-function-mode 1)
  )
(add-hook 'c-mode-hook 'c-hook-function)
(add-hook 'c++-mode-hook 'c-hook-function)
(add-hook 'cscope-list-entry-hook 'common-hook-function)

(defun rust-hook-function ()
  (common-hook-function)
  (setq indent-tabs-mode nil))
(add-hook 'rust-mode-hook 'rust-hook-function)

(add-hook 'asm-mode-hook 'common-hook-function)

(defun magit-hook-function ()
  ;; this is hacky. i cannot re-define it in 'magit-mode-map. The
  ;; only working way to do this is to do local-set-key here.
  (local-set-key (kbd "j") 'next-line))
(defun magit-common-diff-hook-function (map)
  (modify-syntax-entry ?- "w")
  (modify-syntax-entry ?_ "w")
  (define-key map (kbd "C-]") 'my-global-find-tag)
  (define-key map (kbd "/") 'search-forward)
  (define-key map (kbd "0") 'beginning-of-line)
  (define-key map (kbd "*") 'evil-search-word-forward)
  (define-key map (kbd "#") 'evil-search-word-backward)
  (define-key map (kbd "n") 'evil-search-next)
  (define-key map (kbd "N") 'evil-search-previous)
  (define-key map (kbd "l") 'forward-char)
  (define-key map (kbd "w") 'forward-word)
  (define-key map (kbd "b") 'backward-word)
  (define-key map (kbd "h") 'backward-char))
(defun magit-revision-hook-function ()
  (magit-common-diff-hook-function magit-revision-mode-map))
(defun magit-diff-hook-function ()
  (magit-common-diff-hook-function magit-diff-mode-map))
(when (featurep 'magit)
  (add-hook 'magit-mode-hook 'magit-hook-function)
  (add-hook 'magit-diff-mode-hook 'magit-diff-hook-function)
  (add-hook 'magit-revision-mode-hook 'magit-revision-hook-function))

(defun lua-hook-function ()
  (common-hook-function)
  (setq indent-tabs-mode nil
        lua-indent-level 2)
  (my-set-tab-width 2))
(when (featurep 'lua-mode)
  (add-hook 'lua-mode-hook 'lua-hook-function))

(provide 'hook-config)

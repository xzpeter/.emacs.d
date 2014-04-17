;; enabling auto-fill-mode in various modes
(defun common-hook-function ()
  (auto-fill-mode 1)
  ;; whether to use tab
  (setq indent-tabs-mode t)
  (modify-syntax-entry ?_ "w"))
	
(add-hook 'text-mode-hook 'common-hook-function)
(add-hook 'emacs-lisp-mode-hook 'common-hook-function) 
(add-hook 'emacs-lisp-mode-hook 'common-hook-function) 
(defun sh-hook-function ()
  (common-hook-function)
  ;; not using tabs, but spaces
  (setq indent-tabs-mode nil)
  (setq tab-width 8))
(add-hook 'sh-mode-hook 'sh-hook-function)
(add-hook 'shell-script-mode-hook 'sh-hook-function)

(add-hook 'lisp-mode-hook 'common-hook-function) 
(add-hook 'perl-mode-hook 'common-hook-function) 
(add-hook 'scheme-mode-hook 'common-hook-function) 
(defun python-hook-function ()
  (common-hook-function)
  ;; not using tabs, but spaces
  (setq indent-tabs-mode nil)
  (setq tab-width 8)
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
						(arglist-cont-nonempty . 4)
						(arglist-close . 4)
						(label . 0)
						(case-label . 4)))))
(c-add-style "cyphy" c-style-cyphy)
(defun c-hook-function ()
  (common-hook-function)
  (setq c-basic-offset 8)
  (setq indent-tabs-mode nil)
  (c-set-style "cyphy")
  ;; (c-init-customized-style)
  (which-function-mode 1))
(add-hook 'c-mode-hook 'c-hook-function)
(add-hook 'c++-mode-hook 'c-hook-function)

(provide 'hook-config)

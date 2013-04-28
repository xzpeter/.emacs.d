;; enabling auto-fill-mode in various modes
(defun common-hook-function ()
  (auto-fill-mode 1)
  ;; never use evilful tabs in my lovely Emacs
  (setq indent-tabs-mode nil)
  (modify-syntax-entry ?_ "w")
  (autopair-mode))

(add-hook 'text-mode-hook 'common-hook-function)
(add-hook 'emacs-lisp-mode-hook 'common-hook-function) 
(add-hook 'emacs-lisp-mode-hook 'common-hook-function) 
(add-hook 'sh-mode-hook 'common-hook-function)
(add-hook 'c-mode-hook
      (lambda ()
        (autopair-mode t)
        (common-hook-function)
        (setq c-basic-offset 4)
        ;; (setq c-auto-newline nil)
        (which-function-mode 1)
        (setq indent-tabs-mode nil)
        ;; (c-toggle-auto-hungry-state 1)
        ))

(add-hook 'lisp-mode-hook 'common-hook-function) 
(add-hook 'perl-mode-hook 'common-hook-function) 
(add-hook 'scheme-mode-hook 'common-hook-function) 
(add-hook 'python-mode-hook
      (lambda ()
        (common-hook-function)
        ;; (define-key python-mode-map "\C-ch" 'pylookup-lookup)
        (define-key python-mode-map (kbd "C-c !") 'run-python)
        (define-key python-mode-map (kbd "C-M-,") 'python-shift-left)
        (define-key python-mode-map (kbd "C-M-.") 'python-shift-right)))

(provide 'hook-config)

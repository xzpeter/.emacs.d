;; this is the config file related to lisp in emacs

;; loading SLIME
(add-to-list 'load-path (emacs-path "slime-2013-03-22"))
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq scheme-program-name "guile")
(require 'slime)
(slime-setup '(slime-fancy))
;;; set this to local file if there is one back up
(setq common-lisp-hyperspec-root "http://www.lispworks.com/reference/HyperSpec/")

(defun my-switch-to-slime-compilation-window ()
  (interactive)
  (switch-to-buffer "*slime-compilation*"))
(defun lisp-mode-key-config ()
  "define the auto complete in Lisp"
  (define-key lisp-mode-map (kbd "TAB") 'slime-fuzzy-complete-symbol)
  (define-key lisp-mode-map (kbd "C-c C-d d") 'slime-describe-symbol)
  (define-key lisp-mode-map (kbd "C-c C-d h") 'slime-documentation-lookup)
  (define-key lisp-mode-map (kbd "C-=") 'slime-reindent-defun)
  (define-key lisp-mode-map (kbd "C-j") 'slime-eval-last-expression)
  (define-key lisp-mode-map (kbd "C-c C-k") 'slime-compile-file)
  (define-key lisp-mode-map (kbd "C-c u") 'slime-unintern-symbol)
  (define-key lisp-mode-map (kbd "C-M-n") 'slime-end-of-defun)
  (define-key lisp-mode-map (kbd "C-M-p") 'slime-beginning-of-defun)
  (define-key lisp-mode-map (kbd "C-c C-o") 'my-switch-to-slime-compilation-window))
(add-hook 'lisp-mode-hook 'lisp-mode-key-config)

(defun emacs-lisp-mode-key-config ()
  "some defines for emacs lisp"
  (define-key emacs-lisp-mode-map (kbd "C-c C-l") 'eval-buffer)
  (define-key emacs-lisp-mode-map (kbd "C-c C-r") 'eval-region)
  (define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)
  (define-key emacs-lisp-mode-map (kbd "C-j") 'eval-print-last-sexp)
  (define-key emacs-lisp-mode-map (kbd "M-p") 'beginning-of-defun)
  (define-key emacs-lisp-mode-map (kbd "M-n") 'end-of-defun))
(add-hook 'emacs-lisp-mode-hook 'emacs-lisp-mode-key-config)

;; all the samme for lisp interaction mode
;; (define-key lisp-interaction-mode-map (kbd "C-c C-l") 'eval-buffer)
;; (define-key lisp-interaction-mode-map (kbd "C-c C-r") 'eval-region)
;; (define-key lisp-interaction-mode-map (kbd "C-c C-c") 'eval-defun)
;; (define-key lisp-interaction-mode-map (kbd "C-j") 'eval-print-last-sexp)
;; (define-key lisp-interaction-mode-map (kbd "M-p") 'beginning-of-defun)
;; (define-key lisp-interaction-mode-map (kbd "M-n") 'end-of-defun)

(defun slime-repl-mode-key-config ()
  (define-key slime-repl-mode-map (kbd "C-a") nil))
(add-hook 'slime-repl-mode-hook 'slime-repl-mode-key-config)

(provide 'lisp-config)

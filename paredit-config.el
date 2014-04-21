;; paredit configs
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(eval-after-load 'paredit
  '(progn
	 ;; it seems that paredit-kill works just as kill-sexp
	 (define-key paredit-mode-map (kbd "C-k") 'kill-sexp)
	 ;; (define-key paredit-mode-map (kbd "<backspace>") 'paredit-backward-delete)

	 ;; (define-key paredit-mode-map (kbd "(") 'paredit-open-parenthesis)
	 (define-key paredit-mode-map (kbd "M-)") 'paredit-close-parenthesis-and-newline)

	 (define-key paredit-mode-map (kbd "M-9") 'paredit-wrap-sexp)
	 (define-key paredit-mode-map (kbd "M-0") 'paredit-splice-sexp)
	 (define-key paredit-mode-map (kbd "M-[") 'paredit-forward-barf-sexp)
	 (define-key paredit-mode-map (kbd "M-]") 'paredit-forward-slurp-sexp)
	 (define-key paredit-mode-map (kbd "C-l") 'paredit-focus-on-defun)

	 ;; (define-key paredit-mode-map (kbd "M-r") 'paredit-raise-sexp)
	 ))

(provide 'paredit-config)

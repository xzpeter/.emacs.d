;; some more better auto-complete
(add-to-list 'load-path (emacs-path "yasnippet"))
(require 'yasnippet) ;; not yasnippet-bundle
(setq yas/snippet-dirs (emacs-path "snippets"))
(yas/initialize)
;; (yas/load-directory)

;; enable auto-complete
(require 'auto-complete-config)
(add-to-list
 'ac-dictionary-directories 
 (cond
  ((is-system-p 'windows-nt) "C:/xuzhe/softs/.emacs.d/ac-dict")
  ((or (is-system-p 'gnu/linux)
	   (is-system-p 'darwin)) "~/.emacs.d/ac-dict")
  ((is-system-p 'cygwin) "/cygdrive/c/xuzhe/softs/.emacs.d")))
(ac-config-default)

;; fix conflict between yasnippet and org-mode
(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
(add-hook 'org-mode-hook
          (lambda ()
            ;; yasnippet (using the new org-cycle hooks)
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))

(provide 'all-auto-complete-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If you want the best of Emacs and Vi...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; loading evil mode for emacs (nice vi)
(add-to-list 'load-path (emacs-path "evil/"))
(require 'evil)
;; activating evil mode
(evil-mode 1)

;; These two are for working around org-mode, otherwise <tab> in org
;; mode will be overwritten by evil key bindings
(define-key evil-motion-state-map (kbd "<tab>") nil)
(define-key evil-motion-state-map (kbd "TAB") nil)

;; these are the tag system I am using 
(require 'evil-global-tag)
;; some functions to unscroll under evil mode. Not using too much. 
(require 'evil-unscroll)

(evil-define-command my-evil-cmd-tag (str)
  (interactive "<a>")
  (find-tag str))
;; this simulates the 'tag' command in Vim
(evil-ex-define-cmd "tag" 'my-evil-cmd-tag)

(with-eval-after-load 'xref
  ;; Bind RET in the 'motion' state specifically for xref buffers.
  ;; This makes project-find-regexp / rgrep xref window to work
  ;; properly with global evil mode.
  (evil-define-key 'motion xref--xref-buffer-mode-map (kbd "RET") 'xref-goto-xref))

(provide 'evil-config)

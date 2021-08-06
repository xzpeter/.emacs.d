;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This is the main Evil Mode config file,
;; which is important for me!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; loading evil mode for emacs (nice vi)
(add-to-list 'load-path (emacs-path "evil/"))
;; activating evil mode
(require 'evil)
(evil-mode 1)

;; These two are for working around org-mode, otherwise <tab> in org
;; mode will be overwritten by evil key bindings
(define-key evil-motion-state-map (kbd "<tab>") nil)
(define-key evil-motion-state-map (kbd "TAB") nil)

;; these are the tag system I am using 
(require 'evil-global-tag)
;; some functions to unscroll under evil mode. Not using too much. 
(require 'evil-unscroll)

;;;;;;;;;;;;;;;;;;;;;;;;;
;; some cmd definitions
(evil-define-command my-evil-cmd-tag (str)
  (interactive "<a>")
  (find-tag str))
;; this simulates the 'tag' command in Vim
(evil-ex-define-cmd "tag" 'my-evil-cmd-tag)

(provide 'evil-config)

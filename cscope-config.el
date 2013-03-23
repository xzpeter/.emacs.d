;; config for cscope

;; This is used in this global tag system as CSCOPE mode
(require 'xcscope)
;; default, we don't display the cscope buffer
(setq cscope-display-cscope-buffer nil)
;; setting default cscope index to linux kernel source
;; (setq cscope-initial-directory "/usr/src/linux-source-3.2.0/")

(when (is-system-p 'darwin)
  (define-key cscope-list-entry-keymap (kbd "M-n") 'cscope-next-symbol)
  (define-key cscope-list-entry-keymap (kbd "M-p") 'cscope-prev-symbol))

(provide 'cscope-config)

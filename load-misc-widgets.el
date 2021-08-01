;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; These file loads many widgets, with the below characteristics:
;; 
;; 1. relatively tiny stuffs
;; 2. with NO dependency of other codes (only emacs itself)
;; 3. mostly with the global editing work (means non-specific plugins)
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load color theme
(require 'color-theme)
(color-theme-initialize)
;; (color-theme-clarity)
;; (color-theme-emacs-21)
;; (color-theme-blippblopp)
;; (color-theme-rotor)
;; (color-theme-dark-blue2)
;; (color-theme-hober)
;; (color-theme-arjen)
;; (color-theme-taylor)
;; (color-theme-snow)
(color-theme-xzpeter-dark)

;; loading linum+ module to show line numbers
;; (require 'linum+)
;; show line number
;; (global-linum-mode 1)

;; using swbuff, it seems that this is the best
(require 'swbuff)
(setq swbuff-exclude-buffer-regexps '("^ " "\\*.*\\*"))
(setq swbuff-status-window-layout 'scroll)
(setq swbuff-clear-delay 3)
(setq swbuff-separator "|")
(setq swbuff-window-min-text-height 1)

;; add the redo function
;; (require 'redo+)
;; including redo
(global-set-key [(meta backspace)] 'undo)
(global-set-key [(meta shift backspace)] 'redo)

;; loading magit, the git client under emacs
(add-to-list 'load-path (emacs-path "dash"))
(add-to-list 'load-path (emacs-path "with-editor"))
(add-to-list 'load-path (emacs-path "magit-popup"))
(add-to-list 'load-path (emacs-path "graphql"))
(add-to-list 'load-path (emacs-path "treepy"))
(add-to-list 'load-path (emacs-path "ghub"))
(add-to-list 'load-path (emacs-path "magit/lisp"))
(require 'magit)

;;; for reading logs
;; (require 'log4j-mode)

;;; load the d-mode for dtrace files
(autoload 'd-mode "d-mode" () t)
(add-to-list 'auto-mode-alist '("\\.d\\'" . d-mode))

;;; init systemtap mode
(load "systemtap-init.el")

;;; lua mode config
(require 'lua-mode)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;;; rust mode config
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;;; rpm-spec mode
(autoload 'rpm-spec-mode "rpm-spec-mode.el" "RPM spec mode." t)
(setq auto-mode-alist (append '(("\\.spec" . rpm-spec-mode))
                              auto-mode-alist))

(require 'go-mode-autoloads)
(require 'bpftrace-mode)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(provide 'load-misc-widgets)

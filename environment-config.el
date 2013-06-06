;; all the environment config stuff

;; set default directory on startup
(setq default-directory emacs-working-dir)

;; set the default frame size, so that emacs will not bigger than the
;; default window if font size is big.
;; (setq default-frame-alist 
;;       '((height . 25) (width . 85) (menu-bar-lines . 20) (tool-bar-lines)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; display configurations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; no tool bar
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 1))
;; no menu bar
(menu-bar-mode 0)
;; with scrollbar

;; no startup message
(setq inhibit-startup-message -1)

;; some other defines
(setq default-line-spacing 0)
(setq default-fill-column 74)
(setq default-major-mode 'text-mode)
(setq kill-ring-max 200)
(setq require-final-newline t) 
(global-font-lock-mode t)
(transient-mark-mode t)
;; set scroll configurations
(setq scroll-margin 1
      scroll-conservatively 1000
      scroll-step 1)
(show-paren-mode 1)
;; (setq show-paren-style 'expression)
(setq show-paren-style 'parentheses)
(setq visible-bell t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq resize-mini-windows nil)
(setq enable-recursive-minibuffers t)
(setq suggest-key-bindings 1)
(setq mouse-yank-at-point t)

(display-time)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-interval 10)
(setq column-number-mode t)
(setq frame-title-format "%f (%p)")
(setq-default make-backup-files nil)

(setq font-lock-maximum-decoration t)

(setq x-select-enable-clipboard t)
;;; this is useless to be set here. Moved to hook functions. 
;; (setq indent-tabs-mode nil)
(setq tab-always-indent nil)
(setq tab-width 4)
(global-auto-revert-mode 1)
;; enable clipboard sharing with system
(setq x-select-enable-clipboard 1)
;; default tab width to 4
(setq default-tab-width 4)

;; settings for mouse wheels
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control))))

(global-hl-line-mode 0)

;; save desktop after close
(desktop-save-mode 0)

;; enable icomplete mode
(icomplete-mode 1)

;; enable ido mode
(ido-mode 1)
;; using winner mode to store window configurations and do quick undo
(winner-mode 1)

;; auto pair for the braces
;; it seems that autopair-global may raise error when used with slime, I have
;; fixed this in the orgmode config
;; (autoload 'autopair-global-mode "autopair" nil t)
(require 'autopair)
(setq autopair-skip-whitespace 'chomp)
;; (autopair-global-mode 1)
;; (add-hook 'sldb-mode-hook #'(lambda () (setq autopair-dont-activate t)))

;; set some idioms for the startup message
(defvar *global-idioms*
  (list
   "Curiosity is the motivity of life."
   "Still hesitating? Just do it."
   ))
(defun get-random-list-item (alist)
  (nth (random (list-length alist)) alist))
;; reset the initial-scratch-message
(setq initial-scratch-message
      (concat
";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; " (get-random-list-item *global-idioms*) "
;; 
;; Current Emacs starts working at " (format-time-string "%D %T") "
;;
;; This is the scratchpad just for you! Have a nice day!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"))

;; remove the boring tempt when trying to kill a buffer invoked by emacsclient
(remove-hook 'kill-buffer-query-functions
	     'server-kill-buffer-query-function)

(provide 'environment-config)

;; this file stores all the customized and global key defines for emacs

;; I used to set align-newline-and-indent to '\r', but it seems that the
;; command just mess up my source codes. 
(global-set-key "\r" 'newline-and-indent)

;; swbuff shortcuts
(global-set-key (kbd "C-<prior>") 'swbuff-switch-to-previous-buffer)
(global-set-key (kbd "C-<next>") 'swbuff-switch-to-next-buffer)
(global-set-key (kbd "<C-kp-prior>") 'swbuff-switch-to-previous-buffer)
(global-set-key (kbd "<C-kp-next>") 'swbuff-switch-to-next-buffer)
(global-set-key (kbd "C-8") 'cscope-display-buffer)
(global-set-key (kbd "C-9") 'cscope-prev-symbol)
(global-set-key (kbd "C-0") 'cscope-next-symbol)

;; find corresponding parens. Default is C-M-p/n, and I just redirect them to
;; C-M-{/}
(global-set-key (kbd "C-M-[") 'backward-list)
(global-set-key (kbd "C-M-]") 'forward-list)
(global-set-key (kbd "M-[") 'evil-backward-section-begin)
(global-set-key (kbd "M-]") 'evil-forward-section-begin)

;; something related to buffer manipulate
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-4") 'my-kill-buffer)
(global-set-key (kbd "M-5") 'winner-undo)
(global-set-key (kbd "M-6") 'winner-redo)
(global-set-key (kbd "M-7") 'delete-window)
;; seems useless since I am using C-pgup/pgdn for this
;; (global-set-key (kbd "M-8") 'previous-buffer)
;; (global-set-key (kbd "M-9") 'next-buffer)
;; (global-set-key (kbd "M-9") 'previous-multiframe-window)
;; (global-set-key (kbd "M-0") 'next-multiframe-window)
(global-set-key (kbd "M--") 'delete-window)

;;; For MacOS, map common shortcuts for s-* (which is the commmand
;;; button).  Ideally it'll be simpler if we can just define the
;;; "command" button to behave the same as an "option" button, but
;;; can't do that until I know how..
(global-set-key (kbd "s-1") 'delete-other-windows)
(global-set-key (kbd "s-4") 'my-kill-buffer)
(global-set-key (kbd "s-;") 'comment-dwim)
(global-set-key (kbd "s-x") 'execute-extended-command)
(global-set-key (kbd "s-q") 'fill-paragraph)
(global-set-key (kbd "s-w") 'kill-ring-save)
(global-set-key (kbd "<s-f6>") 'my-set-current-as-key-buffer)

;; mark hot key
(global-set-key (kbd "C-t") 'set-mark-command)
(global-set-key (kbd "C-a") 'select-all)

;; C-x b => CRM bufer list
(global-set-key (kbd "C-x b") 'ibuffer)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)

;; mark whole buffer map, not using this, default is C-x h, which is good
;; (global-set-key (kbd "C-M-S-a") 'mark-whole-buffer)

;; start eshell. I like eshell! not using F12 now, since guake is using it
(global-set-key (kbd "<f5>") 'find-file-at-point)
(global-set-key (kbd "<f6>") 'ff-find-other-file)
(global-set-key (kbd "<f7>") 'shell)
(global-set-key (kbd "<f8>") 'my-c-switch-indent-type)
;; (global-set-key (kbd "<f8>") 'insert-current-timestamp)
;; some issue when remotely run emacs using xwing. Giving up F8 shortcuts.
;; (global-set-key (kbd "<f8>") 'eshell)

(global-set-key (kbd "<f9>") 'compile)
(global-set-key (kbd "<f10>") 'my-switch-code-tag-mode)
(global-set-key (kbd "<f12>") 'my-set-init-tags)

;; set print to ps shortcut
(global-set-key (kbd "C-M-S-p") 'ps-spool-buffer)

;; a more quicker way to kill the buffer, replacing the default "kill-word"
(global-set-key (kbd "<C-delete>") 'kill-buffer)
(global-set-key (kbd "<C-kp-delete>") 'kill-buffer)

;; SLIME definitions
(global-set-key (kbd "C-c C-d d") 'slime-describe-symbol)
(global-set-key (kbd "C-c C-d h") 'slime-hyperspec-lookup)
;; (global-set-key (kbd "C-=") 'slime-reindent-defun)

;; define NARROWING bindings. the default C-x n d/w is too complex!
(global-set-key (kbd "C-M-;") 'narrow-to-defun)
(global-set-key (kbd "C-M-'") 'widen)

;; I am going to replace the toggle-input-method to switch-to-scratch-buffer
(global-set-key (kbd "C-\\") 'switch-to-scratch-buffer)

;; unscrolling for evil mode
(global-set-key (kbd "C-M-o") 'evil-unscroll)

(defun key-config-cygwin ()
  (global-set-key (kbd "C-_") 'backward-kill-word)
  (define-key evil-normal-state-map (kbd "C-_") 'backward-kill-word)
  (define-key evil-insert-state-map (kbd "C-_") 'backward-kill-word))
(defun key-config-darwin ()
  (global-set-key (kbd "<S-help>") 'yank))
(cond
 ((is-system-p 'darwin) (key-config-darwin))
 ((is-system-p 'cygwin) (key-config-cygwin)))

(global-set-key (kbd "C-M-q") 'kill-buffer-and-window)

;; key buffer thing
(global-set-key (kbd "C-=") 'my-switch-between-key-buffer-and-latest)
;;; it seems that xfce may capture C-=, provide a quicker way to switch.
(global-set-key (kbd "C-;") 'my-omit-lines)

;; some <ctrl+fn> settings
(global-set-key (kbd "<M-f5>") 'my-set-current-as-key-buffer)
(global-set-key (kbd "<M-f6>") 'my-set-current-as-key-buffer)
(global-set-key (kbd "<C-f7>") 'eshell)
(global-set-key (kbd "<C-f9>") 'cscope-display-buffer)
(global-set-key (kbd "<C-f10>") 'cscope-display-buffer-toggle)
(global-set-key (kbd "<C-f11>") 'cscope-prev-symbol)
(global-set-key (kbd "<C-f12>") 'cscope-next-symbol)

;; just like my defines in tmux
(define-prefix-command 'evil-window-map)
(global-set-key (kbd "C-a") 'evil-window-map)
(define-key 'evil-window-map (kbd "|") 'split-window-horizontally)
(define-key 'evil-window-map (kbd "-") 'split-window-vertically)
(define-key 'evil-window-map (kbd "h") 'evil-window-left)
(define-key 'evil-window-map (kbd "j") 'evil-window-down)
(define-key 'evil-window-map (kbd "k") 'evil-window-up)
(define-key 'evil-window-map (kbd "l") 'evil-window-right)
(define-key 'evil-window-map (kbd "p") 'evil-window-prev)
(define-key 'evil-window-map (kbd "n") 'evil-window-next)
(define-key 'evil-window-map (kbd "C-h") 'swbuff-switch-to-previous-buffer)
(define-key 'evil-window-map (kbd "C-l") 'swbuff-switch-to-next-buffer)
(define-key 'evil-window-map (kbd "C-k") 'swbuff-kill-this-buffer)
(define-key 'evil-window-map (kbd "C-a") 'my-switch-to-other-buffer)
;;; magit is used alot; let's provide a super single key for it
(global-set-key (kbd "C-'") 'magit-status)

;;; Use this to modify evil mode default key bindings (an example only)
;;; (define-key evil-normal-state-map (kbd "") 'magit-status).

;;; it seems that this is needed in latest evil
(define-key evil-insert-state-map (kbd "C-a") 'evil-window-map)

(global-set-key (kbd "C-c r") 'my-read-tmux-buffer)

;;; useful when using emacs as git commit editor
(global-set-key (kbd "C-c C-z") 'server-edit)

 ;;; manual key
(global-set-key (kbd "C-k") 'man)

;;; something about yank
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "M-v") 'yank)

;;; for UNIX, I will possibly need this via X
(when (or (is-system-p 'berkeley-unix)
		  (is-system-p 'gnu/linux))
	(setq x-alt-keysym 'meta))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; VCS related keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (featurep 'magit)
  (define-key magit-mode-map (kbd "C-b") 'scroll-down)
  (define-key magit-mode-map (kbd "C-f") 'scroll-up)
  ;; this might not working, better see hook-config.el, searching
  ;; for magit for the hacking.
  ;; (define-key magit-mode-map (kbd "j") 'next-line)
  (define-key magit-mode-map (kbd "k") 'previous-line)
  ;; I replaced the old "k" which should be "magit-discard", so I'd
  ;; better find another key for it
  (define-key magit-mode-map (kbd "C-d") 'magit-discard)
  (define-key magit-mode-map (kbd "M-1") nil)
  (define-key magit-mode-map (kbd "M-4") nil)
  (global-set-key (kbd "C-c g") #'(lambda ()
                                    (interactive)
                                    (magit-status)
                                    (delete-other-windows)))
  ;;; magit diff mode
  (define-key magit-diff-mode-map (kbd "M-1") nil)
  (define-key magit-diff-mode-map (kbd "M-4") nil)
  (define-key magit-diff-mode-map (kbd "j") 'next-line)
  (define-key magit-diff-mode-map (kbd "k") 'previous-line))

;;; vc keys
(global-set-key (kbd "C-c v")
				#'(lambda ()
					(interactive)
					;; only display the last 20 entries
					(vc-print-root-log 20)
					(delete-other-windows)))

;;; svn log view mode
(add-hook 'vc-svn-log-view-mode-hook
		  #'(lambda ()
			  (define-key vc-svn-log-view-mode-map (kbd "C-b") 'scroll-down)
			  (define-key vc-svn-log-view-mode-map (kbd "C-f") 'scroll-up)
			  (define-key vc-svn-log-view-mode-map (kbd "j") 'next-line)
			  (define-key vc-svn-log-view-mode-map (kbd "k") 'previous-line)))

;;; use ctrl-backspace to delete a tab
(global-set-key (kbd "<C-backspace>") 'my-delete-previous-tab-stop)
;; (when (featurep 'paredit-config)
;;   (define-key evil-insert-state-map (kbd "<backspace>") 'paredit-backward-delete))

;;; Test modes are used for commit messages, simulating
;;; git-commit-mode to use C-c C-c to commit.
(require 'diff-mode)
(when (featurep 'evil)
  (define-key text-mode-map (kbd "C-c C-c") 'my-save-buffer-and-close))

;;; lua-mode key config
(when (featurep 'lua-mode)
  (define-key lua-mode-map (kbd ")") nil)
  (define-key lua-mode-map (kbd "}") nil)
  (define-key lua-mode-map (kbd "]") nil))

(when (featurep 'go-mode)
  (define-key go-mode-map (kbd "C-c C-j") nil))

;;; quick insertion of my r-b and a-b lines
(global-set-key (kbd "C-c k") 'my-insert-acked-by)
(global-set-key (kbd "C-c i") 'my-insert-reviewed-by)
;;; quick insertion of lore.kernel.org links
(global-set-key (kbd "C-c l") 'my-insert-lore-link)

;;; some git shortcuts
(global-set-key (kbd "C-c C-j") 'my-git-blame-current-line)
(global-set-key (kbd "C-c C-k") 'my-git-diff-current-commit)

;;; address book lookups
(global-set-key (kbd "C-c C-;") 'my-alias-lookup)

;;; an extra C-w to kill word, which is the commonly used one
(global-set-key (kbd "C-w") 'backward-kill-word)

(when (is-system-p 'darwin)
  ;; magit keys
  (define-key git-rebase-mode-map (kbd "<s-up>") 'git-rebase-move-line-up)
  (define-key git-rebase-mode-map (kbd "<s-down>") 'git-rebase-move-line-down))

(provide 'key-config)

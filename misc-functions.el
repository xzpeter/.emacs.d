;; I will put some misc functions that will be used in the config process here

(defun in-list (element mylist)
  "Check whether element is in the list. "
  (let (e)
	(loop
	 (setq e (car mylist))
	 (cond
	  ((null e) (return nil))
	  ((eq e element) (return t))
	  (t (setq mylist (cdr mylist))))))) 

(defun my-switch-to-other-buffer ()
  "Switch to latest buffer"
  (interactive)
  (switch-to-buffer (other-buffer)))

;; quick shortcuts to switch to scratch buffer
(defun switch-to-scratch-buffer ()
  "Switch between one recent buffer and the scratch buffer."
  (interactive)
  (let ((scratch-name "*scratch*"))
    (if (string= (buffer-name) scratch-name)
	(switch-to-buffer (other-buffer))
      (switch-to-buffer "*scratch*"))))

;; insert current timestamp
(defun insert-current-timestamp ()
  (interactive "*")
  (insert (format-time-string "[%Y-%m-%d %a %T]")))

(defun wrapper-with (start end m)
  "wrapper the text from START to END with M"
  (kill-region start end)
  (insert m)
  (yank)
  (insert m))

(defun wrapper-with-stars (point mark)
  "wrap the selected text with stars. this can be used as HIGHLIGHT TOOL
in ORG MODE. "
  (interactive "r")
  (wrapper-with point mark "*"))

(defvar *current-work-note-org* "2012-Q3.org")
(defun work ()
  (interactive)
  (find-file
   (cond
    ((or (is-system-p 'gnu/linux)
		 (is-system-p 'darwin)) "~/org/work.org")
    ((is-system-p 'windows-nt) "C:/xuzhe/docs/org/2012-Q3.org")
    ((is-system-p 'cygwin) "/cygdrive/c/xuzhe/docs/org/2012-Q3.org")
	((is-system-p 'berkeley-unix) "/root/org/work.org")))) 

(defun my-kill-buffer ()
  (interactive)
  (kill-buffer))

(defun my-read-tmux-buffer ()
  (interactive)
  (evil-read nil "~/.tmux-buffer"))

(require 'my-key-buffer)
(require 'temp-use-functions)

(provide 'misc-functions)

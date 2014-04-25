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

(defun my-set-tab-width (width)
  "set `tab-width' and also `tab-stop-list' the same time"
  (interactive "nSet tab-width to: ")
  (setq tab-width width)
  (let ((i width) (max 120) (output-list nil))
    (while (<= i max)
      (setq output-list (cons i output-list))
      (setq i (+ i width)))
    (setq tab-stop-list (nreverse output-list))))

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
  (evil-read nil "/mac:~/.tmux-buffer"))

(defun my-grep-find ()
  "grep and find current word"
  (interactive)
  (let ((word (current-word)))
	(grep-find (concat "find . -type f -exec grep -nH -e " word " {} +"))))

(defun my-delete-previous-tab-stop ()
  "Remove spaces before point, max to `tab-width' spaces."
  (interactive)
  (let ((max-backchar tab-width)
		(last-point (point))
		(cur-point (point))
		(do-delete-region t)
		(moveon t))
	 (while moveon
	   (if (= (char-before cur-point) ?\s)
		   (setq cur-point (1- cur-point))
		 (progn
		   ;; if this is the first delete action, remove this char and done
		   (if (= cur-point last-point)
			   (if (featurep 'paredit-config)
				   ;; if paredit is loaded, use better remove
				   (progn
					 (setq do-delete-region nil)
					 (paredit-backward-delete))
				 ;; or, use delete-region too
				 (progn
				   ;; (message "reach char not space")
				   (setq cur-point (1- cur-point)))))
		   (setq moveon nil)))
	   (when (>= (- last-point cur-point) max-backchar)
		 ;; (message "reach max backchar")
		 (setq moveon nil))
	   (when (in-list (+ (current-column)
						 (+ cur-point)
						 (- last-point))
					  tab-stop-list)
		 ;; (message "reach tab-stop-list")
		 (setq moveon nil)))
	 (when (< cur-point last-point)
	   (delete-region cur-point last-point))))

(require 'my-key-buffer)
(require 'temp-use-functions)

(provide 'misc-functions)

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
  """There are lots of variables related to tab width. Use this
     would be quicker."""
  (interactive "nSet tab-width to: ")
  (setq tab-width width)
  (when (featurep 'evil)
    (setq evil-shift-width width))
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

(defun my-save-buffer-and-close ()
  (interactive)
  (save-buffer)
  (kill-buffer))

(defun my-read-tmux-buffer ()
  (interactive)
  (evil-read nil "~/.tmux-buffer"))

(defun my-grep-find ()
  "grep and find current word"
  (interactive)
  (let ((word (current-word)))
	(grep-find (concat "find . -type f -exec grep -nH -e " word " {} +"))))

(defun my-delete-previous-tab-stop ()
  "Remove spaces before point, max to `tab-width' spaces."
  (interactive)
  ;; hack here: this is used when I am deleting words or path like:
  ;; (1) "here are SOME WORDS TO BE DELETED"
  ;; (2) "/root/dir1/DIR2/DIR3/DIR4"
  ;; when trying to delete the chars with upper cases, I need two
  ;; C-backspace to delete one single word. It is slow. When found the
  ;; char is either " " or "/", delete it directly before hand.
  (let ((last-char (char-before (point))))
    (when (or (= last-char ?/)
              (= last-char ? ))
      (delete-backward-char 1)))
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
                    (evil-delete-backward-word))
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

(defvar *my-email-full* "Peter Xu <peterx@redhat.com>")

(defun my-insert-reviewed-by ()
  (interactive)
  (insert (format "Reviewed-by: %s" *my-email-full*)))

(defun my-insert-acked-by ()
  (interactive)
  (insert (format "Acked-by: %s" *my-email-full*)))

(defun my-git-blame-current-line ()
  (interactive)
  (let ((commit-number
         (shell-command-to-string
          (format "echo '%s' | sed 's/<.*>$//' | xargs git blame -L %s,+1 | awk '{print $1}'"
                  (buffer-name) (line-number-at-pos)))))
    (if (string= commit-number "00000000\n")
        (message "Current line is not commited yet.")
      (shell-command (format "git log -1 %s" commit-number)))))

(defun my-omit-lines ()
  (interactive)
  (delete-region (region-beginning) (region-end))
  (insert "\n[...]\n\n"))

(require 'my-key-buffer)
(require 'temp-use-functions)

(provide 'misc-functions)

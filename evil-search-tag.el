;; Save position before the first evil symbol search (* / #), so
;; C-o can jump back to where the search started.

(defvar *evil-search-tag-enabled* nil
  "Whether a search-tag position has been saved.")
(defvar *evil-search-tag-marker* nil
  "Marker for the position before the first search press.")

(defun evil-search-tag--save-if-first (&rest _)
  "Save position when this is the first search press in a sequence."
  (unless (memq last-command
                '(evil-search-word-forward
                  evil-search-word-backward
                  evil-search-next
                  evil-search-previous))
    (setq *evil-search-tag-marker* (point-marker))
    (setq *evil-search-tag-enabled* t)))

(advice-add 'evil-search-word-forward :before #'evil-search-tag--save-if-first)
(advice-add 'evil-search-word-backward :before #'evil-search-tag--save-if-first)

(defun evil-pop-search-tag-mark-if-exists ()
  "Pop search tag mark if one was saved.  Return t if popped, nil otherwise."
  (interactive)
  (when *evil-search-tag-enabled*
    (let ((marker *evil-search-tag-marker*))
      (when (and marker (marker-buffer marker))
        (switch-to-buffer (marker-buffer marker))
        (goto-char marker)
        (set-marker marker nil)))
    (setq *evil-search-tag-enabled* nil)
    (message "pop search tag")
    t))

(provide 'evil-search-tag)

;; I would like to do a tag when doing forward/backward search with evil. 

(defvar *evil-search-tag-enabled* nil
  "Whether there is something stored in the search tag variables")
(defvar *evil-search-tag-point* nil
  "The recover point of the cursor in evil mode. ")
(defvar *evil-search-tag-window-start* nil
  "The recover point of the window start in evil mode. ")
(defvar *evil-search-tag-hscroll* nil
  "The recover point of the hscroll in evil mode. ")
(defun evil-set-search-tag-vars ()
  (setq *evil-search-tag-enabled* t)
  (setq *evil-search-tag-point* (point))
  (setq *evil-search-tag-window-start* (window-start))
  (setq *evil-search-tag-hscroll* (window-hscroll)))
(defun evil-last-command-search-p ()
  (or (eq last-command 'evil-search-symbol-forward)
      (eq last-command 'evil-search-symbol-backward)
      (eq last-command 'evil-search-next)
      (eq last-command 'evil-search-previous)))

(defadvice evil-search-symbol-forward
  (before evil-tag-after-search-forward activate compile)
  "Keep a tag on the first press of evil symbol search"
  (if (not (evil-last-command-search-p))
      (evil-set-search-tag-vars)))
(defadvice evil-search-symbol-backward
  (before evil-tag-after-search-backward activate compile)
  "Keep a tag on the first press of evil symbol search"
  (if (not (evil-last-command-search-p))
      (evil-set-search-tag-vars)))

(defun evil-pop-search-tag-mark-if-exists ()
  "This will pop evil search tag mark, if enabled. return t if
popped, or nil if not. "
  (interactive)
  (when *evil-search-tag-enabled*
    (goto-char *evil-search-tag-point*)
    (set-window-start nil *evil-search-tag-window-start*)
    (set-window-hscroll nil *evil-search-tag-hscroll*)
    (setq *evil-search-tag-enabled* nil)
    (message "pop search tag")))

(provide 'evil-search-tag)

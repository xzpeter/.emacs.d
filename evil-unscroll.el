;; this is derived from the book <Writting GNU Emacs Extension>> chap. 3
;; written by xzpeter at May 3rd, 2012

;; something about the unscroll (this is working upon Evil-Mode)
(defvar *evil-unscroll-point* nil
  "The unscroll point of the cursor in evil mode. ")
(defvar *evil-unscroll-window-start* nil
  "The unscroll point of the window start in evil mode. ")
(defvar *evil-unscroll-enabled* nil
  "Whether there is something stored in the unscroll variables")
(defvar *evil-unscroll-hscroll* nil
  "The unscroll point of the hscroll in evil mode. ")
(defun evil-last-command-scroll-p ()
  (or (eq last-command 'evil-scroll-page-up)
      (eq last-command 'evil-scroll-page-down)))
(defun evil-set-unscroll-vars ()
  (setq *evil-unscroll-point* (point))
  (setq *evil-unscroll-window-start* (window-start))
  (setq *evil-unscroll-enabled* t)
  (setq *evil-unscroll-hscroll* (window-hscroll)))
(defadvice evil-scroll-page-down (before remember-for-unscroll-down
					 activate compile)
  "Remember the scrolling, if all the scrolling is up/down. use
					 evil-unscroll to jump back"
  (when (not (evil-last-command-scroll-p))
    (evil-set-unscroll-vars)))
(defadvice evil-scroll-page-up (before remember-for-unscroll-up
					 activate compile)
  "Remember the scrolling, if all the scrolling is up/down. use
					 evil-unscroll to jump back"
  (when (not (evil-last-command-scroll-p))
    (evil-set-unscroll-vars)))
(defun evil-unscroll ()
  (interactive)
  (when *evil-unscroll-enabled*
    (goto-char *evil-unscroll-point*)
    (set-window-start nil *evil-unscroll-window-start*)
    (set-window-hscroll nil *evil-unscroll-hscroll*)
    (message "unscrolled back")))

(provide 'evil-unscroll)

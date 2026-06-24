;; config for cscope

;; This is used in this global tag system as CSCOPE mode
(require 'xcscope)
;; default, we don't display the cscope buffer
(setq cscope-display-cscope-buffer nil
      cscope-do-not-update-database t)
;; setting default cscope index to linux kernel source
;; (setq cscope-initial-directory "/usr/src/linux-source-3.2.0/")

(when (is-system-p 'darwin)
  (define-key cscope-list-entry-keymap (kbd "M-n") 'cscope-next-symbol)
  (define-key cscope-list-entry-keymap (kbd "M-p") 'cscope-prev-symbol))

;; Evil j/k/J/K/RET navigation for the *cscope* buffer
(defun cscope-evil--line-type ()
  "Return 'entry, 'file, or nil for the current line."
  (let ((ln (get-text-property (point) 'cscope-line-number)))
    (cond ((null ln) nil)
          ((equal ln -1) 'file)
          (t 'entry))))

(defun cscope-evil-next-entry ()
  (interactive)
  (let ((orig (point)))
    (forward-line 1)
    (while (and (not (eobp))
                (not (eq (cscope-evil--line-type) 'entry)))
      (forward-line 1))
    (when (eobp) (goto-char orig))))

(defun cscope-evil-prev-entry ()
  (interactive)
  (let ((orig (point)))
    (forward-line -1)
    (while (and (not (bobp))
                (not (eq (cscope-evil--line-type) 'entry)))
      (forward-line -1))
    (unless (eq (cscope-evil--line-type) 'entry)
      (goto-char orig))))

(defun cscope-evil-next-file ()
  (interactive)
  (let ((orig (point)))
    (forward-line 1)
    (while (and (not (eobp))
                (not (eq (cscope-evil--line-type) 'file)))
      (forward-line 1))
    (when (eobp) (goto-char orig))))

(defun cscope-evil-prev-file ()
  (interactive)
  (let ((orig (point)))
    (forward-line -1)
    (while (and (not (bobp))
                (not (eq (cscope-evil--line-type) 'file)))
      (forward-line -1))
    (unless (eq (cscope-evil--line-type) 'file)
      (goto-char orig))))

(evil-define-key 'normal cscope-list-entry-keymap
  "j" #'cscope-evil-next-entry
  "k" #'cscope-evil-prev-entry
  "J" #'cscope-evil-next-file
  "K" #'cscope-evil-prev-file
  (kbd "RET") #'cscope-select-entry-other-window
  "q" #'cscope-quit)

(evil-set-initial-state 'cscope-list-entry-mode 'normal)

(provide 'cscope-config)

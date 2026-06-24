;; Citre selection UI for evil: group by file, j/k/RET navigation

(defvar-local my-citre-select--result nil)

(define-derived-mode my-citre-select-mode special-mode "Citre-Select"
  (setq truncate-lines t)
  (hl-line-mode 1))

(evil-set-initial-state 'my-citre-select-mode 'normal)

(defun my-citre-select--parse-item (item)
  "Parse ITEM into (:file :line :annotation :content :original)."
  (cond
   ((string-match "^\\(.*\\) \\([^ (]+\\)(\\([0-9]+\\)): \\(.*\\)" item)
    (list :file (match-string 2 item)
          :line (match-string 3 item)
          :annotation (match-string 1 item)
          :content (match-string 4 item)
          :original item))
   ((string-match "^\\([^ (]+\\)(\\([0-9]+\\)): \\(.*\\)" item)
    (list :file (match-string 1 item)
          :line (match-string 2 item)
          :annotation nil
          :content (match-string 3 item)
          :original item))
   (t (list :file "?" :line "?" :annotation nil
            :content item :original item))))

(defun my-citre-select--group-by-file (items)
  "Group ITEMS by file path.  Returns ((file parsed ...) ...)."
  (let (groups)
    (dolist (item items)
      (let* ((parsed (my-citre-select--parse-item item))
             (file (plist-get parsed :file))
             (existing (assoc file groups)))
        (if existing
            (setcdr existing (append (cdr existing) (list parsed)))
          (push (cons file (list parsed)) groups))))
    (nreverse groups)))

(defun my-citre-select--next-item ()
  (interactive)
  (let ((orig (point)))
    (forward-line 1)
    (while (and (not (eobp))
                (not (get-text-property (point) 'my-citre-item)))
      (forward-line 1))
    (when (eobp) (goto-char orig))))

(defun my-citre-select--prev-item ()
  (interactive)
  (let ((orig (point)))
    (forward-line -1)
    (while (and (not (bobp))
                (not (get-text-property (point) 'my-citre-item)))
      (forward-line -1))
    (unless (get-text-property (point) 'my-citre-item)
      (goto-char orig))))

(defun my-citre-select--choose ()
  (interactive)
  (let ((item (get-text-property (line-beginning-position) 'my-citre-item)))
    (if item
        (progn (setq my-citre-select--result item)
               (exit-recursive-edit))
      (message "Not on a selectable line"))))

(defun my-citre-select--cancel ()
  (interactive)
  (exit-recursive-edit))

(evil-define-key 'normal my-citre-select-mode-map
  "j" #'my-citre-select--next-item
  "k" #'my-citre-select--prev-item
  (kbd "RET") #'my-citre-select--choose
  "q" #'my-citre-select--cancel)

(defun my-citre-jump-select (items symbol)
  (pcase (length items)
    (1 (car items))
    (_
     (let ((buf (get-buffer-create "*citre-select*"))
           (groups (my-citre-select--group-by-file items))
           result)
       (with-current-buffer buf
         (let ((inhibit-read-only t))
           (erase-buffer)
           (insert (format "%d definitions for %s:\n" (length items) symbol))
           (dolist (group groups)
             (insert (propertize (format "\n*** %s:\n" (car group))
                                 'face 'font-lock-keyword-face))
             (dolist (entry (cdr group))
               (let ((start (point))
                     (ann (plist-get entry :annotation))
                     (line (plist-get entry :line))
                     (content (plist-get entry :content)))
                 (if ann
                     (insert (format "  %s [%s]  %s\n" ann line content))
                   (insert (format "  [%s]  %s\n" line content)))
                 (put-text-property start (1- (point))
                                    'my-citre-item
                                    (plist-get entry :original)))))
           (goto-char (point-min)))
         (my-citre-select-mode)
         (setq my-citre-select--result nil)
         (my-citre-select--next-item))
       (pop-to-buffer buf)
       (unwind-protect
           (recursive-edit)
         (setq result (buffer-local-value 'my-citre-select--result buf))
         (when (buffer-live-p buf)
           (quit-window t (get-buffer-window buf))))
       (or result (user-error "Cancelled"))))))

(setq citre-jump-select-item-function #'my-citre-jump-select)

(provide 'evil-citre-tag)

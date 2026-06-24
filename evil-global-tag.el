;; This is my own tag system! Based on Evil Mode. 

;; load cscope
(require 'cscope-config)

;; I am support search tagging with current tag systems. 
(require 'evil-search-tag)

;; sometimes I would like to use cscope functions rather that tags
;; system. So here comes a function that do the switch between TAGS and
;; CSCOPE index mode
(defvar my-tag-mode 'cscope
  "this is the current tag mode for my favorite keys to find tags. can be

'TAGS:    using tag system (citre)
'CSCOPE:  using cscope system to do tag jump

default value is 'tags ")

;; these functions handle tag switching work
(defun my-switch-to-tags-mode ()
  (interactive)
  (setq my-tag-mode 'tags)
  (message "Switched to TAGS mode."))
(defun my-switch-to-cscope-mode ()
  (interactive)
  (setq my-tag-mode 'cscope)
  (message "Switched to CSCOPE mode."))
(defun my-switch-code-tag-mode ()
  (interactive)
  (cond
   ((eq my-tag-mode 'tags) (my-switch-to-cscope-mode))
   ((eq my-tag-mode 'cscope) (my-switch-to-tags-mode))))

;; These two functions handle all tag push/pop
(defun my-global-find-tag ()
  "handles all tag finding work for me. (support all the modes in
`my-tag-mode')"
  (interactive)
  (setq *evil-search-tag-enabled* nil)
  (cond
   ((eq my-tag-mode 'tags)
    (citre-jump))
   ((eq my-tag-mode 'cscope)
    ;; fixing CAN'T FIND error when cscope-display-buffer==nil but the
    ;; buffer is not closed
    (when (get-buffer "*cscope*")
      (cscope-quit))
    (cscope-find-global-definition-no-prompting))
   (t (error "Tag mode not supported!"))))
(defun my-global-pop-tag-mark ()
  "handle all pop tag work, corresponding to my-global-find-tag"
  (interactive)
  ;; first, pop a search tag if there is one
  (when (not (evil-pop-search-tag-mark-if-exists))
    ;; there is no search tag, pop tag for the mode
    (cond
     ((eq my-tag-mode 'tags) (citre-jump-back))
     ((eq my-tag-mode 'cscope) (cscope-pop-mark))
     (t (error "Tag mode not supported!")))))

(defun my-global-grep-tag ()
  "Search for symbol at point using project.el (respects .gitignore)."
  (interactive)
  (require 'project)
  (evil-set-jump)
  (let* ((symbol (thing-at-point 'symbol t))
         (search-term (or symbol ""))
         ;; Check if we are actually inside a project
         (project (project-current nil)))
    (if (and project (not (string-empty-p search-term)))
        ;; project-find-regexp takes the search string as an argument
        ;; It automatically determines the root and ignored files
        ;;
        ;; format makes it grep like "-w"
        (project-find-regexp (format "\\b%s\\b" (regexp-quote search-term)))
      (if (not project)
          ;; Fallback to rgrep: (REGEXP FILES DIR &optional CONFIRM)
          (rgrep search-term "*" default-directory)
        (message "No symbol at point to search for")))))

;; So, I am using the global tag system. 
(define-key evil-normal-state-map (kbd "C-]") 'my-global-find-tag)
(define-key evil-normal-state-map (kbd "C-e") 'my-global-grep-tag)
(define-key evil-normal-state-map (kbd "C-o") 'my-global-pop-tag-mark)

(provide 'evil-global-tag)

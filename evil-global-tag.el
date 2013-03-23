;; This is my own tag system! Based on Evil Mode. 

;; load cscope
(require 'cscope-config)

;; This is a further plugin for find-tag, that can list tags, and it's
;; used in my global tag system
(require 'etags-select)
;; I would like to advice the main find tag function in etags select,
;; since it don't automatically try to load a tag file if not exist. 
(defadvice etags-select-find-tag-at-point
  (around visit-tags-table-before-find activate)
  "If there is no tags table, then we should advice the user to visit
one. "
  (if (and (null tags-file-name)
	   (null tags-table-list))
      ;; TOFIX: I don't know how to make a USER-LIKE call to VISIT-TAG-TABLE
      (message "There is currently no tags file. Please visit one with \
`visit-tags-table'. ")
    ad-do-it))

;; I am support search tagging with current tag systems. 
(require 'evil-search-tag)

;; sometimes I would like to use cscope functions rather that tags
;; system. So here comes a function that do the switch between TAGS and
;; CSCOPE index mode
(defvar my-tag-mode 'etags
  "this is the current tag mode for my favorite keys to find tags. can be

'ETAGS:   using find-tag/pop-tag-mark with etags
'CSCOPE:  using cscope system to do tag jump

default value is 'etags ")

;; these functions handle tag switching work
(defun my-switch-to-etags-tag-mode ()
  (interactive)
  (setq my-tag-mode 'etags)
  (message "Switched to ETAGS tag mode."))
(defun my-switch-to-cscope-tag-mode ()
  (interactive)
  (setq my-tag-mode 'cscope)
  (message "Switched to CSCOPE tag mode."))
(defun my-switch-code-tag-mode ()
  (interactive)
  (cond
   ((eq my-tag-mode 'etags) (my-switch-to-cscope-tag-mode))
   ((eq my-tag-mode 'cscope) (my-switch-to-etags-tag-mode))))

;; These two functions handle all tag push/pop
(defun my-global-find-tag ()
  "handles all tag finding work for me. (support all the modes in
`my-tag-mode')"
  (interactive)
  ;; first, when finding a tag, clear the old search tag
  (setq *evil-search-tag-enabled* nil)
  (cond
   ((eq my-tag-mode 'etags)
    ;; modified [2012-09-02 日 12:34:55]
    ;; Just find etags-select plugin, using this
    ;; (let ((symbol-word (current-word)))
    ;;   (find-tag symbol-word))
    (etags-select-find-tag-at-point))
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
     ((eq my-tag-mode 'etags) (pop-tag-mark))
     ((eq my-tag-mode 'cscope) (cscope-pop-mark))
     (t (error "Tag mode not supported!")))))

;; So, I am using the global tag system. 
(define-key evil-normal-state-map (kbd "C-]") 'my-global-find-tag)
(define-key evil-normal-state-map (kbd "C-o") 'my-global-pop-tag-mark)

(my-switch-to-cscope-tag-mode)

(provide 'evil-global-tag)

;; This is the configuration file for org mode in emacs
(setq my-data-share-dir
      (cond
       ((or (is-system-p 'gnu/linux)
			(is-system-p 'darwin)) "~/org/")
       ((is-system-p 'windows-nt) "C:/xuzhe/docs/org/")
       ((is-system-p 'cygwin) "/cygdrive/c/xuzhe/docs/org/")))

;; setting org path
(add-to-list 'load-path (emacs-path "org-7.7/lisp"))
(setq org-agenda-files (list (concat my-data-share-dir "work.org")))
(require 'org-install)

;; some global defines of org-mode
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-log-done t)
(setq org-todo-keywords
	  '((sequence "TODO" "DOING" "PENDING" "|" "DONE" "CANCEL")))

(defun org-mode-key-config ()
  (setq org-support-shift-select 1)
  ;; due to org2blog reasons, I am not using auto-fill-mode in org mode
  (auto-fill-mode t)
  (setq truncate-lines nil)
  ;; some org2blog specific defines
  (define-key org-mode-map (kbd "C-a") nil)	; check key-config.el
  (define-key org-mode-map (kbd "C-c d") 'org2blog/wp-post-buffer)
  (define-key org-mode-map (kbd "C-c p") 'org2blog/wp-post-buffer-and-publish)
  (define-key org-mode-map (kbd "C-c D") 'org2blog/wp-post-buffer-as-page)
  (define-key org-mode-map (kbd "C-c P") 'org2blog/wp-post-buffer-as-page-and-publish)
  (define-key org-mode-map (kbd "M-h") 'org-metaleft)
  (define-key org-mode-map (kbd "M-l") 'org-metaright)
  (define-key org-mode-map (kbd "<C-return>") 'org-insert-heading)
  (define-key org-mode-map (kbd "<C-M-return>") 'org-insert-todo-heading))
(add-hook 'org-mode-hook (lambda ()
                            (org-mode-key-config)
                            (modify-syntax-entry ?_ "w")  
                            (setq indent-tabs-mode nil)))

;;; org2blog configures
(add-to-list 'load-path (emacs-path "org2blog/"))
(require 'org2blog-autoloads)
;; configure my xzpeter.org site
(setq org2blog/wp-blog-alist
       '(("xzpeter"
          :url "http://xzpeter.org/xmlrpc.php"
          :username "xzpeter"
          :default-title "Hello World"
          :default-categories ("Miscellaneous")
          :tags-as-categories nil)))

;;; This will allow me to write function names without being
;;; identified as subscripts, instead I'll need to use a_{b}
(setq org-export-with-sub-superscript "{}")

(provide 'org-mode-config)

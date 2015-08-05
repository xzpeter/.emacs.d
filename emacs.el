;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This is XzPeter's Emacs configuration file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun is-system-p (type)
  ;; check whether current system is system TYPE
  (eq system-type type))

;; set the default directory. This is the start of all things else
(setq emacs-working-dir
      (cond
       ((is-system-p 'gnu/linux) "/root/.emacs.d/lisp/")
       ((is-system-p 'darwin) "/Users/xz/.emacs.d/")
       ((is-system-p 'berkeley-unix) "/root/.emacs.d/")
       ((is-system-p 'windows-nt) "C:/xuzhe/softs/.emacs.d/")
       ((is-system-p 'cygwin) "/cygdrive/c/xuzhe/softs/.emacs.d/")
       (else (error "unsupported system!"))))

;; adding local load path
(add-to-list 'load-path emacs-working-dir)

;; using this function to format loading directories
(defun emacs-path (oldpath)
  (concat emacs-working-dir oldpath))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; codes that with NO dependency problems
;; (which means that random load order is ok)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load some small functions that I may use during config
(require 'misc-functions)
;; fullscreen stuff
;; (require 'fullscreen)
;; load platform specified codes
(require 'platform-specified-config)
;; load miscellaneous widgets
(require 'load-misc-widgets)
;; these stuff is fairly slow when loading...
(require 'all-auto-complete-config)
;; load environment stuff
(require 'environment-config)
;; some config for lisp
(require 'lisp-config)
;;; paredit: powerful tool with parenthesis
(require 'paredit-config)
;; something about the org mode
(require 'org-mode-config)
;; hook defines
(require 'hook-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; codes that with dependencies
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; just load cscope
;; (when (is-system-p 'gnu/linux)
;;   (require 'cedet-config)
;;   (require 'ecb-config))
;; All evil stuffs here
(require 'evil-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key bindings should be the last one, since many
;; functions are referenced here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'key-config)

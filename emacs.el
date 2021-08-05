;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This is XzPeter's Emacs configuration file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun is-system-p (type)
  ;; check whether current system is system TYPE
  (eq system-type type))

(setq home-dir
      (cond
       ((is-system-p 'gnu/linux)
        (if (string-equal user-login-name "root")
            "/root"
          (format "/home/%s" user-login-name)))
       ((is-system-p 'darwin) (format "/Users/%s" user-login-name))
       ((is-system-p 'berkeley-unix) "/root")
       ((is-system-p 'windows-nt) (format "C:/%s/softs" user-login-name))
       ((is-system-p 'cygwin) (format "/cygdrive/c/%s" user-login-name))
       (else (error "setup home-dir first!"))))
(setq linux-working-dir (format "%s/.emacs.d/lisp/" home-dir))

;; set the default directory. This is the start of all things else
(setq emacs-working-dir
      (cond
       ((is-system-p 'gnu/linux) linux-working-dir)
       ((is-system-p 'darwin) linux-working-dir)
       (else (error "setup emacs-working-dir first!"))))

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
;; (require 'all-auto-complete-config)
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
;;; Some more to come when with evil+magit
(add-to-list 'load-path (emacs-path "evil-magit"))
(require 'evil-magit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key bindings should be the last one, since many
;; functions are referenced here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'key-config)

;;; HACK: THIS MUST BE DONE AT THE END OF THE CONFIGURATION FILE!
;;; Use text mode by default (otherwise fundamental mode will be
;;; used).  This is needed after Emacs version 26.1 since text-mode is
;;; not the default mode any more.
(add-to-list 'auto-mode-alist '("" . text-mode) t)

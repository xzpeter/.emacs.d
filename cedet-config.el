;; Here is a very good tutorial on configuring cedet:
;; http://emacser.com/cedet.htm

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
(load-file (emacs-path "cedet-1.1/common/cedet.el"))
(add-to-list 'load-path (emacs-path "cedet-1.1/semantic"))


;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")

;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)

;; * These are extra functions support
;; (semantic-load-enable-excessive-code-helpers)
;; (semantic-load-enable-semantic-debugging-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languges only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
(global-srecode-minor-mode 1)

(require 'semantic-ia)

;; (require 'semantic-gcc)
;; use this command to add specific system include dir to corresponding mode
;; (semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)
(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode 1)
;; (global-set-key (kbd "<f5>") 'semantic-tag-folding-fold-block)
(global-set-key (kbd "C-c o") 'semantic-tag-folding-show-block)
(global-set-key (kbd "C-c f") 'semantic-tag-folding-fold-all)
;; (global-set-key (kbd "C-c o") 'semantic-tag-folding-show-all)

(require 'eassist)
(global-set-key (kbd "<M-f12>") 'eassist-switch-h-cpp)

;; ;; shortcut for semantic ia complete words
;; (global-set-key (kbd "M-n") 'semantic-ia-complete-symbol-menu)
;; (add-hook 'c-mode-hook
;; 	  (lambda ()
;; 	    (local-set-key (kbd "<M-f12>") 'eassist-switch-h-cpp)))
(provide 'cedet-config)

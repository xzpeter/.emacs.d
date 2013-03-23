;; configuration file for ecb (the emacs code browser)
(add-to-list 'load-path (emacs-path "ecb-2.40"))
;; This will load all the ecb
;; (require 'ecb)
;; (setq ecb-auto-activate 1)
;; (setq ecb-layout-name "right-peter")
;; (setq ecb-options-version "2.40")
(setq ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
(setq ecb-tree-indent 2)
;; (setq ecb-layout-window-sizes (quote (("right-peter" (0.30303030303030304 . 0.6756756756756757) (0.30303030303030304 . 0.2972972972972973)) ("leftright2" (0.15151515151515152 . 0.6216216216216216) (0.15151515151515152 . 0.35135135135135137) (0.23484848484848486 . 0.6216216216216216) (0.23484848484848486 . 0.35135135135135137)))))
;; (setq ecb-fix-window-size 't)
;; This will load more faster at startup, and load required things later
(setq ecb-layout-name "right-peter")
(require 'ecb-autoloads)

;; This is a fixing for emacs24 (possibly)
(setq stack-trace-on-error t)

;; load ecb at startup
;; (ecb-activate)

(provide 'ecb-config)

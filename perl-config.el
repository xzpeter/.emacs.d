;; some configs for Perl language

;; Use cperl mode instead of the default perl mode
(defalias 'perl-mode 'cperl-mode)

(defun perl-mode-load-config ()
  (autopair-mode t)
  ;; Use 4 space indents via cperl mode
  (setq
   indent-tabs-mode nil
   cperl-close-paren-offset -4
   cperl-continued-statement-offset 4
   cperl-indent-level 4
   cperl-indent-parens-as-block t
   cperl-tab-always-indent t)
  )
(add-hook 'cperl-mode-hook 'perl-mode-load-config)

(provide 'perl-config)

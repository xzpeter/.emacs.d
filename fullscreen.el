;; full screen emacs
(cond
 ((is-system-p 'gnu/linux)
  (progn
    (defun my-fullscreen ()
      (interactive)
      (x-send-client-message
        nil 0 nil "_NET_WM_STATE" 32
        '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
    ;; map fullscreen function to key F11
    (global-set-key (kbd "<f11>") 'my-fullscreen)))
 ((is-system-p 'windows-nt)
  (progn 
    (defun emacs-maximize ()
      "Maximize emacs window in windows os"
      (interactive)
      (w32-send-sys-command 61488))        ; WM_SYSCOMMAND #xf030 maximize
    (defun emacs-minimize ()
      "Minimize emacs window in windows os"
      (interactive)
      (w32-send-sys-command #xf020))    ; #xf020 minimize
    (defun emacs-normal ()
      "Normal emacs window in windows os"
      (interactive)
      (w32-send-sys-command #xf120))    ; #xf120 normalimize
    (global-set-key (kbd "<f11>") 'emacs-maximize)))
 ((is-system-p 'cygwin) nil))

(provide 'fullscreen)

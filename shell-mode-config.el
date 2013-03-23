;; config shell mode

(defun my-shell-mode-clear-screen ()
  "Clear all the shell buffer, just like normal shell. "
  (interactive)
  (erase-buffer))

(define-key shell-mode-map (kbd "C-l") 'my-shell-mode-clear-screen)

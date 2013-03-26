;; in this file, I will put some codes that are platform-specified
(defun platform-linux-startup ()
  (server-start)
  (setq browse-url-browser-function 'browse-url-generic
	browse-url-generic-program "chromium-browser"))

(defun platform-darwin-startup ()
  ;; setting /bin directory on emacs
  (setq exec-path (cons "/usr/local/bin" exec-path))
  (server-start))

;; run different startup DEFUNs
(cond
 ((is-system-p 'gnu/linux) (platform-linux-startup))
 ((is-system-p 'darwin) (platform-darwin-startup))
 ((is-system-p 'windows-nt) nil)
 ((is-system-p 'cygwin) nil))

(provide 'platform-specified-config)

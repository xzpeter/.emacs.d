;; in this file, I will put some codes that are platform-specified
(defun platform-linux-startup ()
  (server-start)
  (setq browse-url-browser-function 'browse-url-generic
	browse-url-generic-program "google-chrome"))

;; (defun darwin-open-url (url &optional new-window)
;;   (call-process "ssh" nil 0 nil
;; 				;; these are args
;; 				"mac"
;; 				"open"
;; 				"-a"
;; 				"\"/Application/Google\ Chrome.app\""
;; 				(format "\"%s\"" url)))

(defun platform-darwin-startup ()
  ;; setting /bin directory on emacs
  (setq exec-path (cons "/usr/local/bin" exec-path))
  (setq browse-url-browser-function 'browse-url-generic
		browse-url-generic-program "remote-open-url")
  ;; (setq browse-url-browser-function 'darwin-open-url)
  (server-start))

;; run different startup DEFUNs
(cond
 ((is-system-p 'gnu/linux) (platform-linux-startup))
 ((is-system-p 'darwin) (platform-darwin-startup))
 ((is-system-p 'windows-nt) nil)
 ((is-system-p 'cygwin) nil)
 ((is-system-p 'berkeley-unix) (platform-darwin-startup)))

(provide 'platform-specified-config)

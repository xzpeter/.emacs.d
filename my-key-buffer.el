;; this implements a very simple function, which sets a very special
;; buffer as my KEY BUFFER, and add a shortcut function to switch to/from
;; the specific buffer

(defvar *my-key-buffer-name* nil)
(defvar *my-key-buffer-old-buffer* nil)

(defun my-set-current-as-key-buffer ()
  "Set current buffer as my key buffer, stores in variable
`*my-key-buffer-name*'. "
  (interactive)
  (setq *my-key-buffer-name* (buffer-name (current-buffer)))
  (message "Current buffer %s saved as key buffer. "
	   *my-key-buffer-name*))

(defun my-switch-to-key-buffer-and-store ()
  "Switch to the key buffer and store the current in
`*my-key-buffer-old-buffer*'. We cannot use `other-buffer' sometimes in
  some plugins like cscope. "
  (interactive)
  (setq *my-key-buffer-old-buffer* (buffer-name (current-buffer)))
  (switch-to-buffer *my-key-buffer-name*))

(defun my-switch-between-key-buffer-and-latest ()
  "this is a very important buffer for me always. Can be set by user,
using `my-set-current-as-key-buffer'. "
  (interactive)
  (if (null *my-key-buffer-name*)
      (message "Please set key buffer first. ")
    (if (string= (buffer-name) *my-key-buffer-name*)
	(switch-to-buffer (or *my-key-buffer-old-buffer* (other-buffer)))
      (my-switch-to-key-buffer-and-store))))

(provide 'my-key-buffer)

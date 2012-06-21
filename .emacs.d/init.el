(setq-default
 ; no startup screen
 inhibit-startup-screen t

 ; no backup/auto-save, bad idea
 backup-inhibited t
 auto-save-default nil
 make-backup-files nil

 show-trailing-whitespace t

 ; newline to end of buffer before save
 require-final-newline t)

; no menu bar
(menu-bar-mode -1)

; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

; arrows to change active window
(global-set-key (kbd "<up>") 'windmove-up)
(global-set-key (kbd "<down>") 'windmove-down)
(global-set-key (kbd "<right>") 'windmove-right)
(global-set-key (kbd "<left>") 'windmove-left)

; use one of these names for shell buffer
(setq shell-names '("s0" "s1" "s2" "s3" "s4" "s5" "s6" "s7" "s8" "s9"))
(defun get-shell-name (names)
  (if names
      (if (get-buffer (car names))
	  (get-shell-name (cdr names))
	(car names))
    nil))
(defun rename-shell-buffer ()
  (let ((shell-name (get-shell-name shell-names)))
    (if shell-name
	(rename-buffer shell-name)
      (message "No more free shell names, use M-x rename-buffer"))))
(add-hook 'shell-mode-hook 'rename-shell-buffer)

; start shell if no file's given
(unless (> (length command-line-args) 1)
  (shell))

(setq-default
 ; no startup screen
 inhibit-startup-screen t

 ; no backup/auto-save, bad idea
 backup-inhibited t
 auto-save-default nil
 make-backup-files nil

 ; highlight trailing whitespace
 show-trailing-whitespace t

 ; newline to end of buffer before save
 require-final-newline t)

; no menu bar
(menu-bar-mode -1)

; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

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

; for column numbers in modline
; it seems to work without this as well
(column-number-mode 1)

; custom modeline
(setq-default
 mode-line-format
 (list
  ; line number
  "%04l"
  ":"
  ; column number
  "%2c"
  " "
  ; if buffer modified then **, else '  '
  ; if it is read-only then RO
  '(:eval (if (buffer-modified-p)
	      "**"
	   (if buffer-read-only
	       "RO"
	     "  ")))
  " "
  ; host name upto first dot
  '(:eval (replace-regexp-in-string "\\..*$" "" system-name))
  '(:eval (if buffer-file-name
	      (let*
		   ; file path
		  ((path (replace-regexp-in-string "[^/]*$" "" buffer-file-name))
		   ; abbrevated file path
		   (a-path (replace-regexp-in-string (getenv "HOME") "~" path))
		   ; file name
		   (file (replace-regexp-in-string ".*/" "" buffer-file-name))
		   ; buffer name
		   (buf (buffer-name)))
		; if file name is same as buffer name then print file name only
		; else print both but put buffer name in '><'
		(concat ":" a-path (if (string= file buf)
				       (propertize file 'face 'minibuffer-prompt)
				     (concat file
					     " >" (propertize buf 'face 'font-lock-comment-face) "<"))))
	    (propertize (concat " " (buffer-name)) 'face 'font-lock-keyword-face )))
  ; other stuff
  " [%p/%I] %m"
  '(vc-mode vc-mode)
  " %e "))

; show parens, brackets
(show-paren-mode t)
; no delay in highlight
(setq show-paren-delay 0)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

; ruby mode for gemfiles and rakefiles
(add-to-list 'auto-mode-alist (cons (concat (regexp-opt '("Gemfile" "Rakefile") t) "\\'") 'ruby-mode))

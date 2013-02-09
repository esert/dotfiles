(load (expand-file-name "~/.emacs.d/custom.el"))

(setq-default
 inhibit-startup-screen t ;; no startup screen
 backup-inhibited t ;; no backup/auto-save, bad idea
 auto-save-default nil
 make-backup-files nil
 show-trailing-whitespace t ;; highlight trailing whitespace
 require-final-newline t ;; newline to end of buffer before save
 default-tab-width 4
 )

(menu-bar-mode -1) ;; no menu bar
(fset 'yes-or-no-p 'y-or-n-p) ;; y/n instead of yes/no
(show-paren-mode t) ;; show parens, brackets
(setq show-paren-delay 0) ;; no delay in highlight

;; use one of these names for shell buffer
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

;; start shell if no command line args given
(unless (> (length command-line-args) 1) (shell))

;; for column numbers in modline
;; it seems to work without this as well
(column-number-mode 1)

;; custom modeline
(setq-default
 mode-line-format
 (list
  "%04l" ;; line number
  ":" ;; column number
  "%2c"
  " "
  ;; if buffer modified then **, else '  '
  ;; if it is read-only then RO
  '(:eval (if (buffer-modified-p)
	      "**"
	   (if buffer-read-only
	       "RO"
	     "  ")))
  " "
  '(:eval (replace-regexp-in-string "\\..*$" "" system-name))  ;; host name upto first dot
  '(:eval (if buffer-file-name
	      (let*
		   ;; file path
		  ((path (replace-regexp-in-string "[^/]*$" "" buffer-file-name))
		   ;; abbrevated file path
		   (a-path (replace-regexp-in-string (getenv "HOME") "~" path))
		   ;; file name
		   (file (replace-regexp-in-string ".*/" "" buffer-file-name))
		   ;; buffer name
		   (buf (buffer-name)))
		;; if file name is same as buffer name then print file name only
		;; else print both but put buffer name in '><'
		(concat ":" a-path (if (string= file buf)
				       (propertize file 'face 'minibuffer-prompt)
				     (concat file
					     " >" (propertize buf 'face 'font-lock-comment-face) "<"))))
	    (propertize (concat " " (buffer-name)) 'face 'font-lock-keyword-face )))
  " [%p/%I] %m"
  '(vc-mode vc-mode)
  " %e "))


(add-to-list 'load-path (expand-file-name "~/.emacs.d/external/haml-mode"))
(require 'haml-mode)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/external/sass-mode"))
(require 'sass-mode)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/external/scss-mode"))
(require 'scss-mode)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/external/js2-mode"))
(require 'js2-mode)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/external/rhtml-mode"))
(require 'rhtml-mode)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/external/go-mode"))
(require 'go-mode-load)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/external/yaml-mode"))
(require 'yaml-mode)

;; ruby mode for gemfiles and rakefiles
(add-to-list 'auto-mode-alist (cons (concat (regexp-opt '("Gemfile" "Rakefile") t) "\\'") 'ruby-mode))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; rhtml mode for html.erb files
(add-to-list 'auto-mode-alist (cons (concat (regexp-opt '(".rhtml" ".html.erb") t) "\\'") 'rhtml-mode))

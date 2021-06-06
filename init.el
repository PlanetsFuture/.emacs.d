;;; init.el --- A Fancy and Fast Emacs Configuration.	-*- lexical-binding: t no-byte-compile: t -*-

;;; Commentary:
;;
;; Danny Emacs - A Fancy and Fast Emacs Configuration.
;;

;;; Code:

(when (version< emacs-version "25.1")
  (error "This requires Emacs 25.1 and above!"))

;; Speed up startup
(defvar danny-gc-cons-threshold (if (display-graphic-p) 16000000 1600000)
  "The default value to use for `gc-cons-threshold'. If you experience freezing,
decrease this. If you experience stuttering, increase this.")

(defvar danny-gc-cons-upper-limit (if (display-graphic-p) 400000000 100000000)
  "The temporary value for `gc-cons-threshold' to defer it.")

(defvar danny-gc-timer (run-with-idle-timer 10 t #'garbage-collect)
  "Run garbarge collection when idle 10s.")

(defvar default-file-name-handler-alist file-name-handler-alist)

(setq file-name-handler-alist nil)
(setq gc-cons-threshold danny-gc-cons-upper-limit
      gc-cons-percentage 0.5)
(add-hook 'emacs-startup-hook
          (lambda ()
            "Restore defalut values after startup."
            (setq file-name-handler-alist default-file-name-handler-alist)
            (setq gc-cons-threshold danny-gc-cons-threshold
                  gc-cons-percentage 0.1)

            ;; GC automatically while unfocusing the frame
            ;; `focus-out-hook' is obsolete since 27.1
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                  (lambda ()
                    (unless (frame-focus-state)
                      (garbage-collect))))
              (add-hook 'focus-out-hook 'garbage-collect))

            ;; Avoid GCs while using `ivy'/`counsel'/`swiper' and `helm', etc.
            ;; @see http://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/
            (defun my-minibuffer-setup-hook ()
              (setq gc-cons-threshold danny-gc-cons-upper-limit))

            (defun my-minibuffer-exit-hook ()
              (setq gc-cons-threshold danny-gc-cons-threshold))

            (add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
            (add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)))

;; Load path
;; Optimize: Force "lisp"" and "site-lisp" at the head to reduce the startup time.
(defun update-load-path (&rest _)
  "Update `load-path'."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

(defun add-subdirs-to-load-path (&rest _)
  "Add subdirectories to `load-path'."
  (let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

(advice-add #'package-initialize :after #'update-load-path)
(advice-add #'package-initialize :after #'add-subdirs-to-load-path)

(update-load-path)

;; backup files
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )


;; Packages
(require 'init-package)
(require 'init-appearance)
;; Preferences
(require 'init-basic)
(require 'init-hydra)
(require 'init-fonts)
(require 'init-ui)
(require 'init-transparency)
(require 'init-edit)
(require 'init-ivy)
(require 'init-company)
(require 'init-yasnippet)

(require 'init-dashboard)
(require 'init-dired)
(require 'init-highlight)
(require 'init-ibuffer)
(require 'init-kill-ring)
(require 'init-persp)
(require 'init-window)
(require 'init-treemacs)

(require 'init-eshell)
(require 'init-shell)
(require 'init-org)
(require 'init-markdown)
(require 'init-anki)
(require 'init-reader)
(require 'init-utils)

;; Programming
(require 'init-vcs)
(require 'init-projectile)
(require 'init-lsp)
(require 'init-prog)
(require 'init-c)
(require 'init-dart)
(require 'init-python)
(require 'init-rust)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init.el ends here

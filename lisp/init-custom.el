;; init-custom.el --- Define customizations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Customization.
;;

;;; Code:

(defgroup danny nil
  "Danny Emacs customization."
  :group 'convenience
  :link '(url-link :tag "Homepage" "https://github.com/PlanetsFuture/.emacs.d"))

(defcustom danny-logo (expand-file-name
                         (if (display-graphic-p) "banner.txt" "banner.txt")
                         user-emacs-directory)
  "Set Danny logo. nil means official logo."
  :group 'danny
  :type 'string)

(defcustom danny-full-name "Danny Ramírez"
  "Set user full name."
  :group 'danny
  :type 'string)

(defcustom danny-mail-address "danny.ramrez7@gmail.com"
  "Set user email address."
  :group 'danny
  :type 'string)

(defcustom danny-org-directory (expand-file-name "~/org/")
  "Set org directory."
  :group 'danny
  :type 'string)

(defcustom danny-proxy "127.0.0.1:1087"
  "Set network proxy."
  :group 'danny
  :type 'string)

(defcustom danny-server t
  "Enable `server-mode' or not."
  :group 'danny
  :type 'boolean)

(defcustom danny-icon (display-graphic-p)
  "Display icons or not."
  :group 'danny
  :type 'boolean)

;; Emacs Lisp Package Archive (ELPA)
;; @see https://github.com/melpa/melpa and https://elpa.emacs-china.org/.
(defcustom danny-package-archives-alist
  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                      (not (gnutls-available-p))))
         (proto (if no-ssl "http" "https")))
    `(,(cons 'melpa
             `(,(cons "gnu"   (concat proto "://elpa.gnu.org/packages/"))
               ,(cons "melpa" (concat proto "://melpa.org/packages/"))))
      ,(cons 'netease
             `(,(cons "gnu"   (concat proto "://mirrors.163.com/elpa/gnu/"))
               ,(cons "melpa" (concat proto "://mirrors.163.com/elpa/melpa/"))))
      ,(cons 'ustc
             `(,(cons "gnu"   (concat proto "://mirrors.ustc.edu.cn/elpa/gnu/"))
               ,(cons "melpa" (concat proto "://mirrors.ustc.edu.cn/elpa/melpa/"))))
      ,(cons 'tencent
             `(,(cons "gnu"   (concat proto "://mirrors.cloud.tencent.com/elpa/gnu/"))
               ,(cons "melpa" (concat proto "://mirrors.cloud.tencent.com/elpa/melpa/"))))
      ,(cons 'tuna
             `(,(cons "gnu"   (concat proto "://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/"))
               ,(cons "melpa" (concat proto "://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))))))
  "The package archives group list."
  :group 'danny
  :type '(alist :key-type (symbol :tag "Archive group name")
                :value-type (alist :key-type (string :tag "Archive name")
                                   :value-type (string :tag "URL or directory name"))))

(defcustom danny-package-archives 'melpa
  "Set package archives from which to fetch."
  :group 'danny
  :set (lambda (symbol value)
         (set symbol value)
         (setq package-archives
               (or (alist-get value danny-package-archives-alist)
                   (error "Unknown package archives: `%s'" value))))
  :type `(choice ,@(mapcar
                    (lambda (item)
                      (let ((name (car item)))
                        (list 'const
                              :tag (capitalize (symbol-name name))
                              name)))
                    danny-package-archives-alist)))

(defcustom danny-theme-alist
  '((default  . doom-one)
    (classic  . doom-monokai-classic)
    (dark     . doom-dark+)
    (light    . doom-one-light)
    (warm     . doom-solarized-light)
    (cold     . doom-city-lights)
    (day      . doom-tomorrow-day)
    (night    . doom-tomorrow-night))
  "List of themes mapped to internal themes."
  :group 'danny
  :type '(alist :key-type (symbol :tag "Theme")
                :value-type (symbol :tag "Internal theme")))

(defcustom danny-auto-themes '(("8:00"  . doom-one-light)
				                 ("19:00" . doom-one))
  "List of themes mapped to the time they should be loaded.

The keywords `:sunrise' and `:sunset' can be used for the time
if `calendar-latitude' and `calendar-longitude' are set.
For example:
  '((:sunrise . doom-one-light)
    (:sunset  . doom-one))"
  :group 'danny
  :type `(alist :key-type (string :tag "Time")
                :value-type (symbol :tag "Theme")))

(defcustom danny-theme 'default
  "The color theme."
  :group 'danny
  :type `(choice (const :tag "Auto" 'auto)
                 (const :tag "Random" 'random)
                 ,@(mapcar
                    (lambda (item)
                      (let ((name (car item)))
                        (list 'const
                              :tag (capitalize (symbol-name name))
                              name)))
                    danny-theme-alist)
                 symbol))

(defcustom danny-dashboard t
  "Use dashboard at startup or not.
If Non-nil, use dashboard, otherwise will restore previous session."
  :group 'danny
  :type 'boolean)

(defcustom danny-restore-frame-geometry t
  "Restore the frame's geometry at startup.
If Non-nil, save and restore the frame's geometry."
  :group 'danny
  :type 'boolean)

(defcustom danny-lsp 'lsp-mode
  "Set language server."
  :group 'danny
  :type '(choice          (const :tag "LSP Mode" 'lsp-mode)
                          (const :tag "Eglot" 'eglot)
                          (const :tag "Disable" nil)))

(defcustom danny-lsp-format-on-save-ignore-modes '(c-mode c++-mode python-mode)
  "The modes that don't auto format and organize imports while saving the buffers.
`prog-mode' means ignoring all derived modes.
"
  :group 'danny
  :type '(repeat (symbol :tag "Major-Mode")))

(defcustom danny-chinese-calendar nil
  "Use Chinese calendar or not."
  :group 'danny
  :type 'boolean)

(defcustom danny-prettify-symbols-alist
  '(("lambda" . ?λ)
    ("<-" . ?←)
    ("->" . ?→)
    ("->>" . ?↠)
    ("=>" . ?⇒)
    ("map" . ?↦)
    ("!=" . ?≠)
    ("==" . ?≡)
    ("<=" . ?≤)
    (">=" . ?≥)
    ("=<<" . (?= (Br . Bl) ?≪))
    (">>=" . (?≫ (Br . Bl) ?=))
    ("<=<" . ?↢)
    (">=>" . ?↣)
    ("not" . ?¬))
  "Alist of symbol prettifications.
Nil to use font supports ligatures."
  :group 'danny
  :type '(alist :key-type string :value-type (choice character sexp)))

(defcustom danny-prettify-org-symbols-alist
  '(
    ("#+ARCHIVE:" . ?📦)
    ("#+AUTHOR:" . ?👤)
    ("#+CREATOR:" . ?💁)
    ("#+DATE:" . ?📆)
    ("#+DESCRIPTION:" . ?⸙)
    ("#+EMAIL:" . ?📧)
    ("#+OPTIONS:" . ?⛭)
    ("#+SETUPFILE:" . ?⛮)
    ("#+TAGS:" . ?🏷)
    ("#+TITLE:" . ?📓)
    ("#+BEGIN_SRC" . ?✎)
    ("#+END_SRC" . ?□)
    ("#+BEGIN_QUOTE" . ?»)
    ("#+END_QUOTE" . ?«)
    ("#+HEADERS" . ?☰)
    ("#+RESULTS:" . ?💻))
  "Alist of symbol prettifications for `org-mode'."
  :group 'danny
  :type '(alist :key-type string :value-type (choice character sexp)))

(defcustom danny-benchmark-init nil
  "Enable the initialization benchmark or not."
  :group 'danny
  :type 'boolean)

;; Load `custom-file'
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(provide 'init-custom)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-custom.el ends here

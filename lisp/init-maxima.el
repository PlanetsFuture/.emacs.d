(add-to-list 'load-path "/Users/dannyramirez/maxima-5.45.0/interfaces/emacs")
(autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
(setq imaxima-use-maxima-mode-flag t)

(use-package maxima
  :init
  (add-hook 'maxima-mode-hook #'maxima-hook-function)
  (add-hook 'maxima-inferior-mode-hook #'maxima-hook-function)

  :mode ("\\.mac\\'" . maxima-mode)
  :interpreter ("maxima" . maxima-mode))

(provide 'init-maxima)

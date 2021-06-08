(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  (if (and (fboundp 'native-comp-available-p)
           (native-comp-available-p))
      (progn
        (message "Native comp is available")
        ;; Using Emacs.app/Contents/MacOS/bin since it was compiled with
        ;; ./configure --prefix="$PWD/nextstep/Emacs.app/Contents/MacOS"
        (add-to-list 'exec-path (concat invocation-directory "bin") t)
        (setenv "LIBRARY_PATH" (concat (getenv "LIBRARY_PATH")
                                       (when (getenv "LIBRARY_PATH")
                                         ":")
                                       ;; This is where Homebrew puts gcc libraries.
                                       (car (file-expand-wildcards
                                             (expand-file-name "~/homebrew/opt/gcc/lib/gcc/*")))))
        ;; Only set after LIBRARY_PATH can find gcc libraries.
        (setq comp-deferred-compilation t))
    (message "Native comp is *not* available")))

(provide 'init-gccemacs)


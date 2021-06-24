;; init-dart.el --- Initialize Dart configurations.	-*- lexical-binding: t -*-

;;; Commentary:
;;
;; Dart configurations.
;;

;;; Code:

;; Dart
(use-package dart-mode
  :defines (projectile-project-root-files-bottom-up)
  :config
  (with-eval-after-load 'projectile
    (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
    (add-to-list 'projectile-project-root-files-bottom-up "BUILD")))

(use-package dart-mode
  :hook (dart-mode . flutter-test-mode))

(use-package flutter
  :after dart-mode
  :init
  (setq flutter-sdk-path "~/flutter/")
  :bind
  (:map dart-mode-map
        ("C-M-x" . #'flutter-run-or-hot-reload)))

(provide 'init-dart)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-dart.el ends here

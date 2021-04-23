;;; Code:
;; Android

(use-package android-env
  :after hydra
  :bind (("C-c a" . hydra-android/body))
  :config
  (setq android-env-executable "./gradlew")
  (setq android-env-test-command "connectedDevDebugAndroidTest")
  (setq android-env-unit-test-command "testDevDebug")
  (android-env))

(provide 'init-android)

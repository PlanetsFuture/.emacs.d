
;; emacs transparency
(set-frame-parameter (selected-frame) 'alpha '(98 100))
(add-to-list 'default-frame-alist '(alpha 98 100))

(eval-when-compile (require 'cl))
(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(98 100))))
(global-set-key (kbd "C-c ^") 'toggle-transparency)

;; Set transparency of emacs
(defun transparency (arg &optional active)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nEnter alpha value (1-100): \np")
  (let* ((elt (assoc 'alpha default-frame-alist))
         (old (frame-parameter nil 'alpha))
         (new (cond ((atom old)     `(,arg ,arg))
                    ((eql 1 active) `(,arg ,(cadr old)))
                    (t              `(,(car old) ,arg)))))
    (if elt (setcdr elt new) (push `(alpha ,@new) default-frame-alist))
    (set-frame-parameter nil 'alpha new)))
(global-set-key (kbd "C-c %") 'transparency)


(provide 'init-transparency)


;;; doxymacs site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(load "doxymacs-autoloads" nil t)
(add-hook 'c-mode-common-hook 'doxymacs-mode)

(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

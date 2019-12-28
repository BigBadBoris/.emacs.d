;; Configuration for editing lisps, such a emacs list, scheme, CL, Clojure, etc

;; Automatically load paredit when editing a lisp file 
(autoload 'enable-paredit-mode
  "paredit"
  "Turn on pseudo-structural editing of Lisp Code"
  t)

;; Paredit hooks
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)

;; Rainbow delimiters mode
(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook #'rainbow-delimiters-mode)
(add-hook 'scheme-mode-hook #'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)



;; highlight-defined hook for emacs lisp
(add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode)


;; Slime

(setq inferior-lisp-program "/usr/bin/sbcl")

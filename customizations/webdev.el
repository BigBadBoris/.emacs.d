;; Config for Web development (Javascript, html, css, etc)

(require 'web-mode)

;; Filename extensions
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

;; 2 spaced tabs brudda
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)

;; highlight current element in html
(setq web-mode-enable-current-element-highlight t)

(define-key web-mode-map (kbd "M-RET") 'web-mode-element-close)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

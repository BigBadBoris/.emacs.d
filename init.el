;;
;; Emacs Garbage cleanup
;;

;; turn off menu-bar
(menu-bar-mode -1)

;; turn off scroll bar
(when (fboundp `scroll-bar-mode)
  (scroll-bar-mode -1))

;; turn off splash screen
(setq inhibit-splash-screen t)


;; turn of tool-bar
(when (fboundp 'tool-bar-mode)
	(tool-bar-mode -1))

;; set larger font-size for better readability
(set-face-attribute `default nil :height 120)

;; turn off the FUCKING BELL
(setq ring-bell-function `ignore)

;; Makes killing/yanking interactive with OS
(setq x-select-enable-primary t
      x-select-enable-clipboard t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t)

;; turn off cursor blinking
(blink-cursor-mode 0)

;; full-screen on startup
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (ido-completing-read+))))

;; change all yes/no questions to y/n type
(fset `yes-or-no-p `y-or-n-p)

;; Move backup files to a backup directory
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)


;;
;; Package Initialization
;;

;; Add MELPA, a package repository with pretty much everything you'd want
(require `package)
(add-to-list `package-archives `("melpa" . "http://melpa.org/packages/"))

;; load and activate all emacs packages
(package-initialize)

;; Refresh package contents
(when (not package-archive-contents)
  (package-refresh-contents))

;; Add your packages here
(defvar my-packages
  `(;; id oallows you to navigate choices easy by presenting lists, auto-complete, etc
    ido-completing-read+
    ;; Org mode is the shit when you're tryna take notes, make TODO's, etc
    org
    ;; prettifies org bullets
    org-bullets
    ;; speed-typing game
    speed-type
    ;; Git intergration
    magit
    ;; Makes editing sexps easy as pie
    paredit
    ;; pretty parens
    rainbow-delimiters
    ;; Guile Intergration (REPL, etc)
    geiser
    ;; Python IDE Stuff
    elpy
    ;; auto completion
    company
    ;; tree navigation
    neotree
    ;; highlight defined functions/macros in emacs lisp
    highlight-defined
    ;; markdown
    markdown-mode
    ;; Common Lisp REPL
    slime
    ;; web editing (html, css, etc)
    web-mode
    ;; Javascript
    js2-mode
    ;; The actual documentation
    dash-docs
    ;; Very Large Files
    vlf
    ;; requirement for dash-docs
    helm-dash
    ;;
    vscode-dark-plus-theme
    ;; graphviz .dot files support
    graphviz-dot-mode
    ;; symbol navigation
    ggtags
    ;; device-tree mode
    dts-mode
    ;; java lsp
    lsp-java
    ;; flycheck
    flycheck
    ;; parsing
    parsec
    ;; completion front-end
    counsel))

;; Install all packages if they aren't around (for new systems)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;;
;; Themes
;;

(load-theme 'vscode-dark-plus t)


;;
;; UI
;;

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set line numbers
(global-linum-mode 1)

;;
;; Naviagation
;;

;; Turn on recent file mode so that you can more easily switch to
;; recently edited files when you first start emacs
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" `recentf-open-files)

;; Ido mode stuff
;; (ido-mode 1)
;; ;; this allows fuzzy-matching
;; (setq ido-enable-flex-matching t)
;; ;; don't use filename at point
;; (setq ido-use-filename-at-point nil)
;; ;; Shows buffer names of recently opened files, even if they're not currently open
;; (setq ido-use-virtual-buffers t)
;; ;; Let Ido roam free! use ido everywhere it is useful
;; (ido-ubiquitous-mode t)
;; (ido-everywhere t)
;; ;; Show list of buffere
;; (global-set-key (kbd "C-x C-b") `ibuffer)

;; Ivy

(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)


;;
;; External File Stuff
;;

;; load up customizations folder to emac's PATH
(add-to-list `load-path "~/.emacs.d/customizations")

;; Python Stuff
(load "python-editing.el")

;; Org-Mode
(load "org-mode.el")

;; General Lisp Editing
(load "lisp-editing.el")

;; Web editing
(load "webdev.el")

;; Documentation lookup
(load "documentation.el")

;; Navigation Stuff
(load "navigation.el")

;; Editing C/C++
(load "c-editing.el")

;; (load "java.el")

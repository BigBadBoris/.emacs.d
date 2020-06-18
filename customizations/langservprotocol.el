;; load emacs-cquery library
(load "cquery/cquery-call-hierarchy.el")
(load "cquery/cquery-code-lens.el")
(load "cquery/cquery-common.el")
(load "cquery/cquery-inheritance-hierarchy.el")
(load "cquery/cquery-semantic-highlighting.el")
(load "cquery/cquery-tree.el")
(load "cquery/cquery.el")

;; load emacs-cquery
(require 'cquery)
(setq cquery-executable "/usr/local/cquery/build/cquery")

;; function to enable cquery
(defun cquery//enable ()
  (condition-case nil
      (lsp)
    (user-error nil)))

;; add cquery hook for C/C++ modes
(add-hook 'c-mode-hook #'cquery//enable)
(add-hook 'c++-mode-hook #'cquery//enable)

;; ORG-MODE CUSTOMIZATIONS
(global-set-key (kbd "C-c l") `org-store-link)
(global-set-key (kbd "C-c a") `org-agenda)
(global-set-key (kbd "C-c c") `org-capture)
(global-set-key (kbd "C-c b") `org-switchb)

;; Allow time-stamping when finishing TODO item
(setq org-log-done `time)

;; enable org-bullets
(require `org-bullets)
(add-hook `org-mode-hook (lambda () (org-bullets-mode 1)))




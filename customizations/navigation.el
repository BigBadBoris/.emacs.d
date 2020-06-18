;; Code for general emacs navigation

;; Set f8 to open file browser window
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; 
(global-set-key [S-left] 'windmove-left)
(global-set-key [S-right] 'windmove-right)
(global-set-key [S-up]  'windmove-up)
(global-set-key [S-down] 'windmove-down)

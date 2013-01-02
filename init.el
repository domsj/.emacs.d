(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(add-to-list 'load-path
  (expand-file-name "expand-region.el" user-emacs-directory))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-+") 'er/contract-region)

;(require 'unbound)
(load-file "~/.emacs.d/unbound.el")

; wind move http://emacswiki.org/emacs/WindMove
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

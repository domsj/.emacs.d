(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path
  (expand-file-name "expand-region" user-emacs-directory))


(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-+") 'er/contract-region)

(require 'unbound)

; resize windows
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

; wind move http://emacswiki.org/emacs/WindMove
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))


(require 'auto-complete)
(add-hook 'emacs-lisp-mode-hook 'auto-complete-mode)
(add-hook 'clojure-mode-hook 'auto-complete-mode)

(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)

(autoload 'paredit-mode "paredit")
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)

(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(require 'yasnippet)
(yas-global-mode 1)

(add-to-list 'load-path (expand-file-name "helm" user-emacs-directory))
(require 'helm-config)
(global-set-key (kbd "C-x C-h") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching nil)
; die helm projectile werkt precies niet...
;(require 'helm-projectile)

(put 'upcase-region 'disabled nil)

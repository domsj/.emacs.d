(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path (expand-file-name "expand-region" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "helm" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "workgroups" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "twittering-mode" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "bookmark-plus" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "undo-tree" user-emacs-directory))

(when window-system
  (exec-path-from-shell-initialize))

(require 'undo-tree)
(undo-tree-mode)

(require 'bookmark+)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-+") 'er/contract-region)

(require 'unbound)

; http://earthviaradio.wordpress.com/2012/02/06/swapping-the-left-alt-and-ctrl-keys-in-ubuntu-11-10/

; C-, is not available in flyspell mode... so also leave the M-x binding
;(global-unset-key (kbd "M-x"))
(global-set-key (kbd "C-,") 'smex)

; resize windows
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

; wind move http://emacswiki.org/emacs/WindMove
; (when (fboundp 'windmove-default-keybindings)
;   (windmove-default-keybindings))

(setq set-mark-command-repeat-pop 1)

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

(require 'helm-config)
(global-set-key (kbd "C-x C-h") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching nil)
; die helm projectile werkt precies niet...
;(require 'helm-projectile)

(require 'workgroups)
(setq wg-prefix-key (kbd "C-c w"))

(require 'twittering-mode)
(setq twittering-use-master-password t)

; open buffer menu in same window
(global-set-key (kbd "\C-x\C-b") 'buffer-menu)

; fancier goto-line from http://whattheemacsd.com/key-bindings.el-01.html
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))
(global-set-key [remap goto-line] 'goto-line-with-feedback)


(require 'window-number)
(window-number-meta-mode)
(window-number-mode)

(global-set-key (kbd "C-S-f") 'forward-word)
(global-set-key (kbd "C-S-b") 'backward-word)

;;;;;;;;;;;; emacs auto inserted stuff below

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(show-trailing-whitespace t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

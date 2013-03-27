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

(setenv "CAML_LD_LIBRARY_PATH" "/home/jan/Development/ROOT/OPAM_ROOT/system/lib/stublibs:/home/jan/Development/ROOT/OCAML/lib/ocaml/stublibs")
(setenv "OPAMROOT" "/home/jan/Development/ROOT/OPAM_ROOT")
(setenv "OCAML_TOPLEVEL_PATH" "/home/jan/Development/ROOT/OPAM_ROOT/system/lib/toplevel")
(setenv "MANPATH" "/home/jan/Development/ROOT/OPAM_ROOT/system/man:")
(setenv "PATH" "/home/jan/Development/ROOT/OPAM_ROOT/system/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/jan/Development/ROOT/OCAML/bin:/home/jan/Development/ROOT/OPAM/bin")

(load-file "~/.emacs.d/typerex-append.el")

;; indent using spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(require 'undo-tree)
(undo-tree-mode)

(require 'bookmark+)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-+") 'er/contract-region)

(require 'unbound)

; resize windows
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

; keep on popping marks with C-space
(setq set-mark-command-repeat-pop 1)

(require 'auto-complete)
(add-hook 'emacs-lisp-mode-hook 'auto-complete-mode)
(add-hook 'clojure-mode-hook 'auto-complete-mode)

(setq inferior-lisp-program "bash browser-repl")

(global-set-key (kbd "<XF86Back>") 'previous-buffer)
(global-set-key (kbd "<XF86Forward>") 'next-buffer)

(global-set-key (kbd "M-g s") 'helm-do-grep)

(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-x m") 'eshell)
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; replace buffer-menu with ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; a la steve yegge
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)


;; duplicate the current line or region
;; TODO get function somewhere
; (global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)

;; http://stackoverflow.com/questions/10506496/run-browse-url-in-emacs-without-giving-focus-to-the-browser

;; (require 'ac-nrepl)
;; (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
;; (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'nrepl-mode))

;; (define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)

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

(global-set-key (kbd "C-x f") 'find-file-in-repository)

(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching nil)
; die helm projectile werkt precies niet...
;(require 'helm-projectile)

(require 'workgroups)
(setq wg-prefix-key (kbd "C-c w"))

(require 'twittering-mode)
(setq twittering-use-master-password t)
(setq twittering-icon-mode t)
(setq twittering-use-icon-storage t)
(autoload 'twittering-numbering "twittering-numbering" nil t)
(add-hook 'twittering-mode-hook 'twittering-numbering)


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
; M-g g is the default emacs goto-line shortcut


(require 'window-number)
(window-number-meta-mode)
(window-number-mode)

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

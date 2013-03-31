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
(add-to-list 'load-path (expand-file-name "emacs-skype" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "emms/lisp" user-emacs-directory))


(when window-system
  (exec-path-from-shell-initialize))

(setenv "CAML_LD_LIBRARY_PATH" "/home/jan/Development/ROOT/OPAM_ROOT/system/lib/stublibs:/home/jan/Development/ROOT/OCAML/lib/ocaml/stublibs")
(setenv "OPAMROOT" "/home/jan/Development/ROOT/OPAM_ROOT")
(setenv "OCAML_TOPLEVEL_PATH" "/home/jan/Development/ROOT/OPAM_ROOT/system/lib/toplevel")
(setenv "MANPATH" "/home/jan/Development/ROOT/OPAM_ROOT/system/man:")
(setenv "PATH" "/home/jan/Development/ROOT/OPAM_ROOT/system/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/jan/Development/ROOT/OCAML/bin:/home/jan/Development/ROOT/OPAM/bin")

; typerex 2
(with-temp-buffer (insert (shell-command-to-string "ocp-edit-mode emacs -load-global-config")) (eval-buffer))

;; (require 'bookmark+)
(require 'unbound)
(require 'expand-region)
(require 'undo-tree)
(require 'rainbow-delimiters)
(require 'yasnippet)
(require 'helm-config)
(require 'window-number)
(require 'buffer-move)


(add-hook 'ibuffer-mode-hook 'hl-line-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(undo-tree-mode)
(yas-global-mode 1)


(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-+") 'er/contract-region)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x m") 'eshell)
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)

; fancier goto-line from http://whattheemacsd.com/key-bindings.el-01.html
; M-g g is the default emacs goto-line shortcut
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))
(global-set-key [remap goto-line] 'goto-line-with-feedback)


;; duplicate the current line or region
;; TODO get function somewhere
; (global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)

;; http://stackoverflow.com/questions/10506496/run-browse-url-in-emacs-without-giving-focus-to-the-browser


(ido-mode 1)
(tool-bar-mode -1)                             ; No toolbar
(menu-bar-mode -1)                             ; No menubar
(scroll-bar-mode -1)                           ; No scrollbar
(setq inhibit-startup-message t)               ; No message at startup
(setq visible-bell t)                          ; No beep when reporting errors
(global-font-lock-mode 1)                      ; Color enabled
(setq set-mark-command-repeat-pop 1)
(electric-pair-mode +1)

(blink-cursor-mode 0)                          ; No blinking cursor
; (setq track-eol nil)                           ; Cursor don't track end-of-line
; (setq mouse-yank-at-point t)                   ; Paste at cursor position
; (setq scroll-preserve-screen-position t)       ; Scroll without moving cursor
(column-number-mode t)                         ; Show column number in mode-line

;; indent using spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(setq-default indicate-empty-lines t)          ; Show empty lines
(setq next-line-add-newlines t)                ; Add newline when at buffer end
(setq require-final-newline 't)                ; Always newline at end of file
(show-paren-mode 1)                            ; Highlight parenthesis pairs
(setq window-min-height 10)                    ; Minimal height of windows
(setq enable-recursive-minibuffers t)          ; Stack  minibuffers
(icomplete-mode t)                             ; Completion in mini-buffer
(setq read-buffer-completion-ignore-case 't)   ; Ignore case when completing buffer names
(setq undo-limit 100000)                       ; Increase number of undo
(defalias 'yes-or-no-p 'y-or-n-p)              ; y/n instead of yes/no


;;; ----------- finding & opening files

(defun find-file-as-root ()
  "Like `ido-find-file, but automatically edit the file with
root-privileges (using tramp/sudo), if the file is not writable by
user."
; http://www.blogger.com/comment.g?blogID=3992530807750384868&postID=5611080369015051953
  (interactive)
  (let ((file (ido-read-file-name "Edit as root: ")))
    (unless (file-writable-p file)
      (setq file (concat "/sudo:root@localhost:" file)))
    (find-file file)))

(global-set-key (kbd "C-x C-h") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x f") 'find-file-in-repository)
(global-set-key (kbd "C-x F") 'find-file-as-root)

(global-set-key (kbd "M-g s") 'helm-do-grep)

;;; ----------- end opening files

;;; ----------- buffer and window management

(global-set-key (kbd "<XF86Back>") 'previous-buffer)
(global-set-key (kbd "<XF86Forward>") 'next-buffer)

; replace buffer-menu with ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

; resize windows
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(window-number-meta-mode)
(window-number-mode)

(winner-mode 1)

; move buffers
(global-set-key (kbd "<s-up>")     'buf-move-up)
(global-set-key (kbd "<s-down>")   'buf-move-down)
(global-set-key (kbd "<s-left>")   'buf-move-left)
(global-set-key (kbd "<s-right>")  'buf-move-right)

;;; ----------- end buffer and window management

(require 'skype)
(setq skype--my-user-handle "jan_doms")
(skype--init)

(require 'emms-setup)
(emms-standard)
(emms-all)
(setq emms-player-list '(emms-player-mplayer
                         emms-player-mplayer-playlist))
(require 'emms-volume)
(global-set-key (kbd "<XF86AudioRaiseVolume>") (lambda () (interactive) (emms-volume-raise)))
(global-set-key (kbd "<XF86AudioLowerVolume>") (lambda () (interactive) (emms-volume-lower)))
(global-set-key (kbd "<XF86AudioMute>") (lambda () (interactive) (emms-pause)))
(global-set-key (kbd "<XF86AudioPlay>") (lambda () (interactive) (emms-pause)))


;; (setq gnus-select-method '(nnimap "gmail"
;;                                   (nnimap-address "imap.gmail.com")
;;                                   (nnimap-server-port 993)
;;                                   (nnimap-stream ssl)))
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials '(("smtp.gmail.com" 587 "username@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587
;;       smtpmail-local-domain "gmail.com")



;; (require 'projectile)
;; (projectile-global-mode)
;; (setq projectile-enable-caching nil)
; die helm projectile werkt precies niet...
;(require 'helm-projectile)

;; (require 'workgroups)
;; (setq wg-prefix-key (kbd "C-c w"))

(require 'twittering-mode)
(setq twittering-use-master-password t)
(setq twittering-icon-mode t)
(setq twittering-use-icon-storage t)


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

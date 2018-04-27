;;; "Let's use Emacs again! It'll be great!" (Jake Pittis 2018)

;;; --- Package management. ---

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;;; --- Vanilla configuration. ---

;; Don't show the menu bars.
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Disabe startup screen.
(setq inhibit-startup-message t)

;; Smooth scrolling with a margin.
(setq scroll-conservatively 10)
(setq scroll-margin 7)

;; Full line cursor.
(global-hl-line-mode 1)

;; Show your line and column numbers.
(setq line-number-mode t)
(setq column-number-mode t)

;; Some auto generated code added by Custom.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(package-selected-packages (quote (autopair solarized-theme evil))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Set a better font.
(set-face-attribute 'default nil :family "Monaco")

;; Start emacs maximized.
(toggle-frame-maximized)

;; Solarized.
(load-theme 'solarized-dark t)

;; Toggle between dark and light.
(setq active-theme 'solarized-dark)
(defun toggle-theme ()
  (interactive)
  (if (eq active-theme 'solarized-light)
      (setq active-theme 'solarized-dark)
    (setq active-theme 'solarized-light))
  (load-theme active-theme))

;; Auto indentation.
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Better parens.
(require 'autopair)
(autopair-global-mode)
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Spaces please.
(setq-default indent-tabs-mode nil)

;;; --- Evil mode. ---

(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")

(require 'evil)
(evil-mode t)

;; Don't move the cursor back when leaving insert mode.
(setq evil-move-cursor-back nil)

;; Make escape work!
(defun minibuffer-keyboard-quit ()
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

(evil-leader/set-key
  "e" 'open-emacs-init)

(defun open-emacs-init ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

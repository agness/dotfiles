;; snufffleupagus emacs config

;; load packages (emacs23 method, but it works)
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; load packages emacs24 way (bugs!)
;(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;               ("marmalade" . "http://marmalade-repo.org/packages/")
;               ("melpa" . "http://melpa.milkbox.net/packages/")))

(defvar my-packages '(idle-highlight-mode
                      auto-complete
		            highlight-indentation
			          yasnippet
                      python-mode
                      epc
                      jedi
                      color-theme-solarized))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; include packages

(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")

(require 'auto-complete)
(global-auto-complete-mode t)

;emacs24 built-in goodies
(electric-pair-mode t)

;solarized prereq: set xterm264 in terminal
(load-theme 'solarized-dark t)

(require 'yasnippet)
(yas-reload-all)

(defun my-coding-hook ()
  (yas-minor-mode)
  (global-set-key (kbd "C-c SPC") 'yas-expand)
  (electric-indent-mode t)
  (global-hl-line-mode 1)
  (idle-highlight-mode t))
(add-hook 'python-mode-hook 'my-coding-hook)
(add-hook 'js-mode-hook 'my-coding-hook)
(add-hook 'emacs-lisp-mode-hook 'my-coding-hook)

(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation-mode)
(add-hook 'js-mode-hook 'highlight-indentation-mode)

;python autocomplete library
(require 'python-mode) 
(setq jedi:setup-keys t)
(add-hook 'python-mode-hook 'jedi:setup)

;ipython pipe
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
(setq py-force-py-shell-name-p t)
;switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
;don't split windows
(setq py-split-windows-on-execute-p nil)
;try to automagically figure out indentation
;(setq py-smart-indentation t)

;; window aesthetics
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq fill-column 80)
(setq lazy-highlight-cleanup nil)

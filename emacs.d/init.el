;; snufffleupagus emacs config

;; load packages (emacs23 method, but it works)
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
;(when (not package-archive-contents)
;  (package-refresh-contents))

;; load packages emacs24 way (bugs!)
;(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;               ("marmalade" . "http://marmalade-repo.org/packages/")
;               ("melpa" . "http://melpa.milkbox.net/packages/")))

(defvar my-packages '(idle-highlight-mode
                      auto-complete
                      highlight-indentation
                      yasnippet
                      rainbow-mode
                      python-mode
                      go-mode
                      epc
                      jedi
;                      multi-web-mode
                      ruby-mode
                      ruby-electric
                      inf-ruby
;                      ruby-compilation
                      rinari
                      rhtml-mode
                      color-theme-solarized))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-refresh-contents) (package-install p)))

;; include packages

(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")

(require 'auto-complete)
(global-auto-complete-mode t)

;emacs24 built-in goodies
(electric-pair-mode t)
(show-paren-mode 1)

;insert spaces instead of tabs if major mode didn't define a default
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;solarized prereq: set xterm264 in terminal
(load-theme 'solarized-dark t)

(require 'yasnippet)
(yas-reload-all)

(require 'rainbow-mode)
(setq rainbow-html-colors nil) ;don't colorize words like "gray"
(add-hook 'css-mode-hook 'rainbow-mode)

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
(add-hook 'html-mode-hook 'highlight-indentation-mode)

;; web mix
;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
;; (require 'multi-web-mode)
;; (setq mweb-default-major-mode 'html-mode)
;; (setq mweb-tags
;;   '((js-mode  "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;;     (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;; (setq mweb-filename-extensions '("htm" "html"))
;; (multi-web-global-mode 1)
;associate less files with css editor
(add-to-list 'auto-mode-alist '("\\.less\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))

;; python
(require 'python-mode) 
;autocomplete library
(setq jedi:setup-keys t)
(add-hook 'python-mode-hook 'jedi:setup)
;repl ipython pipe
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

;; golang
(require 'go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)

;; ruby/rails
(require 'ruby-mode)
(setq ruby-indent-level 2) ;i guess NP uses 2
;rails
(require 'rinari)
(add-hook 'ruby-mode-hook 'rinari-minor-mode)
(require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode))
;repl
(require 'inf-ruby)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
;automatically add 'end' after class, module, etc.; pair braces, quotes, etc.
(require 'ruby-electric)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)
;; Missing from ruby-mode.el, see https://groups.google.com/group/emacs-on-rails/msg/565fba8263233c28
(defun ruby-insert-end ()
  (interactive)
  (insert "end")
  (ruby-indent-line t)
    (end-of-line))
;file associations
(add-to-list 'auto-mode-alist
  '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
  '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
;enable outlining for ruby
; (add-hook 'ruby-mode-hook
;   '(lambda ()
;     (outline-minor-mode)
;       (setq outline-regexp " *\\(def \\|class\\|module\\|describe \\|it \\)")))

;; window aesthetics
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq fill-column 80)
(setq lazy-highlight-cleanup nil)

;; port of eclipse move text line/region
;source: https://groups.google.com/d/msg/gnu.emacs.help/dd2R_UV0LVQ/F06ihLb7hKcJ
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
        (transpose-lines arg))
      (forward-line -1)))))

(defun move-text-down (arg)
     "Move region (transient-mark-mode active) or current line arg lines down."
     (interactive "*p")
     (move-text-internal arg))

(defun move-text-up (arg)
     "Move region (transient-mark-mode active) or current line arg lines up."
     (interactive "*p")
     (move-text-internal (- arg)))

(global-set-key (kbd "C-c <up>") 'move-text-up)
(global-set-key (kbd "C-c <down>") 'move-text-down)

;; move to window spatially
(global-set-key (kbd "C-c j") 'windmove-left)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c i") 'windmove-up)
(global-set-key (kbd "C-c k") 'windmove-down)

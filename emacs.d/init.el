(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(setq package-list '(
;                     ein ;ipython
;                     auctex-latexmk
                     color-theme-solarized
                     ))
(package-initialize)

; fetch packages
(unless package-archive-contents
  (package-refresh-contents))

; install missing packages
(dolist (p package-list)
  (unless (package-installed-p p)
    (package-install p)))

; use ido for files
(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

; change all prompts to y or n
(fset 'yes-or-no-p 'y-or-n-p)

; centralize backup and autosave files in tmp dir
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(electric-pair-mode t)
(show-paren-mode 1)
(setq visible-bell t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

; delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; require final newline so github stops complaining once and for all
(setq require-final-newline t)

; show column position in addition to default line position
(setq column-number-mode t)

; auto wrap lines > 80 characters, else make big ugly green highlight
(defun eighty-char-hook ()
  (auto-fill-mode t)
  (set-fill-column 80)
  (highlight-lines-matching-regexp ".\\{81\\}" 'hi-green-b))
(add-hook 'prog-mode-hook 'eighty-char-hook)

; use solarized color scheme
(load-theme 'solarized t)
(setq frame-background-mode 'dark)

; window aesthetics
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(setq fill-column 80)
(setq lazy-highlight-cleanup nil)

; port of eclipse move text line/region
; source: https://groups.google.com/d/msg/gnu.emacs.help/dd2R_UV0LVQ/F06ihLb7hKcJ
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (color-theme-solarized))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

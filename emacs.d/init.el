;; Packages
;; Install with M-x package-install-selected-packages.
(setq package-selected-packages '(solarized-theme))

(when (package-installed-p 'solarized-theme)
  (load-theme 'solarized-dark t))

;; Interface

(setq inhibit-startup-screen t
      visible-bell t
      column-number-mode t
      use-short-answers t)

(menu-bar-mode -1)
(show-paren-mode 1)
(electric-pair-mode 1)

;; Built-in completion, minibuffer history
(fido-mode 1)
(savehist-mode 1)

;; Editing

(setq-default indent-tabs-mode nil
              tab-width 2
              fill-column 80
              require-final-newline t)

;; Show the 80-column boundary
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; Del trailing spaces on save except in prose and markup files.
(defun clean-code-before-save ()
  "Delete trailing whitespace when saving a programming buffer."
  (when (derived-mode-p 'prog-mode)
    (delete-trailing-whitespace)))
(add-hook 'before-save-hook #'clean-code-before-save)

;; Spatial window movement.
(global-set-key (kbd "C-c j") #'windmove-left)
(global-set-key (kbd "C-c l") #'windmove-right)
(global-set-key (kbd "C-c i") #'windmove-up)
(global-set-key (kbd "C-c k") #'windmove-down)

(provide 'init)

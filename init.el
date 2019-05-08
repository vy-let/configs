;;;
;;; Vy-let's Emacs startup file
;;;
;;; Copyright 2016 - 2018 Violet Baddley. Your use of this
;;; configuration is subject to the license set forth in the
;;; License.markdown file distributed with this software.
;;;
;;; If you're unsure how to use this configuration, please refer to
;;; the Readme.markdown file.
;;;



;;
;; Change the Easy Customization File
;;
;; The very first thing we must do is move the annoying "custom"
;; variables outside of this file, because they're noisy and don't
;; belong in version control. I'm setting this here, in case anything
;; at the head of the file decides to write to it. Farther below
;; (after having gotten the first essential packages) I load the file.
;;
(setq custom-file
      (expand-file-name "local-prefs.el"
                        "~/.emacs.d"))


;;
;; Start by auto-installing use-package and the themes.
;;
;; Use-package will gather all our dependencies. The exception is the
;; themes, because they're referenced by the easy customization
;; (local-prefs.el) file, and so must be ready super early.
;;

(setq shell-file-name "/bin/sh")
(require 'package)

; activate all the packages (in particular autoloads)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(setq package-list '(base16-theme
                     use-package))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(eval-when-compile
  (require 'use-package))

(require 'bind-key)



;;
;; Set up themes, faces, and other visual styles
;;

(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(setq base16-distinct-fringe-background nil)
(setq base16-theme-256-color-source "colors")
(setq custom-safe-themes t)  ;; blindly trust themes
(load-theme 'base16-tomorrow-night t)


;; Make window dividers effectively invisible
(set-face-attribute 'vertical-border nil
                    :foreground (face-attribute 'default :background))
(set-face-attribute 'window-divider nil
                    :foreground (face-attribute 'default :background))
(set-face-attribute 'window-divider-first-pixel nil
                    :foreground (face-attribute 'default :background))
(set-face-attribute 'window-divider-last-pixel nil
                    :foreground (face-attribute 'default :background))


;; Make the window margins nice and aesthetically comfy.
(setq-default left-margin-width 5
              right-margin-width 5)
(set-window-margins nil 5 5)
(add-to-list 'default-frame-alist '(internal-border-width . 15))





;;
;; Load the local preferences file if it exists
;;

(load custom-file
      t    ;; without raising errors
      t )  ;; silently






;;
;; Basic environmental settings
;;



;; TOTE – The Only Text Encoding
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(set-locale-environment "en_US.UTF-8")
(prefer-coding-system 'utf-8)


;; I'll want beeps or flashes at the heat death of the universe.
(setq ring-bell-function 'ignore)





(if (display-graphic-p)
    (progn  ;; has graphical system
      ;; (desktop-save-mode 1)  ; Not saving dasktop b/c it makes the mouse pointer go weird
      (setq blink-cursor-blinks 0)  ;; keep blinking cursor forever
      (tool-bar-mode -1)
      (scroll-bar-mode -1)

      (global-set-key (kbd "s-n") 'make-frame-command)

      (if (eq system-type 'darwin)
          (progn  ;; only if graphical mac
            (mac-auto-operator-composition-mode))

        (progn  ;; graphical but not mac
          (menu-bar-mode -1)
          (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))))))

  (progn    ;; isatty
    (menu-bar-mode -1)
    (xterm-mouse-mode 1)
    (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
    (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
    (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))))


;; Set option = meta to match behavior over tty, but leave
;; right-option unbound for entering spécial characters.
(setq mac-option-modifier 'meta
      mac-right-option-modifier nil
      mac-command-modifier 'super)

;; Normally comment-line is `C-x C-;` but `C-;` cannot be sent over
;; tty. `C-x ;` normally invokes `comment-set-column` which I've never
;; needed, so just clobber that.
(global-set-key (kbd "C-x ;") 'comment-line)


;; Behavior
(electric-pair-mode 1)
(setq inhibit-startup-screen t)
(setq initial-major-mode 'fundamental-mode)  ;; scratch buffer


;; Indentation
(setq-default indent-tabs-mode nil)
(setq js-indent-level 2)
(setq js2-basic-offset 2)
(setq-default sh-basic-offset 2
              sh-indentation 2)
(setq css-indent-offset 2)
(setq vc-follow-symlinks t)

;; Be a good programming citizen
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-auto-revert-mode 1)  ;; for when git updates the FS
(setq ruby-insert-encoding-magic-comment nil)
(setq enh-ruby-add-encoding-comment-on-save nil)

;; What is this, 1983?
(add-hook 'prog-mode-hook 'visual-line-mode)
(delete-selection-mode 1)

;; Add standard command-key functions.
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-b") 'switch-to-buffer)
(global-set-key (kbd "C-x k") 'kill-this-buffer)



;;
;; Editor Niceties
;;



(use-package avy
  :ensure t  ;; This should be built-in, not sure why it's not always available
  :init (progn
          (setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s)
                avy-all-windows nil)
          (global-set-key (kbd "C-z") 'avy-goto-char)
          (global-set-key (kbd "M-z") 'avy-goto-line)
          (global-set-key (kbd "M-Z") 'avy-goto-end-of-line)
          (global-set-key (kbd "C-M-z") 'avy-goto-word-0))

  :config (progn
            ;; These are the colors that are used to highlight possible
            ;; matches. They are sampled from base16 tomorrow night
            ;; theme. I thought about just referencing the colors right
            ;; out of the theme, but that would become brittle if one
            ;; later decided to switch to a different theme and
            ;; uninstalled the base16 themes package.
            (set-face-attribute 'avy-lead-face nil
                                :foreground "#1d1f21" :background "#81a2be")
            (set-face-attribute 'avy-lead-face-0 nil
                                :foreground "#1d1f21" :background "#b294bb")
            (set-face-attribute 'avy-lead-face-2 nil
                                :foreground "#1d1f21" :background "#cc6666")))



(use-package shackle
  ;; redefines pop-up window behavior
  :ensure t
  :init (progn
          (setq shackle-rules '(("\\`\\*helm.*?\\*\\'" :regexp t :align below :size 0.3)
                                ("*Org Export Dispatcher*" :select t :align right :size 0.3)
                                ("\\*Org.*?\\'" :regexp t :select t :align right :size 0.3)
                                ("\\`\\*Help.*?\\*\\'" :regexp t :select t :align right :size 86)
                                ("\\`\\*Backtrace.*?\\'" :regexp t :select t :align right :size 86)
                                ("\\`\\*Compile-Log.*?\\'" :regexp t :select t :align below :size 0.1)
                                ('magit-status-mode :same t :inhibit-window-quit t)
                                ))
          (shackle-mode)))



(use-package smart-mode-line
  :ensure t
  :init (use-package smart-mode-line-powerline-theme
          :ensure t
          :init (progn
                  (setq powerline-arrow-shape 'curve)
                  (setq sml/theme 'powerline)
                  (sml/setup))))



;; (use-package smartparens
;;   :ensure t
;;   :hook ((prog-mode . smartparens-mode)
;;          (prog-mode . show-smartparens-mode))
;;   :config (require 'smartparens-config))



(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))



(use-package anzu
  ;; Shows you how many i-search results there are
  :ensure t
  :config (global-anzu-mode +1))



(use-package winum
  :ensure t
  :demand t  ; immediately show window numbers

  :bind (( "C-x o" . winum-select-window-by-number )
         ( "M-1" . winum-select-window-1 )
         ( "M-2" . winum-select-window-2 )
         ( "M-3" . winum-select-window-3 )
         ( "M-4" . winum-select-window-4 )
         ( "M-5" . winum-select-window-5 )
         ( "M-6" . winum-select-window-6 )
         ( "M-7" . winum-select-window-7 )
         ( "M-8" . winum-select-window-8 )
         ( "M-9" . winum-select-window-9 ))

  :config (progn
            (setq-default winum-scope 'visible)
            (require 'winum)
            (winum-mode) ))



(use-package adaptive-wrap
  :ensure t
  :hook (( prog-mode . adaptive-wrap-prefix-mode )
         ( markdown-mode . adaptive-wrap-prefix-mode )
         ( org-mode . adaptive-wrap-prefix-mode )
         ( org-mode . visual-line-mode )))



;; (use-package nyan-mode
;;   :if (display-graphic-p)
;;   :ensure t
;;   :init (nyan-mode))



;;
;; Helm
;;



(use-package helm
  :ensure t
  :init (progn
          (setq helm-display-function 'pop-to-buffer)  ; for use with shackle
          (require 'helm-config)
          (helm-mode 1))

  :bind (( [remap find-file]    . helm-find-files )
         ( [remap occur]        . helm-occur )
         ( [remap list-buffers] . helm-buffers-list )
         ( [dabbrev-expand]     . helm-dabbrev )
         ( "M-x" . helm-M-x ))

  :config (progn
            (unless (boundp 'completion-in-region-function)
              (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
              (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))
            (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
            (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)))



;;
;; Project Organization
;;



(use-package projectile
  :ensure t
  :config (progn
            (setq projectile-enable-caching t)
            (projectile-global-mode)

            ;; The C-c p leader key used to be set by default, but is not anymore.
            (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)))



(use-package helm-projectile
  :ensure t
  :demand t  ; don't wait for me to hit one of the keys
  :after (helm projectile)
  :bind (( "M-s-t" . helm-projectile-switch-project )
         ( "s-t" . helm-projectile-find-file ))
  :config (progn
            (require 'helm-projectile)
            (helm-projectile-on)))



(use-package magit
  :ensure t
  :demand t  ;; Need to demand to keep global-git-commit-mode at the ready
  :commands magit-status
  :bind ("C-x g" . magit-status)
  :config (progn
            (global-git-commit-mode t)

            ;; Removes conflicting keybindings with winum window-switchers:
            (define-key magit-status-mode-map (kbd "M-1") nil)
            (define-key magit-status-mode-map (kbd "M-2") nil)
            (define-key magit-status-mode-map (kbd "M-3") nil)
            (define-key magit-status-mode-map (kbd "M-4") nil) ))



(use-package treemacs
  :ensure t
  ;; do setqs in config
  :config (progn
            (treemacs-filewatch-mode t))
  :bind (( "M-0" . treemacs-select-window )
         ( "C-x t t" . treemacs )
         ( "C-x t f" . treemacs-find-file )))



(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile)
  :bind ("C-x t p" . treemacs-projectile)
  :commands treemacs-projectile)



(use-package perspective
  ;; Thanks @nex3!
  :ensure t
  :config (progn
            (persp-mode))
  :bind (( "s-p s" . persp-switch )
         ( "s-p k" . persp-remove-buffer)
         ( "s-p c" . persp-kill)
         ( "s-p r" . persp-rename)
         ( "s-p a" . persp-add-buffer)
         ( "s-p A" . persp-set-buffer)
         ( "s-p i" . persp-import)
         ( "s-p <right>" . persp-next)
         ( "s-p <left>" . persp-prev)))



;;
;; Major Editing Modes
;;



;; enh-ruby mode requires a ruby executable.
(if (file-exists-p "/usr/bin/ruby")
    ;; when present, set up enh-ruby-mode by default, but also install
    ;; ruby-mode as a fallback if needed.
    (progn
      (use-package enh-ruby-mode
        :ensure t
        :mode "\\.rb$"
        :commands enh-ruby-mode
        :config (setq enh-ruby-program "/usr/bin/ruby"
                      enh-ruby-check-syntax nil))

      (use-package ruby-mode
        :ensure t
        :commands ruby-mode))

  ;; otherwise, when ruby is not present, just install and use
  ;; ruby-mode by default.
  (use-package ruby-mode
    :ensure t
    :commands ruby-mode
    :mode "\\.rb$"))



(use-package rjsx-mode
  :ensure t
  :commands rjsx-mode
  :mode "\\.jsx$"
  :config (progn
            (setq js2-mode-show-parse-errors nil
                  js2-mode-show-strict-warnings nil)

            ;; Keep js2 from making function params an odd green.
            (set-face-attribute 'js2-function-param nil
                                :foreground 'unspecified
                                :inherit 'default)))



(use-package web-mode
  :ensure t
  :commands web-mode
  :mode "\\.\\(erb\\|html\\)\\'"
  :config (progn
            (require 'web-mode)

            (defun my-web-mode-hook ()
              ;; (setq web-mode-enable-auto-pairing nil)  ; to be compatible with smartparens
              (setq web-mode-markup-indent-offset 2)
              (setq web-mode-code-indent-offset 2))

            (add-hook 'web-mode-hook 'my-web-mode-hook)

            ;; also to be compatible with smartparens:
            (defun sp-web-mode-is-code-context (id action context)
              (and (eq action 'insert)
                   (not (or (get-text-property (point) 'part-side)
                            (get-text-property (point) 'block-side)))))))



(use-package yaml-mode
  :ensure t
  :commands yaml-mode
  :mode "\\.ya?ml\\(\\.sample\\)?\\'")



(use-package json-mode
  :ensure t
  :commands json-mode
  :mode "\\.json$")



(use-package fish-mode
  :ensure t
  :commands fish-mode
  :mode "\\.fish$")



(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode "\\.\\(md\\|markdown\\)$"
  :config (progn

            ;; Prefer Common Mark if present. Fall back to the
            ;; original markdown perl script, and then to a generic
            ;; binary otherwise.

            (cond ((executable-find "cmark")
                     (setq markdown-command "cmark") )
                  ((executable-find "Markdown.pl")
                     (setq markdown-command "Markdown.pl") )
                  ((executable-find "markdown")
                     (setq markdown-command "markdown") ))

            ;; Basic prefs
            (setq markdown-header-scaling t)
            (set-face-attribute 'markdown-code-face nil
                                :inherit 'fixed-pitch)

            ;; Markdown is mainly for human language text, and should
            ;; always use visual line mode. See `adaptive-wrap`,
            ;; above, which keeps the hanging indent on wide list
            ;; lines.

            (defun my-md-mode-hook ()
              (visual-line-mode 1)
              (variable-pitch-mode t))
            (add-hook 'markdown-mode-hook 'my-md-mode-hook)
            (add-hook 'gfm-mode-hook 'my-md-mode-hook)))



(use-package vlf
  ;; very large files
  :ensure t
  :init (require 'vlf-setup))



(use-package terraform-mode
  :ensure t
  :commands terraform-mode
  :mode "\\.\\(tf|tfvars\\)$")



;;
;; Org mode setup and export backends
;;



(use-package org
  :mode (("\\.org$" . org-mode))
  :defer t
  :config (progn
            (set-face-attribute 'org-level-1 nil :height 2.0)
            (set-face-attribute 'org-level-2 nil :height 1.5)
            (set-face-attribute 'org-level-3 nil :height 1.25)
            (set-face-attribute 'org-level-4 nil :height 1.125)
            (set-face-attribute 'org-level-5 nil :height 1.0)

            ;; Rebind (C-u org-toggle-checkbox) to (C-c c) because its default keybinding is bizarre:

            (defun my/org-toggle-checkbox-presence ()
              (interactive)
              (setq current-prefix-arg '(4))  ;; simulate C-u prefix
              (call-interactively 'org-toggle-checkbox))
            (define-key org-mode-map (kbd "C-c c") #'my/org-toggle-checkbox-presence)

            ;; The following messing around with org-mode windowing is originally from
            ;; <https://github.com/sk8ingdom/.emacs.d/blob/master/general-config/general-plugins.el>
            ;; and modified by me.

            ;; **HACK** Force org-mode to use standard window-opening functions that shackle hooks into:
            (defun org-switch-to-buffer-other-window (args)
              (switch-to-buffer-other-window args))

            ;; Define a function-wrapper to suppress calls to delete-other-windows, because that behavior super duper fucking annoying.
            (defun my/suppress-delete-other-windows (old-fun &rest args)
              (cl-flet ((silence (&rest args) (ignore)))
                (advice-add 'delete-other-windows :around #'silence)
                (unwind-protect
                    (apply old-fun args)
                  (advice-remove 'delete-other-windows #'silence))))

            ;; Any interactive function which I normally use in org-mode, that creates a new buffer, should be listed here:
            (advice-add 'org-export-dispatch :around #'my/suppress-delete-other-windows)
            ))

(use-package ox-jira
  ;; Backend for bizarre jira syntax
  :ensure t
  :defer t)

(setq org-export-backends
      ;; These are the defaults. Not sure how to avoid re-defining
      ;; them, because this list must be set before org-mode loads.
      '(ascii
        html
        icalendar
        latex
        odt

        ;; These are the ones we want to add.
        md
        jira))



;;
;; Custom functionality that should totally be built-in
;;



(defun scroll-half-page-down ()
  "scroll down half the page"
  (interactive)
  (scroll-down (/ (window-body-height) 2))
  (move-to-window-line nil))

(defun scroll-half-page-up ()
  "scroll up half the page"
  (interactive)
  (scroll-up (/ (window-body-height) 2))
  (move-to-window-line nil))

(global-set-key [remap scroll-down-command] 'scroll-half-page-down)
(global-set-key [remap scroll-up-command] 'scroll-half-page-up)

;; Taken directly from
;; https://emacs.stackexchange.com/questions/32958/insert-line-above-below#answer-32959
(defun insert-line-above ()
  (interactive)
  (save-excursion
    (end-of-line 0)
    (open-line 1)))

;; M-o is chosen as a counterpart to C-o, except that it leaves the
;; current line alone and leaves the cursor where it is.
(global-set-key (kbd "M-o") 'insert-line-above)

;; A version of kill-word (from simple.el) that doesn't save to the
;; kill ring.
(defun sensible-forward-delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun sensible-delete-word (arg)
  (interactive "p")
  (sensible-forward-delete-word (- arg)))

(global-set-key (kbd "M-DEL") 'sensible-delete-word)
(global-set-key (kbd "M-d") 'sensible-forward-delete-word)

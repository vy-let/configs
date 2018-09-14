;;;
;;; Violet Baddley's Emacs startup file
;;;
;;; Most of the meaty stuff happens right after the boilerplate
;;; custom-set-variables section. If you're curious, go ahead and skip
;;; on down to the "END CUSTOM" heading.
;;;



;;
;; Start by auto-installing use-package:
;;

(setq shell-file-name "/bin/sh")
(require 'package)

; activate all the packages (in particular autoloads)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(setq package-list '(color-theme-sanityinc-tomorrow  ; must be loaded for custom section not to blow up
                     use-package))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(eval-when-compile
  (require 'use-package))

(require 'bind-key)

(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")



;;
;; Begin Custom Section
;;



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#c5c8c6" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#373b41"))
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "06ed008240c1b9961a0214c87c078b4d78e802b811f58b8d071c396d9ff4fcb6" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(electric-pair-mode t)
 '(enh-ruby-check-syntax nil)
 '(fci-rule-color "#373b41")
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(initial-major-mode (quote fundamental-mode))
 '(markdown-header-scaling-values (quote (2.0 1.7 1.4 1.1 1.0 1.0)))
 '(midnight-delay 10800)
 '(midnight-mode t)
 '(package-selected-packages
   (quote
    (perspective smart-quotes adaptive-wrap winum treemacs-projectile treemacs projectile helm shackle enh-ruby-mode markdown-mode rainbow-delimiters color-theme-sanityinc-tomorrow vlf window-numbering anzu neotree web-mode json-mode yaml-mode csv-mode golden-ratio-scroll-screen aggressive-indent fish-mode nyan-mode dash smartparens magit helm-projectile)))
 '(ruby-insert-encoding-magic-comment nil)
 '(send-mail-function (quote mailclient-send-it))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hasklig" :foundry "nil" :slant normal :weight medium :height 120 :width normal))))
 '(fixed-pitch ((t (:weight normal :width normal :family "Hasklig"))))
 '(fringe ((t (:background "#1d1f21" :foreground "#969896"))))
 '(highlight ((t (:background "gray20"))))
 '(markdown-code-face ((t (:inherit fixed-pitch :background "#1d1f21" :foreground "#b294bb" :height 0.75))))
 '(smerge-refined-added ((t (:inherit smerge-refined-change :background "#2a5100"))))
 '(variable-pitch ((t (:height 160 :family "Alegreya"))))
 '(vertical-border ((t (:foreground "#1d1f21"))))
 '(window-divider ((t nil)))
 '(window-divider-first-pixel ((t nil)))
 '(window-divider-last-pixel ((t nil))))




;;
;; END CUSTOM
;;




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


;; Make the window margins nice and aesthetically comfy.
(setq-default left-margin-width 5
              right-margin-width 5)
(set-window-margins nil 5 5)
(add-to-list 'default-frame-alist '(internal-border-width . 15))


(if (display-graphic-p)
    (progn  ;; has graphical system
      ;; (desktop-save-mode 1)  ; Not saving dasktop b/c it makes the mouse pointer go weird
      (tool-bar-mode -1)
      (scroll-bar-mode -1)

      (global-set-key (kbd "s-n") 'make-frame-command)

      (if (eq system-type 'darwin)
          (progn  ;; only if graphical mac
            (mac-auto-operator-composition-mode))))

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



(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq-default indent-tabs-mode nil)
(setq js-indent-level 2)
(setq js2-basic-offset 2)
(setq-default sh-basic-offset 2
              sh-indentation 2)
(setq css-indent-offset 2)
(setq vc-follow-symlinks t)

;; Be a good programming citizen
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-auto-revert-mode 1)  ;; for when git updates the FS

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



(use-package shackle
  ;; redefines pop-up window behavior
  :ensure t
  :init (progn
          (setq shackle-rules '(("\\`\\*helm.*?\\*\\'" :regexp t :align t :size 0.3)
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



(use-package smartparens
  :ensure t
  :hook ((prog-mode . smartparens-mode)
         (prog-mode . show-smartparens-mode))
  :config (require 'smartparens-config))



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
            (require 'winum)
            (winum-mode) ))



(use-package adaptive-wrap
  :ensure t
  :hook (( prog-mode . adaptive-wrap-prefix-mode )
         ( markdown-mode . adaptive-wrap-prefix-mode )))



(use-package nyan-mode
  :if (display-graphic-p)
  :ensure t
  :init (nyan-mode))



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
            (projectile-global-mode)))



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
  :commands magit-status
  :bind ("C-x g" . magit-status)
  :config (progn
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
        :config (setq enh-ruby-program "/usr/bin/ruby"))

      (use-package ruby-mode
        :ensure t
        :commands ruby-mode))

  ;; otherwise, when ruby is not present, just install and use
  ;; ruby-mode by default.
  (use-package ruby-mode
    :ensure t
    :commands ruby-mode
    :mode "\\.rb$"))



(use-package web-mode
  :ensure t
  :commands web-mode
  :mode "\\.\\(erb\\|html\\)\\'"
  :config (progn
            (require 'web-mode)

            (defun my-web-mode-hook ()
              (setq web-mode-enable-auto-pairing nil)  ; to be compatible with smartparens
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

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-



;;
;; BASIC DOOM STUFF
;; plus some classic Vy settings around basic editor behavior
;;

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; (setq user-full-name "Whoever"
;;       user-mail-address "idunno@invalid")

(setq doom-theme 'doom-tomorrow-night
      doom-font (if (eq system-type 'darwin) "Hasklig-12"
                  "Hasklig-9")
      doom-variable-pitch-font "Input Sans"
      auto-insert nil ;; don't autofill template into files
      confirm-kill-emacs nil
      )

(setq org-directory "~/Documents/")



(setq tab-always-indent t)
(setq display-line-numbers-type nil)

;; Make the window margins nice and aesthetically comfy.
;; TODO: Need to figure out what in Doom is conflicting with these sometimes
;; (setq-default left-margin-width 4
;;               right-margin-width 4)
;; (set-window-margins nil 4 4)
(add-to-list 'default-frame-alist '(internal-border-width . 15))

;; Make the line spacing more reasonable
(setq-default line-spacing 0.2)



;;
;; CONFIGURING PACKAGES
;;



(use-package! avy
  :bind
  (("C-t" . avy-goto-subword-0)
   ("C-z" . avy-goto-char)
   ("M-z" . avy-goto-line)
   ("M-Z" . avy-goto-end-of-line))

  :config
  (setq avy-keys '(?t ?e ?n ?o ?s ?a ?h ?u  ?d ?i  ?m ?p  ?c ?r ?l)
        avy-all-windows nil)

  (set-face-attribute 'avy-lead-face nil
                      :foreground "#1d1f21" :background "#81a2be")
  (set-face-attribute 'avy-lead-face-0 nil
                      :foreground "#1d1f21" :background "#b294bb")
  (set-face-attribute 'avy-lead-face-2 nil
                      :foreground "#1d1f21" :background "#cc6666"))



;; Shows you how many i-search results there are
(use-package! anzu
  :config
  (global-anzu-mode +1))



;; Disable annoying, arbitrary code style annotations
(use-package! lsp-mode
  :commands lsp-install-server  ; repeat from module to avoid eager-loading
  :config
  (setq lsp-diagnostics-provider :none
        lsp-ui-sideline-enable nil
        lsp-enable-snippet nil
        lsp-modeline-diagnostics-enable nil
        lsp-signature-render-documentation nil
        ;lsp-enable-symbol-highlighting nil
        lsp-headerline-breadcrumb-enable nil))

(use-package! company
  :hook (prog-mode . company-mode)
  :init (setq company-global-modes nil
              company-idle-delay 1.0))



(use-package! web-mode
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        typescript-indent-level 2))

(use-package! yaml-mode
  :mode "\\.ya?ml\\.sample\\'")



;; Vertico is like Helm but better, I guess?
(use-package! vertico
  :bind
  ;; C-x C-b  => use vertico to switch buffers
  (( [remap ibuffer] . +vertico/switch-workspace-buffer )))



(use-package! winum
  :bind
  (( "M-1" . winum-select-window-1 )
   ( "M-2" . winum-select-window-2 )
   ( "M-3" . winum-select-window-3 )
   ( "M-4" . winum-select-window-4 )
   ( "M-5" . winum-select-window-5 )
   ( "M-6" . winum-select-window-6 )
   ( "M-7" . winum-select-window-7 )
   ( "M-8" . winum-select-window-8 )
   ( "M-9" . winum-select-window-9 )))



;;
;; CUSTOM FUNCTIONALITY
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

;; Normally comment-line is `C-x C-;` but `C-;` cannot be sent over
;; tty. `C-x ;` normally invokes `comment-set-column` which I've never
;; needed, so just clobber that.
(global-set-key (kbd "C-x ;") 'comment-line)

;; Easier just to kill the current buffer. Don't ask me which one.
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; M-o is chosen as a counterpart to C-o, except that it leaves the
;; current line alone and leaves the cursor where it is.
(global-set-key (kbd "M-o") 'insert-line-above)

;; Standard Mac-like command-T switch to file
(global-set-key (kbd "s-t") 'projectile-find-file)

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

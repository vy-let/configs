;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el



;; Include some of the newer themes
(unpin! doom-themes)

;; Remove some absolute disgraces
(package! flycheck :disable t)
(package! rubocop :disable t)

;; Anzu comes by default, but no use in counting on that
(package! anzu)

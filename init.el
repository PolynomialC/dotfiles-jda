;; init.el - Minimal, Modern, Fast

;; 1. Global UI Tweak (No bloat)
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(electric-pair-mode 1)
(setq-default indent-tabs-mode nil)

;; 2. Package Management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; 3. Must-Have Packages
(use-package vertico :ensure t :init (vertico-mode)) ;; Better search UI
(use-package which-key :ensure t :init (which-key-mode)) ;; Shows shortcuts
(use-package magit :ensure t :bind ("C-x g" . magit-status)) ;; Pro Git UI

;; 4. Syntax Highlighting & Safety (LSP)
(use-package eglot
  :ensure nil ;; Built-in in Emacs 29+
  :hook ((python-mode . eglot-ensure)
         (js-mode . eglot-ensure)
         (rust-mode . eglot-ensure))
  :config
  (setq eglot-autoshutdown t))

(load-theme 'modus-vivendi t) ;; High-contrast dark theme for Ghostty
;; init.el --- skeleton config  -*- lexical-binding: t; coding:utf-8; fill-column: 119 -*-

;; Commentary:
;; A bare-boned config template. Use "outshine-cycle-buffer" (<Tab> and <S-Tab>
;; in org style) to navigate through sections, and "imenu" to locate individual
;; use-package definition.
(setq comp-speed 3
      comp-deferred-compilation t)

;;; Bootstrap
(server-start)
;;;; Temporarily Remove file handler list to nil
(defvar temp--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
;;;; Set Tab Width
(setq-default tab-width 2)
(setq-default evil-shift-width tab-width)
(setq-default indent-tabs-mode nil)

;;;; Hide native-comp compiler warnings
(setq comp-async-report-warnings-errors nil)

;;;; Set Warning level
(setq warning-minimum-level :error)

;;;; Make yes or no prompt simpler
(defalias 'yes-or-no-p 'y-or-n-p)

;;;; Always follow symlinks
(setq vc-follow-symlinks t)

;;;; Speed up startup
(setq gc-cons-threshold 100000000)
(setq gc-cons-percentage 0.6)
(setq read-process-output-max (* 1024 1024))



(add-hook 'after-init-hook
          `(lambda ()
             (setq gc-cons-threshold 100000000
                   gc-cons-percentage 0.1)
             (garbage-collect)) t)

;;; Line Numbers
;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;;;; Initialize straight.el
(setq straight-cache-autoloads t
      straight-check-for-modifications '(check-on-save find-when-checking)
      straight-repository-branch "develop"
      straight-use-package-by-default t
      use-package-always-ensure nil)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
                         user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(autoload 'straight-x-clean-unused-repos "straight-x" nil t)

(straight-use-package 'use-package)

;;; Fonts
;;;; Setting DIfferent fonts
(set-face-attribute 'default nil
                       :font "Iosevka Nerd Font 12"
                       :weight 'regular)

(set-face-attribute 'default nil
                       :font "Iosevka Nerd Font 12"
                       :weight 'regular)
(set-face-attribute 'fixed-pitch nil
                       :font "Iosevka Nerd Font 12"
                       :weight 'regular)
;;;; Unicode
(use-package unicode-fonts
  :straight t)

;;; Frames Only Mode
(use-package frames-only-mode
  :straight t
  :config
  (frames-only-mode))
;;; Profiler

(use-package esup
  :init
  (setq esup-depth 0)
  
  :straight t)

;;; Outshine mode
(use-package outshine
  :defer t
  ;; Easier navigation for source files, especially this one.
  :bind (:map outshine-mode-map
              ("<S-iso-lefttab>" . outshine-cycle-buffer)
              ("<tab>" . outshine-cycle)))

;;; Appearance
(use-package all-the-icons
  :straight t
  :config
  (setq all-the-icons-scale-factor 1.0))
;;;; Emojis
(use-package emojify
  :defer 1
  :straight t)
;;;; Color Themes
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-nord t)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
 
;;;; Dired
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode)
  :straight t)
;; ;;;; Modeline
(use-package mood-line
  :straight t
  :config
  (mood-line-mode))

;;; Keybindings
;;;; Which-Key
(use-package which-key
  :straight t
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
;;;; General Leader Keybindings
(use-package general
  :straight t
  :config
;;;;; Configuration
  (general-evil-setup t)
  (general-create-definer leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (general-create-definer localleader-key-def
    :keymaps 'override
    :states '(emacs normal hybrid motion visual operator)
    :prefix "SPC m"
    "" '(:ignore t :which-key (lambda (arg) `(,(cadr (split-string (car arg) " ")) . ,(replace-regexp-in-string "-mode$" "" (symbol-name major-mode))))))
;;;;;; Projectile
  (leader-key-def
    "p"   '(:ignore t :which-key "project")
    "pf"  '(projectile-find-file :which-key "find file")
                                        ;"SPC"  '(counsel-projectile-find-file :which-key "find file")
    "pp"  '(projectile-persp-switch-project :which-key "switch project")
    "pi"  '(projectile-ag :which-key "search project symbols")
    "pF"  '(projectile-rg :which-key "search project")
    "pa"  '(projectile-add-known-project :which-key "add project")
    "pd"  '(projectile-remove-known-project :which-key "remove project"))
;;;;;; Magit 
  (leader-key-def
    "g"   '(:ignore t :which-key "git")
    "gg"  'magit-status
    "gd"  '(magit-diff-unstaged)
    "gc"  '(magit-commit :which-key "commit")
    "gC"  '(magit-clone :which-key "clone")
    "gl"  '(:ignore t :which-key "log")
    "glc" '(magit-log-current :which-key "current branch")
    "glf" '(magit-log-buffer-file :which-key "current file")
    "gb"  '(magit-branch :which-key "branch")
    "gP"  '(magit-push-current :which-key "push")
    "gp"  '(magit-pull-branch :which-key "pull")
    "gf"  '(magit-fetch :which-key "fetch")
    "gF"  '(magit-fetch-all :which-key "fetch all")
    "gr"  '(magit-rebase :which-key "rebase"))
;;;;;; Files
  (leader-key-def
    "f" '(:ignore t :which-key "files")
    "ff" '(find-file :which-key "find file")
    "fb" '(consult-buffer :which-key "find file")
    "fr" '(consult-recent-file :which-key "recent files"))
;;;;;; Search
  (leader-key-def
    "s" '(:ignore t :which-key "search")
    "ss" '(consult-isearch :which-key "ibuffer")
    "si" '(consult-line :which-key "buffer")
    "sd" '(dired-jump :which-key "directory")
    "sp" '(projectile-switch-project :which-key "projects"))
;;;;;; LSP  
  (leader-key-def
    "c" '(:ignore t :which-key "code")
    "cf" '(eglot-format :which-key "format")
    "ci" '(consult-imenu :which-key "jump to symbol")
    "cd" '(xref-find-definitions
           :which-key "goto definition")
    "cr" '(xref-find-references :which-key "find references")
    "ck" '(eldoc :which-key "documentation")
    "cR" '(eglot-rename :which-key "rename")
    "ce" '(:which-key "errors")
    "cel" '(consult-flycheck :which-key "list errors")
    "cen" '(next-error :which-key "next error")
    "cep" '(previous-error :which-key "prevous error")
    "ca" '(eglot-code-action-quickfix :which-key "code-actions"))

;;;;;; Workspaces
  (leader-key-def
    "w"  '(:ignore t :which-key workspaces)
    "wb" '(persp-switch-to-buffer :which-key "switch buffer")
    "wn" '(persp-next :which-key "next workspace")
    "wk" '(persp-kill :which-key "delete workspace")
    "ws" '(persp-switch :which-key "switch workspace"))
;;;;;; Evil   
  (general-evil-setup t)
  (general-mmap
    "j" 'evil-next-visual-line
    "gc" 'evilnc-comment-operator
    "k" 'evil-previous-visual-line)
;;;;;; Evaluating Lisp
  (leader-key-def
    "e"   '(:ignore t :which-key "eval")
    "eb"  '(eval-buffer :which-key "eval buffer"))
  (leader-key-def
    :keymaps '(visual)
    "er" '(eval-region :which-key "eval region")))
;;;; Hydra
(use-package hydra
  :straight t)
;;;; Evil
(use-package evil
  :straight t
  :defer 0.5
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal))

(use-package evil-nerd-commenter
  :straight t
  :after evil
  :defer 0.5
  :config
  (evilnc-default-hotkeys))

(use-package evil-surround
  :straight t
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-textobj-anyblock
  :straight t
  :after evil
  :defer 0.5)

(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-company-use-tng nil)  ;; Is this a bug in evil-collection?
  :custom
  (evil-collection-outline-bind-tab-p nil)
  :config
  (evil-collection-init))

;;;;; Undo
(use-package undo-fu
  :after evil
  :straight t
  :config
  (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo))

;;;; Parenthesis

;;;;; Smart Parens
(use-package smartparens
  :straight t
  :hook (prog-mode . smartparens-mode))

;;; Vertico
(use-package vertico
  :straight t
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))
(use-package savehist
  :init
  (savehist-mode))

(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  (defun crm-indicator (args)
    (cons (concat "[CRM] " (car args)) (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Grow and shrink minibuffer
  ;;(setq resize-mini-windows t)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

;;;; Consult
(use-package consult
  :straight t
  :config
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-root-function #'projectile-project-root)
  (setq consult-preview-key nil))
(use-package consult-flycheck
  :straight t
  :defer 1)
;;;; Marginalia
(use-package marginalia
  :straight t
  :init
  (setq-default marginalia-annotators '(marginalia-annotators-heavy))
  :config
  (marginalia-mode))
;;;; Ordering
;;;;; Orderless
(use-package orderless
  :straight t
  :config
  (savehist-mode)
 (setq completion-styles '(orderless)
         completion-category-defaults nil
         completion-category-overrides '((file (styles . (partial-completion))))
         orderless-component-separator "[ &]"
         selectrum-refine-candidates-function #'orderless-filter
         selectrum-highlight-candidates-function #'orderless-highlight-matches)
 (setq completion-styles '(orderless)))

;;;;; Magit
(use-package magit
  :straight t
  :commands (magit-status magit-get-current-branch)
  :custom
  (setq auto-revert-check-vc-info t)
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))



;;;; FLX
(use-package flx
  :straight t)
;;;; Helpful
(use-package helpful
  :straight t
  :defer 1)

;;; Projectile
(use-package projectile
  :straight t
  :defer 0.5
  :after general
  :config
  (defun my-projectile-project-find-function (dir)
    (let ((root (projectile-project-root dir)))
      (and root (cons 'transient root))))

  (with-eval-after-load 'project
    (add-to-list 'project-find-functions 'my-projectile-project-find-function))
  (projectile-mode))

;;; Workspaces
(use-package perspective
  :straight t
  :custom
  (persp-initial-frame-name "main")
  :config
  ;; Running `persp-mode' multiple times resets the perspective list...
  (unless (equal persp-mode t)
    (persp-mode)))
(use-package persp-projectile
  :after perspective
  :defer 0.5
  :straight t)
;;; Programming
;;;; Language Server Protocol
(use-package eglot
  :commands (eglot-ensure eglot)
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (js2-mode . eglot-ensure)
         (typescript-mode . eglot-ensure)
         (c-mode . eglot-ensure)
         (c++-mode . eglot-ensure)
         (rustic-mode . eglot-ensure)))
  
 

;;;; Treesitter
(use-package tree-sitter
  :straight t
  :defer 0.5
  :config
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
  (global-tree-sitter-mode))
(use-package tree-sitter-langs
  :straight t
  :after tree-sitter)

;;;; Code Completion
(use-package company
  :straight t
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-common-or-cycle)
         ("<backtab>" . company-select-previous))
  :config
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0.0)
  (setq company-minimum-prefix-length 1))

(use-package company-box
  :straight t
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-doc-enable nil))
  
;;; Code Snippets
(use-package yasnippet
  :straight t
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))
(use-package yasnippet-snippets
  :straight t
  :after yasnippet)

;;;; Brackets/Parenthesis
;;;;; Highlight Matching Brackets
(use-package paren
  :straight t
  :defer 2
  :config
  (set-face-attribute 'show-paren-match-expression nil :background "#363e4a")
  (show-paren-mode 1))
;;;;; Rainbow Brackets
(use-package rainbow-delimiters
  :straight t
  :hook (prog-mode . rainbow-delimiters-mode)
  :defer 2)
;;;;; Parinfer
(use-package parinfer-rust-mode
  :after evil
  :straight t
  :hook ((clojure-mode . parinfer-rust-mode)
         (emacs-lisp-mode . parinfer-rust-mode)
         (common-lisp-mode . parinfer-rust-mode)
         (scheme-mode . parinfer-rust-mode)
         (lisp-mode . parinfer-rust-mode)))


;;;; Error Checking
(use-package flycheck
  :straight t
  :hook (prog-mode . flycheck-mode)
  :config
  (defvar-local flycheck-eglot-current-errors nil)

  (defun flycheck-eglot-report-fn (diags &rest _)
    (setq flycheck-eglot-current-errors
          (mapcar (lambda (diag)
                    (save-excursion
                      (goto-char (flymake--diag-beg diag))
                      (flycheck-error-new-at (line-number-at-pos)
                                             (1+ (- (point) (line-beginning-position)))
                                             (pcase (flymake--diag-type diag)
                                               ('eglot-error 'error)
                                               ('eglot-warning 'warning)
                                               ('eglot-note 'info)
                                               (_ (error "Unknown diag type, %S" diag)))
                                             (flymake--diag-text diag)
                                             :checker 'eglot)))
                  diags))
    (flycheck-buffer))

  (defun flycheck-eglot--start (checker callback)
    (funcall callback 'finished flycheck-eglot-current-errors))

  (defun flycheck-eglot--available-p ()
    (bound-and-true-p eglot--managed-mode))

  (flycheck-define-generic-checker 'eglot
    "Report `eglot' diagnostics using `flycheck'."
    :start #'flycheck-eglot--start
    :predicate #'flycheck-eglot--available-p
    :modes '(prog-mode text-mode))

  (push 'eglot flycheck-checkers)

  (defun sanityinc/eglot-prefer-flycheck ()
    (when eglot--managed-mode
      (flycheck-add-mode 'eglot major-mode)
      (flycheck-select-checker 'eglot)
      (flycheck-mode)
      (flymake-mode -1)
      (setq eglot--current-flymake-report-fn 'flycheck-eglot-report-fn)))

  (add-hook 'eglot--managed-mode-hook 'sanityinc/eglot-prefer-flycheck))

  

;;;; Direnv
(use-package direnv
  :straight t
  :config
  (direnv-mode))
;;;; Languages
;;;;; Rust
(use-package rustic
  :straight t
  :defer 1)
;;;;; Nix
(use-package nix-mode
  :straight t
  :mode "\\.nix\\'")
;;;;; HTML/CSS
(use-package web-mode
  :straight t
  :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\)\\'"
  :config
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-attribute-indent-offset 2))
;;;;; JSON
(use-package json-mode
  :straight t
  :mode "\\.json\\'")
;;;;; Javascript
(use-package js2-mode
  :straight t
  :mode "\\.jsx?\\'"
  :config
  (setq js-indent-level 2))
;;;;; Typescript
(use-package typescript-mode
  :straight t
  :mode "\\.tsx?\\'"
  :config
  (setq typescript-indent-level 2))
;;;;; Haskell
(use-package haskell-mode
  :straight t
  :mode "\\.hs\\'")
;;;;; CMake
(use-package cmake-mode
  :defer 1
  :straight t)
;;; Org Mode
;;;; Configuration
(use-package org
  :straight t
  :defer 0.5
  :config
  (visual-line-mode 1)
  (setq org-agenda-files
        '(
          "~/Org/gtd.org"))
          
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline "~/Org/inbox.org" "Tasks")
                                 "* TODO %i%?")))
  (setq org-refile-targets '(("~/Org/gtd.org" :maxlevel . 3)))
  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "NEXT(w)" "PROJ" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-ellipsis " ▾")
  (setq org-hide-emphasis-markers t)
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-edit-src-content-indentation 2)
  (setq org-hide-block-startup nil)
  (setq org-src-preserve-indentation nil)
  (setq org-startup-folded 'content)
  (setq org-cycle-separator-lines 2))
;;;; Enable Org Bullets
(use-package org-superstar
  :straight t
  :hook (org-mode)
  :config
  (setq org-superstar-special-todo-items t)
  (org-superstar-mode))


(setq file-name-handler-alist temp--file-name-handler-alist)

;;; Org Mode
(use-package markdown-mode
  :straight t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(provide 'init)
;;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e3b2bad7b781a968692759ad12cb6552bc39d7057762eefaf168dbe604ce3a4b" "a3bdcbd7c991abd07e48ad32f71e6219d55694056c0c15b4144f370175273d16" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))
 '(mood-line-mode t))
(custom-set-faces)
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 

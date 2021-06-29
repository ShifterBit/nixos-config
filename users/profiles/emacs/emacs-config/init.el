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
(setq warning-minimum-level :error)
(setq comp-async-report-warnings-errors nil)


;;;; Make yes or no prompt simpler
(defalias 'yes-or-no-p 'y-or-n-p)

;;;; Always follow symlinks
(setq vc-follow-symlinks t)

(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6
      read-process-output-max (* 1024 1024)
      file-name-handler-alist nil)

;;;; Use UTF-8 by default
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)


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
;;; Packages
(straight-use-package 'unicode-fonts)
(straight-use-package 'dashboard)
(straight-use-package 'page-break-lines)
(straight-use-package 'smartparens)
(straight-use-package 'vertico)
(straight-use-package 'savehist)
(straight-use-package 'consult)
(straight-use-package 'marginalia)
(straight-use-package 'orderless)
(straight-use-package 'magit)
(straight-use-package 'projectile)
(straight-use-package 'flx)
(straight-use-package 'perspective)
(straight-use-package 'persp-projectile)
(straight-use-package 'eglot)
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
(straight-use-package 'corfu)
(straight-use-package 'eldoc-box)
(straight-use-package 'paren)
(straight-use-package 'smartparens)
(straight-use-package 'lispyville)
(straight-use-package 'flycheck)
(straight-use-package 'consult-flycheck)
(straight-use-package 'direnv)
(straight-use-package 'rustic)
(straight-use-package 'nix-mode)
(straight-use-package 'web-mode)
(straight-use-package 'json-mode)
(straight-use-package 'js2-mode)
(straight-use-package 'typescript-mode)
(straight-use-package 'haskell-mode)
(straight-use-package 'cmake-mode)
(straight-use-package 'esup)
(straight-use-package 'outshine)
(straight-use-package 'all-the-icons)
(straight-use-package 'doom-themes)
(straight-use-package 'mood-line)
(straight-use-package 'which-key)
(straight-use-package 'general)
(straight-use-package 'markdown-mode)
(straight-use-package 'org-superstar)
(straight-use-package 'mixed-pitch)
(straight-use-package 'visual-fill-column)
(straight-use-package 'evil)
(straight-use-package 'undo-fu)
(straight-use-package 'evil-collection)
(straight-use-package 'evil-nerd-commenter)
(straight-use-package 'evil-surround)
(straight-use-package 'evil-textobj-anyblock)


;;; Esup

(when (require 'esup nil 'noerror)
  (setq esup-depth 0))
  

;;; Emacs Dashboard
(when (require 'dashboard nil 'noerror)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-projects-switch-function 'projectile-persp-switch-project)
  (setq dashboard-set-init-info t)
  (setq dashboard-set-navigator t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-week-agenda t)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (agenda . 5)))
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (dashboard-setup-startup-hook))


;;; Outshine mode
(when (require 'outshine nil 'noerror)
  (define-key outshine-mode-map (kbd "<tab>") 'outshine-cycle)
  (define-key outshine-mode-map (kbd "<S-iso-leftab>") 'outshine-cycle-buffer))

;;; Appearance
(when (require 'all-the-icons nil 'noerror)
(setq all-the-icons-scale-factor 1.0))

;;;; Color Themes
(when (require 'doom-themes nil 'noerror)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-nord t)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
 
;; ;;;; Modeline
(when (require 'mood-line nil 'noerror)
(mood-line-mode))

;;; Keybindings
;;;; Which-Key
(when (require 'which-key nil 'noerror)
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

;;;; General Leader Keybindings
(when (require 'general nil 'noerror)
  (general-create-definer leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
(leader-key-def
    "p"   '(:ignore t :which-key "project")
    "pf"  '(projectile-find-file :which-key "find file")
    "pp"  '(projectile-persp-switch-project :which-key "switch project")
    "pi"  '(projectile-ag :which-key "search project symbols")
    "pF"  '(projectile-rg :which-key "search project")
    "pa"  '(projectile-add-known-project :which-key "add project")
    "pd"  '(projectile-remove-known-project :which-key "remove project")) 

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

(leader-key-def
    "f" '(:ignore t :which-key "files")
    "ff" '(find-file :which-key "find file")
    "fb" '(consult-buffer :which-key "find file")
    "fr" '(consult-recent-file :which-key "recent files"))

(leader-key-def
    "s" '(:ignore t :which-key "search")
    "ss" '(consult-isearch :which-key "ibuffer")
    "si" '(consult-line :which-key "buffer")
    "sd" '(dired-jump :which-key "directory")
    "sp" '(projectile-switch-project :which-key "projects"))

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

(leader-key-def
    "w"  '(:ignore t :which-key workspaces)
    "wb" '(persp-switch-to-buffer :which-key "switch buffer")
    "wn" '(persp-next :which-key "next workspace")
    "wk" '(persp-kill :which-key "delete workspace")
    "ws" '(persp-switch :which-key "switch workspace"))

(leader-key-def
      "o"   '(:ignore t :which-key "org mode")

      "oi"  '(:ignore t :which-key "insert")
      "oil" '(org-insert-link :which-key "insert link")

      "on"  '(org-toggle-narrow-to-subtree :which-key "toggle narrow")

      "oa"  '(org-agenda :which-key "status")
      "ot"  '(org-todo-list :which-key "todos")
      "oc"  '(org-capture t :which-key "capture")
      "ox"  '(org-export-dispatch t :which-key "export"))

(general-evil-setup t)
  (general-mmap
    "j" 'evil-next-visual-line
    "gc" 'evilnc-comment-operator
    "k" 'evil-previous-visual-line)

  (leader-key-def
    "e"   '(:ignore t :which-key "eval")
    "eb"  '(eval-buffer :which-key "eval buffer"))

  (leader-key-def
    :keymaps '(visual)
    "er" '(eval-region :which-key "eval region")))
  
;;;; Evil
(when (require 'evil)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-fu)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-mode 1)

  (when (require 'evil-nerd-commenter)
  (evilnc-default-hotkeys))
  (when (require 'evil-surround)
  (global-evil-surround-mode 1))
  (when (require 'evil-collection)
  (setq evil-collection-company-use-tng nil)  ;; Is this a bug in evil-collection?
  (evil-collection-init)
  (setq evil-collection-outline-bind-tab-p nil))
  (when (require 'undo-fu)
  (define-key evil-normal-state-map "u" 'undo-fu-only-undo)
  (define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo)))



;;;; Parenthesis
;;;;; Smart Parens
;; (add-hook prog-mode-hook #'smartparens-mode)

;;; Completion
;;;; Vertico
(when (require 'vertico nil 'noerror)
  (vertico-mode)
  (define-key vertico-map (kbd "C-j") 'vertico-next)
  (define-key vertico-map (kbd "C-k") 'vertico-previous)
  (define-key vertico-map (kbd "C-f") 'vertico-exit))

(savehist-mode)

;;;; Consult
(when (require 'consult nil 'noerror)
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-root-function #'projectile-project-root)
  (setq consult-preview-key nil))
  (if (featurep 'flycheck)

;;;; Marginalia
(marginalia-mode)
(when (require 'marginalia nil 'noerror)
  (setq-default marginalia-annotators '(marginalia-annotators-heavy))
  (marginalia-mode t))

;;;; Ordering
;;;;; Orderless
(when  (require 'orderless nil 'noerror)
  (savehist-mode)
  (setq completion-styles '(orderless)
          completion-category-defaults nil
          completion-category-overrides '((file (styles . (partial-completion))))
          orderless-component-separator "[ &]"
          selectrum-refine-candidates-function #'orderless-filter
          selectrum-highlight-candidates-function #'orderless-highlight-matches)
  (setq completion-styles '(orderless)))

;;;;; Magit
(when (require 'magit nil 'noerror)
  (setq auto-revert-check-vc-info t)
  (autoload #'magit-status "magit" nil t)
  (autoload #'magit-status "magit" nil t))

;;;; FLX

;;; Projectile
(when (require 'projectile)
  (defun my-projectile-project-find-function (dir)
    (let ((root (projectile-project-root dir)))
      (and root (cons 'transient root))))
  (with-eval-after-load 'project
    (add-to-list 'project-find-functions 'my-projectile-project-find-function))
  (projectile-mode)))


;;; Workspaces
(when (require 'perspective nil 'noerror) 
  (unless (equal persp-mode t)
    (persp-mode)))

;;; Programming
;;;; Language Server Protocol
(with-eval-after-load 'eglot
  (autoload #'eglot "eglot" nil t)
  (autoload #'eglot-ensure "eglot" nil t))
  (add-hook 'js2-mode-hook #'eglot-ensure)
  (add-hook 'typescript-mode-hook #'eglot-ensure)
  (add-hook 'c-mode-hook #'eglot-ensure)
  (add-hook 'c++-mode-hook #'eglot-ensure)

;;;; Treesitter
(global-tree-sitter-mode)

;;;; Code Completion
(with-eval-after-load 'corfu
  (setq corfu-cycle t)            ;; Enable cycling for `corfu-next/previous'
  (setq corfu-auto t)             ;; Enable auto completion
  (setq corfu-quit-at-boundary t) ;; Automatically quit at word boundary
  (setq corfu-quit-no-match t)    ;; Automatically quit if there is no match
  (define-key corfu-map (kbd "TAB") 'corfu-next)
  (define-key corfu-map (kbd "<tab>") 'corfu-next)
  (define-key corfu-map (kbd "S-TAB") 'corfu-next)
  (define-key corfu-map (kbd "<backtab>") 'corfu-next))
  (add-hook 'prog-mode-hook #'corfu-mode)
  (add-hook 'shell-mode-hook #'corfu-mode)
  (add-hook 'eshell-mode-hook #'corfu-mode)

;;;; Documentation
(add-hook 'eldoc-mode-hook #'eldoc-box-hover-at-point-mode)

;;;; Brackets/Parenthesis
;;;;; Highlight Matching Brackets
(when (require 'paren nil 'noerror)
  (set-face-attribute 'show-paren-match-expression nil :background "#363e4a")
  (show-paren-mode 1))

;;;;; Lispyville
(add-hook 'emacs-lisp-mode-hook #'lispyville-mode)

;;;; Error Checking with Flycheck
(with-eval-after-load 'flycheck

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

  (defun eglot-prefer-flycheck ()
    (when eglot--managed-mode
      (flycheck-add-mode 'eglot major-mode)
      (flycheck-select-checker 'eglot)
      (flycheck-mode)
      (flymake-mode -1)
      (setq eglot--current-flymake-report-fn 'flycheck-eglot-report-fn)))

  (add-hook 'eglot--managed-mode-hook 'eglot-prefer-flycheck))
  (add-hook 'prog-mode-hook #'flycheck-mode)

;;;; Direnv
(direnv-mode)

;;;; Languages
;;;;; Rust
(with-eval-after-load 'rustic
    (setq rustic-format-on-save t)
    (setq rustic-lsp-client 'eglot))

;;;;; HTML/CSS
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(setq-default web-mode-code-indent-offset 2)
(setq-default web-mode-markup-indent-offset 2)
(setq-default web-mode-attribute-indent-offset 2)

;;;;; JSON
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

;;;;; Javascript
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-mode))
(setq js-indent-level 2)

;;;;; Typescript
(add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-mode))
(setq typescript-indent-level 2)
(
;;; Markdown
(add-to-list 'auto-mode-alist
            '("README\\.md\\'" . gfm-mode))
(add-to-list 'auto-mode-alist
            '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist
            '("\\.markdown\\'" . markdown-mode))
;;; Org
;; Turn on indentation and auto-fill mode for Org files
(defun org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil)
  (diminish org-indent-mode))


(defun org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

;;;; Enable Org Mode
(with-eval-after-load 'org
  (setq org-agenda-files
        '("~/Org/projects.org"
          "~/Org/todos.org"
          ))
  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "NEXT(w)" "|" "DONE(d)" "CANCELLED(c)")))
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
  (setq org-cycle-separator-lines 2)
  (add-hook 'org-mode-hook #'org-mode-setup)
  (add-hook 'org-mode-hook #'mixed-pitch-mode)
  (add-hook 'org-mode-hook #'org-superstar-mode)
  (add-hook 'org-mode-hook #'org-mode-visual-fill)
  (setq org-superstar-special-todo-items t))



(setq gc-cons-threshold 16777216
             gc-cons-percentage 0.1)
(setq file-name-handler-alist temp--file-name-handler-alist)
(provide 'init)
;;; init.el ends here

 

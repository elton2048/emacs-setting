(load-file "~/.emacs.d/check.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(bmkp-last-as-first-bookmark-file "c:\\Users\\Dell\\AppData\\Roaming\\.emacs.d\\bookmarks")
 '(custom-enabled-themes (quote (tango-dark)))
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(evil-overriding-maps
   (quote
	((Buffer-menu-mode-map)
	 (color-theme-mode-map)
	 (comint-mode-map)
	 (compilation-mode-map)
	 (grep-mode-map)
	 (dictionary-mode-map)
	 (ert-results-mode-map . motion)
	 (Info-mode-map . motion)
	 (speedbar-key-map)
	 (speedbar-file-key-map)
	 (speedbar-buffers-key-map)
	 (anaconda-mode-map))))
 '(menu-bar-mode t)
 '(paradox-github-token t)
 '(python-shell-interpreter "C:/Users/Dell/Anaconda3/Scripts/jupyter-console.exe")
 '(python-shell-interpreter-args "")
 '(tool-bar-mode nil)
 '(web-mode-script-padding 0))

;; Set color theme for Emacs
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "antique white"))))
 '(company-scrollbar-fg ((t (:background "SlateBlue2"))))
 '(company-tooltip ((t (:background "gray67" :foreground "black"))))
 '(company-tooltip-selection ((t (:background "cadet blue" :foreground "snow"))))
 '(mode-line ((t :foreground "#505050" :background "#D3D3D3" :inverse-video nil :box (quote (:line-width 60 :color "#FFF000" :style nil))))))

;; Require MELPA packages
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; Override the original key binding or setting for personal usage
;; Scroll the page when 8 line before the cursor. The scroll is not reseted to the center.
(setq scroll-conservatively 101)

(setq scroll-margin 8)
(setq initial-frame-alist
	  '((top . 30) (left . 1) (width . 140) (height . 40)))
(global-set-key "\C-x\C-b" 'buffer-menu)
(setq-default indent-tabs-node nil)
(setq-default tab-width 4)
(setq indent-line-funtion 'insert-tab)
(setq org-log-done 'time)
(global-linum-mode 1)
(global-set-key (kbd "C-M-x") 'helm-M-x)
(display-time)

;; Require plugin undo-tree
(require 'undo-tree)

;; Rainbow mode
(define-globalized-minor-mode global-rainbow-mode
  rainbow-mode
  (lambda () (rainbow-mode t)))
(global-rainbow-mode t)

;; Bookmark+ mode
(require 'bookmark+)


;; Require highlight parenthese
(require 'highlight-parentheses)
;; Use it for all buffers
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; Set color theme for Emacs
(require 'color-theme)

;; Open recent file at the beginning
(require 'recentf)
(recentf-mode 1)
;; (init-open-recentf)

;; Evil setting, Vim plugin for Emacs
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
(define-key evil-motion-state-map (kbd "M-.") nil)

;; Helm mode
(require 'helm-config)
(helm-mode 1)

;; Set to enable web mode plugin
;; (load "~/web-mode")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

;; Use flycheck to check js
(require 'flycheck)
(add-hook 'js-mode-hook
          (lambda () (flycheck-mode t)))
(require 'avy-flycheck)

(flycheck-define-checker jsxhint-checker
  "A JSX syntax and style checker based on JSXHint."

  :command ("jsxhint" source)
  :error-patterns
  ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
  :modes (web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              ;; enable flycheck
              (flycheck-select-checker 'jsxhint-checker)
              (flycheck-mode))))

(require 'sass-mode)

;; Numbered windows
(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

;; (require 'multiple-cursors)
;; Anaconda-mode setting
(add-hook 'python-mode-hook #'anaconda-mode)
(with-eval-after-load "anaconda"
  (define-key anaconda-mode-map (kbd "M-.") #'anaconda-mode-find-definitions)
)

;; Yasnippet setting
(require 'yasnippet)
(add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'html-mode)))
(yas-global-mode 1)
(yas-reload-all 1)

;; YAML mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Key setting
(define-key global-map [f12] 'helm-swoop)
(define-key global-map [C-f12] 'helm-multi-swoop)
(define-key evil-motion-state-map (kbd "SPC") #'avy-goto-word-1)
(define-key evil-motion-state-map (kbd "M-SPC") #'avy-goto-char)

;; Mode setting for using Evil
(loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
                              (nrepl-mode . insert)
                              (pylookup-mode . emacs)
                              (comint-mode . normal)
                              (shell-mode . insert)
                              (git-commit-mode . insert)
                              (git-rebase-mode . emacs)
                              (term-mode . emacs)
                              (grep-mode . emacs)
                              (bc-menu-mode . emacs)
                              (magit-branch-manager-mode . emacs)
                              (rdictcc-buffer-mode . emacs)
                              (dired-mode . emacs)
                              (neotree-mode . emacs)
                              (wdired-mode . normal)
							  (help-mode . emacs)
							  (paradox-menu-mode . emacs))
      do (evil-set-initial-state mode state))
(add-hook 'after-init-hook 'global-company-mode)

(defun my-web-mode-hook()
  "Hook for indentation."
  (setq web-mode-indent-offset 0)
  (setq-local electric-indent-chars
			  (append "{}():;," electric-indent-chars))
  )
(add-hook 'web-mode-hook 'my-web-mode-hook)
(add-hook 'web-mode-hook 'electric-pair-mode)

(loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
                              (nrepl-mode . insert)
                              (pylookup-mode . emacs)
                              (comint-mode . normal)
                              (shell-mode . insert)
                              (git-commit-mode . insert)
                              (git-rebase-mode . emacs)
                              (term-mode . emacs)
                              (grep-mode . emacs)
                              (bc-menu-mode . emacs)
                              (magit-branch-manager-mode . emacs)
                              (rdictcc-buffer-mode . emacs)
                              (dired-mode . emacs)
                              (neotree-mode . emacs)
                              (wdired-mode . normal))
      do (evil-set-initial-state mode state))

;; JAVA setting
;; (require 'company)
;; (require 'company-emacs-eclim)
;; (company-emacs-eclim-setup)
;; (setq help-at-pt-display-when-idle t)
;; (setq help-at-pt-timer-delay 0.1)
;; (help-at-pt-set-timer)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(defvar universal-coding-system-env-list '("PYTHONIOENCODING")
  "List of environment variables \\[universal-coding-system-argument] should set")

(defadvice universal-coding-system-argument (around provide-env-handler activate)
  "Augments \\[universal-coding-system-argument] so it also sets environment variables

Naively sets all environment variables specified in
`universal-coding-system-env-list' to the literal string
representation of the argument `coding-system'.

No guarantees are made that the environment variables set by this advice support
the same coding systems as Emacs."
  (let ((process-environment (copy-alist process-environment)))
    (dolist (extra-env universal-coding-system-env-list)
      (setenv extra-env (symbol-name (ad-get-arg 0))))
    ad-do-it))


;; Load the test Emacs lisp
(load-file "~/.emacs.d/test.el")
